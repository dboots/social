import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Social/widgets/common/bottom-nav.dart';
import 'package:Social/widgets/common/line-item.dart';
import 'package:Social/widgets/common/page-title.dart';
import 'package:Social/services/account.dart';
import 'package:Social/services/user.dart';
import 'package:Social/models/account.dart';
import 'package:Social/models/user.dart';
import 'package:Social/widgets/common/alert-overlay.dart';

class AddFriendPage extends StatefulWidget {
  AddFriendPage() : super();

  @override
  _AddFriendPageState createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  List<Contact> _contacts = [];
  List<Account> _socialContacts = [];
  AccountService _accountService = AccountService();
  User _user;
  UserService _userService = UserService();
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _getContacts();

    Account account = _accountService.account;

    setState(() {
      _user = account.user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getBody();
  }

  _getBody() {
    return Scaffold(
        body: Container(
            decoration: new BoxDecoration(color: Colors.white),
            child: SafeArea(
                child: Column(children: <Widget>[
              PageTitle(label: 'ADD FRIEND'),
              Expanded(
                  child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  Contact contact = _contacts.elementAt(index);
                  return LineItem(
                      label: contact.displayName, widgets: _getIcons(contact));
                },
              )),
              BottomNav(
                  leftIcon: FontAwesomeIcons.arrowLeft,
                  leftAction: () {
                    Navigator.pop(context);
                  })
            ]))));
  }

  List<Widget> _getIcons(Contact contact) {
    List<Widget> icons = List<Widget>();
    Icon contactIcon = Icon(FontAwesomeIcons.plusCircle, size: 18.0);

    // if formattedPhone in _user.requests || _user.friends then icon = remove
    contact.phones.forEach((phone) {
      String formattedPhone =
          phone.value.replaceAll(RegExp(r'\D+'), '');
      Iterable<Account> socialContact =
          _socialContacts.where((c) => c.phone == formattedPhone);

      if (socialContact.length > 0) {
        User socialContactUser = socialContact.elementAt(0).user;
        AlertOverlay alertOverlay = AlertOverlay(
            title: 'ADD FRIEND',
            body: 'Would you like to send a request to ' +
                contact.displayName +
                '?',
            buttonLabel: 'OK',
            buttonAction: () async {
              bool success =
                  await _userService.sendFriendRequest(socialContactUser.id);

              if (success) {
                setState(() {
                  _socialContacts
                      .firstWhere((x) => x.phone == formattedPhone)
                      .user
                      .requests
                      .add(_user.id);
                });
              }
            });
        if (socialContactUser.requests.contains(_user.id)) {
          contactIcon = Icon(FontAwesomeIcons.timesCircle, size: 18.0);

          alertOverlay = AlertOverlay(
              title: 'REMOVE FRIEND',
              body: 'Would you like to remove ' +
                  contact.displayName +
                  ' from your friends?',
              buttonLabel: 'OK',
              buttonAction: () async {
                bool success = await _userService
                    .cancelFriendRequest(socialContactUser.id);

                if (success) {
                  setState(() {
                    _socialContacts
                        .firstWhere((x) => x.phone == formattedPhone)
                        .user
                        .requests = [];
                  });
                }
              });
        }

        icons.add(GestureDetector(
            onTap: () {
              alertOverlay.showOverlay(context);
            },
            child: contactIcon));
      }
    });

    return icons;
  }

  _getContacts() async {
    List<Contact> contacts = await _userService.initContacts();
    List<Account> socialContacts =
        await _accountService.initSocialContacts(contacts);

    setState(() {
      _contacts = contacts;
      _socialContacts = socialContacts;
      _isReady = true;
    });
  }
}

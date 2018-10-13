import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Social/widgets/common/bottom-nav.dart';
import 'package:Social/widgets/common/line-item.dart';
import 'package:Social/widgets/common/page-title.dart';

class AddFriendPage extends StatefulWidget {
  AddFriendPage() : super();

  @override
  _AddFriendPageState createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  Iterable<Contact> _contacts;
  bool _isReady = false;

  _getContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
		List<Contact> contactsList  = contacts.toList();

		contactsList.sort((Contact a, Contact b) {
			return a.displayName.compareTo(b.displayName);
		});

    setState(() {
      _isReady = true;
      _contacts = contactsList;
    });
  }

  @override
  void initState() {
    super.initState();
    _getContacts();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) return Container();
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
    return [
      Icon(FontAwesomeIcons.envelope, size: 18.0),
    ];
  }
}

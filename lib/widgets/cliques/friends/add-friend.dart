import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Social/widgets/common/utils.dart';
import 'package:Social/widgets/common/bottom-nav.dart';

class AddFriendPage extends StatefulWidget {
  AddFriendPage() : super();

  @override
  _AddFriendPageState createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  Iterable<Contact> _contacts;
  bool _isReady = false;

  _refreshContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();

    setState(() {
      _isReady = true;
      _contacts = contacts;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshContacts();
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
              Container(
                  padding: EdgeInsets.all(25.0),
                  child: Utils.getTitle('ADD FRIEND', null)),
              Expanded(
                  child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                    child: Row(children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(right: 10.0),
                          child: CircleAvatar(
                              radius: 15.0,
                              backgroundColor: Color(0xFFFF0000),
                              child: Text(
                                  _contacts
                                      .elementAt(index)
                                      .givenName
                                      .substring(0, 1),
                                  style: TextStyle(color: Colors.white)))),
                      Expanded(
                        child: Text(
                            _contacts
                                .elementAt(index)
                                .givenName
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(
                                fontSize: 16.0, color: Color(0xFF666666))),
                      ),
                      IconButton(
                          iconSize: 24.0,
                          padding: const EdgeInsets.all(0.0),
                          icon: Icon(FontAwesomeIcons.timesCircle,
                              color: Color(0xFFCCCCCC)),
                          onPressed: () {}),
                      IconButton(
                          iconSize: 24.0,
                          padding: const EdgeInsets.all(0.0),
                          icon: Icon(FontAwesomeIcons.timesCircle,
                              color: Color(0xFFCCCCCC)),
                          onPressed: () {})
                    ]),
                  );
                },
              )),
              BottomNav().build(
                  leftIcon: FontAwesomeIcons.arrowLeft,
                  leftAction: () {
                    Navigator.pop(context);
                  })
            ]))));
  }
}

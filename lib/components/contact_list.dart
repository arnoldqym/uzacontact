import 'package:flutter/material.dart';
import 'package:uzacontact/components/contact_avatar.dart';
import 'package:uzacontact/pages/view_contact.dart';
import 'package:uzacontact/utils/app_uzacontact.dart';

// ignore: must_be_immutable
class ContactsList extends StatelessWidget {
  final List<AppContact> contacts;
  final Function() reloadContacts;
  const ContactsList(
      {super.key, required this.contacts, required this.reloadContacts});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          AppContact contact = contacts[index];

          return ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ContactDetails(
                          contact,
                          onContactDelete: (AppContact contact_) {
                            reloadContacts();
                            Navigator.of(context).pop();
                          },
                          onContactUpdate: (AppContact contact_) {
                            reloadContacts();
                          },
                        )));
              },
              title: Text(contact.info.displayName ?? ""),
              leading: ContactAvatar(contact, 36));
        },
      ),
    );
  }
}

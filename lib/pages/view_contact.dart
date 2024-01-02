import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:uzacontact/components/contact_avatar.dart';
import 'package:uzacontact/utils/app_uzacontact.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails(this.contact,
      {super.key,
      required this.onContactUpdate,
      required this.onContactDelete});

  final AppContact contact;
  final Function(AppContact) onContactUpdate;
  final Function(AppContact) onContactDelete;
  @override
  ContactDetailsState createState() => ContactDetailsState();
}

class ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    List<String> actions = <String>['Edit', 'Delete'];

    showDeleteConfirmation() {
      Widget cancelButton = TextButton(
        child: const Text('Cancel'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget deleteButton = TextButton(
        child: const Text('Delete'),
        onPressed: () async {
          await ContactsService.deleteContact(widget.contact.info);
          widget.onContactDelete(widget.contact);
          if (!context.mounted) return;
          Navigator.of(context).pop();
        },
      );
      AlertDialog alert = AlertDialog(
        title: const Text('Delete contact?'),
        content: const Text('Are you sure you want to delete this contact?'),
        actions: <Widget>[cancelButton, deleteButton],
      );

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          });
    }

    onAction(String action) async {
      switch (action) {
        case 'Edit':
          try {
            Contact updatedContact =
                await ContactsService.openExistingContact(widget.contact.info);
            setState(() {
              widget.contact.info = updatedContact;
            });
            widget.onContactUpdate(widget.contact);
          } on FormOperationException catch (e) {
            switch (e.errorCode) {
              case FormOperationErrorCode.FORM_OPERATION_CANCELED:
              case FormOperationErrorCode.FORM_COULD_NOT_BE_OPEN:
              case FormOperationErrorCode.FORM_OPERATION_UNKNOWN_ERROR:
              case null:
            }
          }
          break;
        case 'Delete':
          showDeleteConfirmation();
          break;
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Center(child: ContactAvatar(widget.contact, 100)),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PopupMenuButton(
                        onSelected: onAction,
                        itemBuilder: (BuildContext context) {
                          return actions.map((String action) {
                            return PopupMenuItem(
                              value: action,
                              child: Text(action),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(shrinkWrap: true, children: <Widget>[
                ListTile(
                  title: const Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  trailing: Text(
                    widget.contact.info.givenName ?? "",
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    "Family name",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  trailing: Text(
                    widget.contact.info.familyName ?? "",
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    const ListTile(
                        title: Text(
                      "Phones",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )),
                    Column(
                      children: widget.contact.info.phones!
                          .map(
                            (i) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: ListTile(
                                title: Text(
                                  i.label ?? "",
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                trailing: Text(
                                  i.value ?? "",
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    )
                  ],
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}

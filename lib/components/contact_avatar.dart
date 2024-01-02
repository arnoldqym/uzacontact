import 'package:uzacontact/utils/app_uzacontact.dart';
import 'package:uzacontact/utils/color_gradient.dart';
import 'package:flutter/material.dart';

class ContactAvatar extends StatelessWidget {
  const ContactAvatar(this.contact, this.size, {super.key});
  final AppContact contact;
  final double size;

  get utf8 => null;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          shape: BoxShape.circle, gradient: getColorGradient(contact.color)),
      child: (contact.info.avatar != null && contact.info.avatar!.isNotEmpty)
          ? CircleAvatar(
              backgroundImage: MemoryImage(contact.info.avatar!),
            )
          : CircleAvatar(
              child: Text(contact.info.initials(),
                  style: const TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.transparent)),
            ),
    );
  }
}

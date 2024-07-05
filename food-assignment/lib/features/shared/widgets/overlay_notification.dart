import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

showTopOverlayNotification(
    {String title = '',
    IconData icon = Icons.check_circle,
    Color color = Colors.green}) {
  return showSimpleNotification(
      SizedBox(
        height: 50,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Icon(
                icon,
                color: color,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 6,
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ),
          ],
        ),
      ),
      background: Colors.white);
}

showTopOverlayNotificationError({String title = ''}) {
  return showSimpleNotification(
      SizedBox(
        height: 50,
        width: double.infinity,
        child: Row(
          children: [
            const Expanded(
              flex: 1,
              child: Icon(
                Icons.warning_outlined,
                color: Colors.red,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 6,
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ),
          ],
        ),
      ),
      background: Colors.white);
}

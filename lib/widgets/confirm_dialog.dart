import 'package:flutter/material.dart';

AlertDialog confirmationDialog(BuildContext context) => AlertDialog(
  title: const Text('Do you want to exit this page?'),
  actions: <Widget>[
    TextButton(
      style: TextButton.styleFrom(
        textStyle: Theme.of(context).textTheme.labelLarge,
      ),
      child: const Text('Go Back'),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    ),
    TextButton(
      style: TextButton.styleFrom(
        textStyle: Theme.of(context).textTheme.labelLarge,
      ),
      child: const Text('Confirm'),
      onPressed: () {
        Navigator.of(context).pop(true);
      },
    ),
  ],
);

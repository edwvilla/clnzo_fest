import 'package:clnzo_fest/controller.dart';
import 'package:flutter/material.dart';

addIncident(BuildContext context) {
  final descriptionController = TextEditingController();
  final urlController = TextEditingController();

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar incidente'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                ),
              ),
              TextField(
                controller: urlController,
                decoration: const InputDecoration(
                  labelText: 'URL',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Controller().addIncident(
                  descriptionController.text,
                  urlController.text,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Incidente agregado'),
                  ),
                );

                Navigator.of(context).pop();
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      });
}

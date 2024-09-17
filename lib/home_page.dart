import 'package:clnzo_fest/add_incident_modal.dart';
import 'package:clnzo_fest/controller.dart';
import 'package:clnzo_fest/incident.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/incidents');
            },
            child: Text(
              'Lista de incidentes',
              style: TextStyle(
                fontSize: 20,
                color: Colors.red.shade800,
              ),
            ),
          )
        ],
      ),
      body: StreamBuilder<Incident>(
          stream: Controller().lastIncident,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final incident = snapshot.data as Incident;

            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Rato sin incidentes',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    Controller().lastIncidentMessage(incident.time),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => addIncident(context),
                    child: const Text('Reportar incidente',
                        style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

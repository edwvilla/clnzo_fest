import 'package:clnzo_fest/controller.dart';
import 'package:clnzo_fest/incident.dart';
import 'package:flutter/material.dart';

class IncidentesPage extends StatelessWidget {
  const IncidentesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder(
        stream: Controller().incidents,
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

          final incidents = snapshot.data as List<Incident>;

          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 100,
              vertical: 50,
            ),
            children: [
              const Text(
                'Lista de incidentes',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Divider(),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: incidents.length,
                itemBuilder: (context, index) {
                  final incident = incidents[index];

                  return ListTile(
                    title: Text(incident.description),
                    subtitle:
                        Text(Controller().lastIncidentMessage(incident.time)),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

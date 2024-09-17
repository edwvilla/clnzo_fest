import 'package:clnzo_fest/incident.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Controller {
  static final Controller _controller = Controller._internal();
  factory Controller() => _controller;
  Controller._internal();

  String lastIncidentMessage(DateTime lastIncidentTime) {
    final currentTime = DateTime.now();
    final difference = currentTime.difference(lastIncidentTime);

    if (difference.inMinutes < 1) {
      return 'Hace ratito';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutos';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} horas';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} días';
    } else if (difference.inDays < 30) {
      return '${difference.inDays ~/ 7} semanas';
    } else {
      return 'hace mucho tiempo';
    }
  }


  Stream<List<Incident>> get incidents {
    return FirebaseFirestore.instance.collection('incidents').orderBy('when', descending: true).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Incident(
          id: doc.id,
          description: doc['description'],
          url: doc['url'],
          time: doc['when'].toDate(),
        );
      }).toList();
    });
  }


  Stream<Incident> get lastIncident {
    return FirebaseFirestore.instance.collection('incidents').orderBy('when', descending: true).limit(1).snapshots().map((snapshot) {
      final doc = snapshot.docs.first;
      return Incident(
        id: doc.id,
        description: doc['description'],
        url: doc['url'],
        time: doc['when'].toDate(),
      );
    });
  }

  Future<void> addIncident(String description, String url) {
    return FirebaseFirestore.instance.collection('incidents').add({
      'description': description,
      'url': url,
      'when': DateTime.now(),
    });
  }
}
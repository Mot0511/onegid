import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onegid/features/map/map.dart';
import 'package:onegid/repositories/base_repository.dart';

class ReviewsRepository extends FirebaseRepository {

  void addReview(String placeUri, String author, String text) async {
    final uri = placeUri.replaceAll('://', '~#').replaceAll('=', '\$');

    final review_data = {
      'author': author,
      'comment': text,
      'create_datetime': Timestamp.fromDate(DateTime.now())
    };

    final ref = db.collection('reviews').doc(uri);
    final snap = await ref.get();

    if (snap.exists) {
      final data = snap.data();
      int review_number = 0;
      for (var i in data!.entries) {
        review_number += 1;
      }
      ref.update({
        'review$review_number': review_data,
      });
    } else {
      db.collection('reviews').doc(uri).set({
        'review0': review_data
      });
    }
  }

  Future<List<Review>?> getReviews(Place place) async {
    final uri = place.uri?.replaceAll('://', '~#').replaceAll('=', '\$');
    final snap = await db.collection('reviews').doc(uri).get();
    
    if (snap.exists) {
      final data = snap.data();

      final List<Review> res = [];
      for (var entry in data!.entries) {
        res.add(
          Review(placeUri: (uri as String), text: entry.value['comment'], author: entry.value['author'], time: DateTime.fromMicrosecondsSinceEpoch(entry.value['create_datetime'].microsecondsSinceEpoch))
        );
      }
      return res;
    } else {
      return null;
    }
  }
}
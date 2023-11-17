import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_pulse/models/mood.dart';

class MoodService{

  static final CollectionReference moodsCollection =
  FirebaseFirestore.instance.collection('moods');

  static Future<List<Mood>> getAllMoods()async {
    List<Mood> moods = [];
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection(
          'moods').get();
      for (var doc in querySnapshot.docs) {
        Mood mood = Mood.fromMap(doc.data());
        moods.add(mood);
        print(mood.mood);
      }
    }on FirebaseException catch(e){
      print(e.message);
    }
    return moods;
  }

  static Future<List<Mood>> getMoodsByFaculty(String faculty)async {
    List<Mood> moods = [];
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection(
          'moods').where('faculty', isEqualTo: faculty).get();
      for (var doc in querySnapshot.docs) {
        Mood mood = Mood.fromMap(doc.data());
        moods.add(mood);
        print(mood.mood);
      }
    }on FirebaseException catch(e){
      print(e.message);
    }
    return moods;
  }


  static Future<void> addMood(Mood mood, String userId) async {
    try {
      await moodsCollection.doc(userId).set(mood.toMap());
      print(mood.toMap());
      print("mood : ${mood.mood}");
      print(userId);
    } on FirebaseException catch (e) {
      print(e.message);
    }
    // await moodsCollection.doc(userId).set(mood.toMap());
  }

  //add mood to local storage via shared preferences [mood]

}
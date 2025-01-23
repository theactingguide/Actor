import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:actor/View/Home/Homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homecontroller extends GetxController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final TextEditingController usernamecontroller = TextEditingController();
  RxString imageurl = "".obs;

  pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      print(result);
      List<PlatformFile> unin8list = await result.files;
      imageurl.value =
          await uploadImage(unin8list.first.bytes!, unin8list.first.name);
      print(imageurl.value);
    }
  }

  String? validateusername() {
    if (usernamecontroller.text.isEmpty) {
      return "Enter a username";
    }
    return null;
  }

  Future<String> uploadImage(Uint8List filebyte, String fileName) async {
    try {
      print("Uploading...");
      final ref =
          _firebaseStorage.ref().child('actor').child('images').child(fileName);
      print("Uploading to reference...");
      await ref.putData(
        filebyte,
        SettableMetadata(contentType: 'image/webp'),
      );
      print("File uploaded. Fetching download URL...");
      String downloadUrl = await ref.getDownloadURL();
      print("Download URL: $downloadUrl");
      return downloadUrl; // Return the URL properly
    } catch (e) {
      print("Error during upload: ${e.toString()}");
      return ""; // Return an empty string in case of error
    }
  }

  submitusername() async {
    try {
      // First, validate if the username is unique
      bool? isunique = await validateUniqueUsername();
      print(isunique);

      if (!isunique!) {
        print("User Exist");
        Get.snackbar("Error", "User Already Exist");
        return;
      }
      print(imageurl.value);
      await _firestore
          .collection("Actors")
          .doc(FirebaseAuth.instance.currentUser!.email)
          .set({
        'username': usernamecontroller.text,
        'profilephotourl': imageurl.value
      });

      Get.to(() => Homescreen());

      print("Username submitted successfully");
    } catch (e) {
      print("Error occurred: $e");
      Get.snackbar("Error",
          "An error occurred while submitting the username. Please try again.");
    }
  }

  Future<bool?> validateUniqueUsername() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Actors')
          .where('username', isEqualTo: usernamecontroller.text.trim())
          .get();

      if (querySnapshot.docs.isEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error checking username uniqueness: $e");
    }
    return false;
  }
}

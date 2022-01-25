import 'package:flutter/material.dart';
import 'package:gestionuser/Pages/BaccourPage/story/model/Story.dart';
import 'package:gestionuser/Pages/BaccourPage/utility/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';
Image image;
String imageKeyValue;
loadImageFromPrefs1() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
   imageKeyValue = prefs.getString("img");
  if (imageKeyValue != null) {
    final imageString = await ImageSharedPrefs.loadImageFromPrefs();

      image = ImageSharedPrefs.imageFrom64BaseString(imageString);

  }
}
final stories = [
  Story(
    mediaType: MediaType.image,
    url: "https://resize2.prod.docfr.doc-media.fr/rcrop/380,288,center-middle/img/var/doctissimo/storage/images/fr/www/psychologie/tests-de-personnalite/tests-de-caractere/etes-vous-une-personne-positive/4473269-3-fre-FR/Etes-vous-une-personne-positive.jpg",
    caption: 'Check this out',
    date: '',
  ),

];

final stories2 = [
  Story(
    mediaType: MediaType.image,
    url: 'https://images.unsplash.com/photo-1593642532744-d377ab507dc8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80',
    caption: 'Mindblowing',
    date: '',
  ),


];

import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

Text mainTitle() => const Text("Instagram",style: TextStyle(fontFamily: "mainfont",fontSize: 40,color: Colors.black,));

Icon reeelsIcon() => const Icon(Icons.border_all_sharp,color: Colors.black);

Icon favoriteIcon() => const Icon(Icons.favorite_border_outlined,color: Colors.black);

Icon messageIcon() => const Icon(Icons.messenger_outline_outlined,color: Colors.black);







final navbarstate= StateProvider<int>((ref) {
  return 0;
});

final textInstaProvider=StateProvider<Widget>(((ref) {
  return mainTitle();
}));

final instaIconReels=StateProvider<Widget>(((ref) {
  return reeelsIcon();
}));

final instaIconFavorite=StateProvider<Widget>(((ref) {
  return favoriteIcon();
}));

final instaIconMessage=StateProvider<Widget>(((ref) {
  return messageIcon();
}));










class UserClass{
  final String ID;
  String kullaniciAdi;
  String kullaniciGenelAdi;
  String genelOzellik;
  final String resimName;
  UserClass(this.ID, this.kullaniciAdi, this.kullaniciGenelAdi, this.genelOzellik,{this.resimName=""});
  
}

class OutherUserClass{
  final String ID;
  String kullaniciAdi;
  String kullaniciGenelAdi;
  String genelOzellik;
  OutherUserClass(this.ID, this.kullaniciAdi, this.kullaniciGenelAdi, this.genelOzellik);
  
}

class ShareUserOnPost{
  final Function() onCommentTap;
  final Function() onShareTap;
  final Function() onSaveTap;
  final Function() onLikeTap;
  final String imgPath;
  final OutherUserClass userClass;
  final String circilePath;

  ShareUserOnPost(this.onCommentTap, this.onShareTap, this.onSaveTap, this.onLikeTap, this.imgPath, this.userClass, this.circilePath);

}




class UserClass2{
  final String imgPath;
  final String userName;
  final DateTime shareTime;
  UserClass2(this.imgPath, this.userName, this.shareTime);
}


class ShareUserClass extends UserClass2{
  ShareUserClass(imgPath, userName,shareTime):super(imgPath,userName,shareTime);
}

class UserClass{
  final String ID;
  String kullaniciAdi;
  String kullaniciGenelAdi;
  String genelOzellik;
  final String resimName;
  UserClass(this.ID, this.kullaniciAdi, this.kullaniciGenelAdi, this.genelOzellik,{this.resimName=""});
  
}
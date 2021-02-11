class SlideModel {
  String title;
  String desc;
  String imagePath;
  SlideModel({this.desc, this.imagePath, this.title});

  void setImageassetPath(String getImage) {
    imagePath = getImage;
  }

  void setTitle(String gettitle) {
    title = gettitle;
  }

  void setDesc(String getdesc) {
    desc = getdesc;
  }

  String getImage() {
    return imagePath;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }
}

List<SlideModel> getSlide() {
  List<SlideModel> slides = new List<SlideModel>();
  SlideModel slideModel = new SlideModel();

  //1
  slideModel.setImageassetPath("assets/images/googlepay.png");
  slideModel.setTitle('Title 1');
  slideModel.setDesc(
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industrys standard dummy text ever since the 1500s');
  slides.add(slideModel);

  slideModel = new SlideModel();

  //2
  slideModel.setImageassetPath("assets/images/googlepay.png");
  slideModel.setTitle('Title 2');
  slideModel.setDesc(
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industrys standard dummy text ever since the 1500s');
  slides.add(slideModel);

  slideModel = new SlideModel();

  //3
  slideModel.setImageassetPath("assets/images/googlepay.png");
  slideModel.setTitle('Title 3');
  slideModel.setDesc(
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.');
  slides.add(slideModel);

  return slides;
}

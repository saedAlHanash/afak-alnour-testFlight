import 'dart:ui';

class SliderObject {
  String image;
  Color color;

  SliderObject(this.image,this.color);
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;
  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
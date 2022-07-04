import 'package:objectbox/objectbox.dart';

@Entity()
class MyFeedModel {
  int id = 0;
  String sectionId;

  MyFeedModel({required this.sectionId});
}
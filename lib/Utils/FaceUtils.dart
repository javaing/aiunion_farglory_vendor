
import '../datamodel/ServerFaceType.dart';
import '../datamodel/ServerSetting.dart';

List<String> parseFaceTypeName(List<FaceType> result) {
  var faces =  <String>[];
  result.forEach((element) {
    faces.add(element.name!.toString());
  });
  return faces;
}

List<String> parseSetting(List<Setting> data, String name) {
  var find = data.where((element) => (element.name==name) );
  if(find!=null && find.isNotEmpty) {
    var val = find.first.val;
    if(val!=null) {
      return val.split(",");
    }
  }
  return <String>[];
}
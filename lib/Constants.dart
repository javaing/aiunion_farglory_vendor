
import 'dart:ui';


final String DEFAULT_SERVER = "192.168.0.109";
//final String DEFAULT_WS_SERVER = "60.250.33.237";
String HOST = DEFAULT_SERVER;
String v1token = "";


String Weather_APIKEY = "CWB-D203008C-2640-4F20-A839-CD3708D26517";
String Weather_URL = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-005?Authorization=$Weather_APIKEY&format=JSON&locationName=%town&elementName=Wx,AT";




const Color borderColor = Color.fromARGB(255, 224, 224, 224);
Color normalBackground = const Color.fromARGB(255, 16, 16, 16);
Color enterCountColor = const Color.fromARGB(255, 0, 51, 204);
Color leaveCountColor = const Color.fromARGB(255, 0, 102, 51);
Color resideCountColor = const Color.fromARGB(255, 204, 51, 0);
Color pieChartOrange = const Color.fromARGB(255, 255, 153, 0);

Color pieChart1 = const Color.fromARGB(255, 255, 255, 0);
Color pieChart2 = const Color.fromARGB(255, 0, 39, 204);
Color pieChart3 = const Color.fromARGB(255, 255, 39, 153);
Color pieChart4 = const Color.fromARGB(255, 0, 153, 39);
Color pieChart5 = const Color.fromARGB(255, 0, 255, 255);

Color pieChart6 = const Color.fromARGB(255, 0, 128, 0);
Color pieChart7 = const Color.fromARGB(255, 128, 0, 128);
Color pieChart8 = const Color.fromARGB(255, 128, 128, 0);
Color pieChart9 = const Color.fromARGB(255, 0, 128, 128);
Color pieChart10 = const Color.fromARGB(255, 0, 0, 128);
const double BORER_WIDTH = 3.0;
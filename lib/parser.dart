import 'package:dhanvanth/tunnel_link.dart';

class Parser {
  Set<dynamic> possibleDiseases = {};
  Set<dynamic> allSymptoms = {};
  String message = "";
  List<dynamic> relatedSymptoms = [];
  List<dynamic> shouldNotAskAgain = [];
  int i = 0;
  bool crossQuestion = false;
  String previousStatement = "";
  String statement = "";

  Parser();

  Parser.getInstance(Map<String, dynamic> a) {
    possibleDiseases.clear();
    possibleDiseases.addAll(a["possibleDiseases"]);
    allSymptoms.clear();
    allSymptoms.addAll(a["allSymptoms"]);
    message = a["message"];
    relatedSymptoms.clear();
    relatedSymptoms.addAll(a["relatedSymptoms"]);
    shouldNotAskAgain.clear();
    shouldNotAskAgain.addAll(a["shouldNotAskAgain"]);
    i = a["i"];
    crossQuestion = a["crossQuestion"];
    previousStatement = a["previousStatement"] ?? '';
    statement = a["statement"];
  }

  String urlCreate(String statement) {
    this.statement = statement;

    String pd = possibleDiseases.join(",");
    String alls = allSymptoms.join(",");
    String m = message;
    String rs = relatedSymptoms.join(",");
    String snaa = shouldNotAskAgain.join(",");
    String i = this.i.toString();
    String cq = crossQuestion.toString();
    String ps = previousStatement;
    String s = this.statement;

    String url = Tunnel().tunnelUrl+
        '/?' +
        'pd=' +
        pd +
        '&as=' +
        alls +
        '&m=' +
        m +
        '&rs=' +
        rs +
        '&snaa=' +
        snaa +
        '&i=' +
        i +
        '&cq=' +
        cq +
        '&ps=' +
        ps +
        '&s=' +
        s;
    return url;
  }
}

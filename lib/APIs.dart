import 'package:http/http.dart' as http;

var uriDomain ="https://nquestions2.000webhostapp.com/Q2.php";

class Functions{
  static Future<String> generateNumber() async {
    var request = http.MultipartRequest('POST', Uri.parse(uriDomain));
    request.fields.addAll({
      "action":'generate_number'
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      return "";
    }
  }

  static Future<String> getNumber() async {
    var request = http.MultipartRequest('POST', Uri.parse(uriDomain));
    request.fields.addAll({
      "action":'get_number'
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      return "";
    }
  }

  static Future<String> servingNumber() async {
    var request = http.MultipartRequest('POST', Uri.parse(uriDomain));
    request.fields.addAll({
      "action":'serving_number'
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      return "";
    }
  }

  static Future<String> lastNumber() async {
    var request = http.MultipartRequest('POST', Uri.parse(uriDomain));
    request.fields.addAll({
      "action":'get_number'
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      return "";
    }
  }

  static Future<String> counterStatus(cID) async {
    var request = http.MultipartRequest('POST', Uri.parse(uriDomain));
    request.fields.addAll({
      "action":'counter_status',
      "cID" : cID
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      return "";
    }
  }

  static Future<String> counterOfCounter() async {
    var request = http.MultipartRequest('POST', Uri.parse(uriDomain));
    request.fields.addAll({
      "action":'count_of_counter',
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      return "";
    }
  }


}

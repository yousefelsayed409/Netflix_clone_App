// import 'dart:convert';

// import '../../../core/utils/api_keys.dart';
// import 'package:http/http.dart ' as http;

// class AppFunction {
//   List<Map<String, dynamic>> trendingList = [];
//   Future<void> gettrendinglisthome() async {
//     var gettrendingweekresponse = await http.get(
//       Uri.parse(ApiKeys.trandingweekUrl),
//     );
//     if (gettrendingweekresponse.statusCode == 200) {
//       var data = jsonDecode(gettrendingweekresponse.body);
//       var getdatatrendingjson = data['results'];
//       for (var i = 0; i < getdatatrendingjson.lenght; i++) {
//         trendingList.add({
//           'id': getdatatrendingjson[i]['id'],
//           'poster_path': getdatatrendingjson[i]['poster_path'],
//           'vote_average': getdatatrendingjson[i]['vote_average'],
//           'media_type': getdatatrendingjson[i]['media_type'],
//           'indexno': i,
//         });
//       }
//     }
//   }
// }

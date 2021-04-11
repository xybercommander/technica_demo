import 'dart:convert';
import 'package:http/http.dart';
import 'package:technica_know_your_medic/modules/diagnosis_module.dart';
import 'package:technica_know_your_medic/modules/symptoms_module.dart';

class MedicApi {

  Future<void> callSymptomsData() async {
    try {
      
      var url = Uri.parse('https://healthservice.priaid.ch/symptoms?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InNhbXJhdG11a2hlcmplZS5zcHNAZ21haWwuY29tIiwicm9sZSI6IlVzZXIiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9zaWQiOiI2MjA2IiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy92ZXJzaW9uIjoiMTA5IiwiaHR0cDovL2V4YW1wbGUub3JnL2NsYWltcy9saW1pdCI6IjEwMCIsImh0dHA6Ly9leGFtcGxlLm9yZy9jbGFpbXMvbWVtYmVyc2hpcCI6IkJhc2ljIiwiaHR0cDovL2V4YW1wbGUub3JnL2NsYWltcy9sYW5ndWFnZSI6ImVuLWdiIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9leHBpcmF0aW9uIjoiMjA5OS0xMi0zMSIsImh0dHA6Ly9leGFtcGxlLm9yZy9jbGFpbXMvbWVtYmVyc2hpcHN0YXJ0IjoiMjAyMS0wMy0zMSIsImlzcyI6Imh0dHBzOi8vYXV0aHNlcnZpY2UucHJpYWlkLmNoIiwiYXVkIjoiaHR0cHM6Ly9oZWFsdGhzZXJ2aWNlLnByaWFpZC5jaCIsImV4cCI6MTYxODE0NjI0NywibmJmIjoxNjE4MTM5MDQ3fQ.Io_ulNc_NUhvhxhovJ3VXV4sT7__LfSxgBM9_7zkD_4&format=json&language=en-gb');
      Response response = await get(url);
      var data = jsonDecode(response.body);      
      for(int i = 0; i < data.length; i++) {
        Symptoms.symptoms.add(data[i]);
      }
      // print('added');

    } catch(e) {
      print(e.toString());
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> callIssueData(List symptoms_ID, int age, int gender) async { // 0 - Male, 1 - Female
    try {

      String apiGender = gender == 0 ? 'male' : 'female';

      // int index = -1;
      // for(int i = 0; i < Symptoms.symptoms.length; i++) {
      //   if(Symptoms.symptoms[i]['Name'] == symptom) {
      //     index = i;
      //     print('index -> $index');
      //     break;
      //   }
      // }

      var url = Uri.parse('https://healthservice.priaid.ch/diagnosis?symptoms=$symptoms_ID&gender=$apiGender&year_of_birth=$age&token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InNhbXJhdG11a2hlcmplZS5zcHNAZ21haWwuY29tIiwicm9sZSI6IlVzZXIiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9zaWQiOiI2MjA2IiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy92ZXJzaW9uIjoiMTA5IiwiaHR0cDovL2V4YW1wbGUub3JnL2NsYWltcy9saW1pdCI6IjEwMCIsImh0dHA6Ly9leGFtcGxlLm9yZy9jbGFpbXMvbWVtYmVyc2hpcCI6IkJhc2ljIiwiaHR0cDovL2V4YW1wbGUub3JnL2NsYWltcy9sYW5ndWFnZSI6ImVuLWdiIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9leHBpcmF0aW9uIjoiMjA5OS0xMi0zMSIsImh0dHA6Ly9leGFtcGxlLm9yZy9jbGFpbXMvbWVtYmVyc2hpcHN0YXJ0IjoiMjAyMS0wMy0zMSIsImlzcyI6Imh0dHBzOi8vYXV0aHNlcnZpY2UucHJpYWlkLmNoIiwiYXVkIjoiaHR0cHM6Ly9oZWFsdGhzZXJ2aWNlLnByaWFpZC5jaCIsImV4cCI6MTYxODE0NjI4NiwibmJmIjoxNjE4MTM5MDg2fQ.k5cFSKzu7Ll9VfDaqWjn8R3LKliJRRccxzZT3-fPTns&format=json&language=en-gb');
      Response response = await get(url);
      var data = jsonDecode(response.body);
      print(data[0]);
      Diagnosis.diagnosis = data;
      // print(data);

      // print(Symptoms.symptoms[index]['ID']);
      
    } catch(e) {
      print(e.toString());
    }
  }

}
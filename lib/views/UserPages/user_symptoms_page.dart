import 'package:flutter/material.dart';
import 'package:know_your_medic/modules/symptoms_module.dart';
import 'package:know_your_medic/views/UserPages/user_details.dart';
import 'package:page_transition/page_transition.dart';

class UserSymptomsPage extends StatefulWidget {
  @override
  _UserSymptomsPageState createState() => _UserSymptomsPageState();
}

class _UserSymptomsPageState extends State<UserSymptomsPage> {
  // ignore: non_constant_identifier_names
  int symptoms_selected = 0;
  List<String> symptoms = [];
  // ignore: non_constant_identifier_names
  List<int> symptoms_ID = [];
  // ignore: non_constant_identifier_names
  List<int> selected_symptoms_index = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        physics: BouncingScrollPhysics(),
        itemCount: Symptoms.symptoms.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                if(selected_symptoms_index.contains(index)) {
                  symptoms_selected--;
                  selected_symptoms_index.remove(index);
                  symptoms.remove(Symptoms.symptoms[index]['Name']);
                  symptoms_ID.remove(Symptoms.symptoms[index]['ID']);
                } else {
                  symptoms_selected++;
                  selected_symptoms_index.add(index);
                  symptoms.add(Symptoms.symptoms[index]['Name']);
                  symptoms_ID.add(Symptoms.symptoms[index]['ID']);
                }
              });
            },
            child: Card(              
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              color: selected_symptoms_index.contains(index) ? Theme.of(context).primaryColor : null,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Text(
                  Symptoms.symptoms[index]['Name'],
                  style: TextStyle(
                    fontSize: 16, 
                    fontFamily: 'Quicksand-SemiBold', 
                    color: !selected_symptoms_index.contains(index) ? 
                      Theme.of(context).primaryColor : Colors.white
                  ),
                )
              ),
            ),
          );
        },
      ),

      floatingActionButton: symptoms_selected != 0 
        ?   FloatingActionButton.extended(
              label: Text('$symptoms_selected symptoms selected', style: TextStyle(color: Colors.white),),
              icon: Icon(Icons.search, color: Colors.white,),
              backgroundColor: Theme.of(context).primaryColor,              
              onPressed: () {
                Navigator.push(context, PageTransition(
                  child: UserDetails(symptoms, symptoms_ID),
                  type: PageTransitionType.bottomToTop
                ));
              },
            )
        : null
    );
  }
}
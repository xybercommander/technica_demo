import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:know_your_medic/modules/diagnosis_module.dart';

class DiagnosisPage extends StatefulWidget {
  @override
  _DiagnosisPageState createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends State<DiagnosisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text('Digital Diagnosis', style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: 'Quicksand-Bold',
            fontSize: 24
          ),)
      ),

      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 1.7,
          width: MediaQuery.of(context).size.width,
          child: Swiper(
            physics: BouncingScrollPhysics(),
            scale: 0.9,
            viewportFraction: 0.7,
            loop: false, 
            itemCount: Diagnosis.diagnosis.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Container(
                  width: 200,
                  height: 200,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(                      
                    children: [
                      Text(
                        '${Diagnosis.diagnosis[index]['Issue']['Name']}\n(${Diagnosis.diagnosis[index]['Issue']['ProfName']})',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Quicksand-SemiBold'
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'Brief Details: ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Quicksand-SemiBold'
                        ),
                      ),
                      Text(
                        '${Diagnosis.diagnosis[index]['Issue']['IcdName']}',
                        style: TextStyle(
                          fontSize: 16,                          
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'Specialised Categories: ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Quicksand-SemiBold'
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: Diagnosis.diagnosis[index]['Specialisation'].length,
                          itemBuilder: (context, listIndex) {                        
                            return ListTile(
                              title: Text(Diagnosis.diagnosis[index]['Specialisation'][listIndex]['Name']),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
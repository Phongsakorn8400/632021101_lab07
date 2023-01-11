import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:share_plus/share_plus.dart';

class ScoreScreen extends StatelessWidget {

  final double bmiScore;

  final int age;

  String? bmiStatus;

  String? bmiInterpretation;

  Color? bmiStatusColor;

  ScoreScreen({Key? key, required this.bmiScore,required this.age}) 
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    setBmiIntepretation();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("BMI Score"),
      ),
      body: Container(
          padding: const EdgeInsets.all(12),
          child: Card(
            elevation: 12,
            shape: const RoundedRectangleBorder(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("ค่าเฉลี่ย",
                style: TextStyle(fontSize: 30, color: Colors.blue),
                ),
                const SizedBox(
                  height: 10,
                  ),
                PrettyGauge(
                  gaugeSize: 300,
                  minValue: 0,
                  maxValue: 40,
                  segments: [
                    GaugeSegment('UnderWeight', 18.5, Colors.red),
                    GaugeSegment('Normal', 6.4, Colors.green),
                    GaugeSegment('OverWeight', 5, Colors.orange),
                    GaugeSegment('Obese', 10.1, Colors.pink),
                  ],
                  valueWidget: Text(bmiScore.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 40),
                  ),
                  currentValue: bmiScore.toDouble(),
                  needleColor: Colors.blue,
                ),
                const SizedBox(height: 10,),
                Text(bmiStatus!, style: TextStyle(fontSize: 20, color: bmiStatusColor!),
                ),
                const SizedBox(height: 10,
                ),
                 Text(
                  bmiInterpretation!, 
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                    }, 
                      child: const Text("Re-calculate")),
                      const SizedBox(
                        width: 10,),
                    ElevatedButton(onPressed: (){
                      Share.share("Your BMI is ${bmiScore.toStringAsFixed(1)} at age $age");
                    }, 
                      child: const Text("Share")),
                  ],
                )
              ]))),
    );
  }


  void setBmiIntepretation() {
    if (bmiScore > 30 ) {
      bmiStatus = "อ้วน";
      bmiInterpretation = "ลดน้ำหนักหน่อยนะอ้วนแล้ว!";
      bmiStatusColor = Colors.pink;
    } else if (bmiScore >= 25 ) {
      bmiStatus = "น้ำหนักเกิน";
      bmiInterpretation = "ออกกำลังกายเป็นประจำและลดน้ำหนัก!";
      bmiStatusColor = Colors.orange;
    } else if (bmiScore >= 18.5 ) {
      bmiStatus = "ปกติ";
      bmiInterpretation = "ชีวิตพอดีที่ลงตัว";
      bmiStatusColor = Colors.green;
    }  else if (bmiScore < 18.5 ) {
      bmiStatus = "น้ำหนักน้อย";
      bmiInterpretation = "พยายามเพิ่มน้ำหนัก!";
      bmiStatusColor = Colors.red;
    }
  }
}
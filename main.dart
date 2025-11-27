
import 'package:flutter/material.dart';

void main() => runApp(const WizardApp());

class WizardApp extends StatelessWidget {
  const WizardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Report Generator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Step1GeneralTolerance(),
    );
  }
}

class Step1GeneralTolerance extends StatefulWidget {
  const Step1GeneralTolerance({super.key});
  @override
  State<Step1GeneralTolerance> createState() => _Step1GeneralToleranceState();
}

class _Step1GeneralToleranceState extends State<Step1GeneralTolerance> {
  final linearCtrl = TextEditingController();
  final angularCtrl = TextEditingController();
  final radiusCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("General Tolerances")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: linearCtrl, decoration: const InputDecoration(labelText: "Linear ±")),
            TextField(controller: angularCtrl, decoration: const InputDecoration(labelText: "Angular ±")),
            TextField(controller: radiusCtrl, decoration: const InputDecoration(labelText: "Radius ±")),
            const Spacer(),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => Step2CastingTolerance(
                    linear: linearCtrl.text,
                    angular: angularCtrl.text,
                    radius: radiusCtrl.text,
                  ),
                ));
              },
              child: const Text("Next"),
            )
          ],
        ),
      ),
    );
  }
}

class Step2CastingTolerance extends StatefulWidget {
  final String linear, angular, radius;
  const Step2CastingTolerance({super.key, required this.linear, required this.angular, required this.radius});
  @override
  State<Step2CastingTolerance> createState() => _Step2CastingToleranceState();
}

class _Step2CastingToleranceState extends State<Step2CastingTolerance> {
  String ctGrade = "CT10";
  final customCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Casting Tolerances")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: ctGrade,
              items: ["CT8","CT9","CT10","CT11","CT12","CT13","CT14"]
                .map((e)=>DropdownMenuItem(value:e,child: Text(e))).toList(),
              onChanged: (v)=>setState(()=>ctGrade=v!),
            ),
            TextField(controller: customCtrl, decoration: const InputDecoration(labelText:"Custom ± (optional)")),
            const Spacer(),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => SummaryScreen(
                    general: {
                      "linear": widget.linear,
                      "angular": widget.angular,
                      "radius": widget.radius
                    },
                    casting: {
                      "ct": ctGrade,
                      "custom": customCtrl.text
                    }
                  ),
                ));
              },
              child: const Text("Finish"),
            )
          ],
        ),
      ),
    );
  }
}

class SummaryScreen extends StatelessWidget {
  final Map general;
  final Map casting;
  const SummaryScreen({super.key, required this.general, required this.casting});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Summary")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text("General: $general\nCasting: $casting"),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ukrnames/controller/google_sheet_controller.dart';
import 'package:ukrnames/model/name.dart';
import '../strings.dart';
import 'details.dart';
import 'package:ukrnames/theme.dart';

class MyHomePage extends StatefulWidget {
  final String googleScriptURL;

  const MyHomePage({super.key, required this.googleScriptURL});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Name>> fNames;
  late List<Name> names;
  Name? current;

  @override
  void initState() {
    super.initState();
    fNames = futureNames(widget.googleScriptURL);
  }

  void _nextName() {
    final random = Random();
    int index = random.nextInt(names.length);
    Name newName = names[index];
    if (newName == current) {
      _nextName();
    } else {
      current = newName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Container(
              constraints: const BoxConstraints.expand(),
              alignment: Alignment.center,
              color: Colors.blueAccent,
              child: topContent()),
        ),
        Flexible(
            flex: 1,
            child: Container(
                constraints: const BoxConstraints.expand(),
                alignment: Alignment.center,
                color: Colors.yellow,
                child: loadFemaleNames()))
      ],
    );
  }

  Widget topContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$strHomeChoose ', style: h2()),
        AnimatedTextKit(
          animatedTexts: strHomeTopWords
              .map((nameDescr) => TypewriterAnimatedText(nameDescr,
                  textStyle: h2().copyWith(
                      fontWeight: FontWeight.bold, color: Colors.yellow),
                  speed: const Duration(milliseconds: 50),
                  cursor: ' '))
              .toList(),
          totalRepeatCount: 1,
          pause: const Duration(milliseconds: 1000),
          displayFullTextOnTap: false,
          stopPauseOnTap: false,
        ),
        Text(strHomeUkrName, style: h2())
      ],
    );
  }

  Widget bottomContent() {
    return Column(children: [
      const Spacer(),
      Text(current!.name.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black,
              letterSpacing: 4,
              decoration: TextDecoration.none)),
      const Spacer(),
      TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    DetailsPage(name: current!),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var tween = Tween<double>(begin: 1.0, end: 1.0);
                  return FadeTransition(
                    opacity: animation.drive(tween),
                    child: child,
                  );
                }),
          );
        },
        child: Padding(
            padding: const EdgeInsets.all(16.0), child: Text(strHomeKnowMore)),
      ),
      const SizedBox(height: 10),
      ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          setState(() {
            _nextName();
          });
        },
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(strHomeShowAnother)),
      ),
      const Spacer(),
    ]);
  }

  Widget loadFemaleNames() {
    return FutureBuilder<List<Name>>(
      future: fNames,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // update data
          names = snapshot.data!;
          _nextName();
          // view
          return bottomContent();
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(color: Colors.blueAccent),
        );
      },
    );
  }

// Route _routeToDetails() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) =>
//         DetailsPage(name: current),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       var tween = Tween<double>(begin: 1.0, end: 1.0);
//       return FadeTransition(
//         opacity: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }
}

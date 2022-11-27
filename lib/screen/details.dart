import 'package:flutter/material.dart';
import 'package:ukrnames/model/name.dart';
import 'package:ukrnames/theme.dart';

class DetailsPage extends StatefulWidget {
  final Name name;

  const DetailsPage({super.key, required this.name});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                  color: Colors.blueAccent,
                  constraints: const BoxConstraints.expand(),
                  alignment: Alignment.center),
            ),
            Flexible(
                flex: 1,
                child: Container(
                    color: Colors.yellow,
                    constraints: const BoxConstraints.expand(),
                    alignment: Alignment.center))
          ],
        ),
        Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
                elevation: 16,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.all(20), child: details())))
      ],
    );
  }

  Widget details() {
    var icon = widget.name.male ? Icons.man_outlined : Icons.woman_outlined;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.name.name,
                style: h2(color: Colors.black)
                    .copyWith(fontWeight: FontWeight.bold)),
            Icon(icon, color: Colors.black, size: 60.0),
          ],
        ),
        SizedBox(height: 30),
        Row(
          children: [
            Expanded(
                flex: 1,
                child: Column(children: [
                  Text("Категорія: ${widget.name.category}",
                      style: h4(color: Colors.black)),
                  SizedBox(height: 30),
                  Text("Походження", style: h4(color: Colors.black)),
                  SizedBox(height: 30),
                  Text(widget.name.history)
                ])),
            SizedBox(width: 30),
            Expanded(
                flex: 1,
                child: Column(children: [
                  Text("Зменшені форми", style: h4(color: Colors.black)),
                  SizedBox(height: 30),
                  Text(widget.name.shortForms)
                ])),
          ],
        ),
      ],
    );
  }
}

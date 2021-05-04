import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

class generatePassword extends StatefulWidget {
  @override
  _generatePasswordState createState() => _generatePasswordState();
}

//providers
final sliderProvider = StateProvider((ref) => 8);
final numberProvider = StateProvider((ref) => false);
final symbolProvider = StateProvider((ref) => false);

// Password Generator
RandomBullshitGo(int length, bool number, bool symbol) {
  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  const _charsWithNumbers =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  const _charsWithNumbersSymbols =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!@#\%/=+-_&*\$\^';
  const _charsWithSymbols =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz!@#\%/=+-_&*\$\^';
  final Random _random = Random.secure();

  if (number == false && symbol == false)
    return String.fromCharCodes(
      Iterable.generate(
          length, (_) => _chars.codeUnitAt(_random.nextInt(_chars.length))),
    );
  else if (number == false && symbol == true)
    return String.fromCharCodes(
      Iterable.generate(
          length,
          (_) => _charsWithSymbols
              .codeUnitAt(_random.nextInt(_charsWithSymbols.length))),
    );
  else if (number == true && symbol == false)
    return String.fromCharCodes(
      Iterable.generate(
          length,
          (_) => _charsWithNumbers
              .codeUnitAt(_random.nextInt(_charsWithNumbers.length))),
    );
  else
    return String.fromCharCodes(
      Iterable.generate(
          length,
          (_) => _charsWithNumbersSymbols
              .codeUnitAt(_random.nextInt(_charsWithNumbersSymbols.length))),
    );
}

class _generatePasswordState extends State<generatePassword> {
  @override
  TextEditingController passwrdControl;
  void initState() {
    passwrdControl = new TextEditingController();
    passwrdControl.text = RandomBullshitGo(context.read(sliderProvider).state,
        context.read(numberProvider).state, context.read(symbolProvider).state);
    super.initState();
  }

  @override
  void dispose() {
    passwrdControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextField(
              controller: passwrdControl,
              textAlign: TextAlign.center,
              readOnly: true,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.redAccent),
                focusColor: Colors.grey,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.loop_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () => passwrdControl.text = RandomBullshitGo(
                      context.read(sliderProvider).state,
                      context.read(numberProvider).state,
                      context.read(symbolProvider).state),
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          Consumer(
            builder: (context, watch, child) => Flexible(
              flex: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.remove_outlined,
                        color: Colors.redAccent,
                      ),
                      onPressed: () => {
                            context.read(sliderProvider).state <= 8
                                ? null
                                : context.read(sliderProvider).state--,
                            passwrdControl.text = RandomBullshitGo(
                                context.read(sliderProvider).state,
                                context.read(numberProvider).state,
                                context.read(symbolProvider).state),
                          }),
                  Expanded(
                    child: SliderTheme(
                      data: SliderThemeData(
                        activeTickMarkColor: Colors.redAccent,
                        tickMarkShape: RoundSliderTickMarkShape(),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 10),
                        overlayColor: Colors.redAccent,
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 12),
                        thumbColor: Colors.redAccent,
                        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                        valueIndicatorColor: Colors.red,
                        showValueIndicator:
                            ShowValueIndicator.onlyForContinuous,
                        trackHeight: 5,
                        trackShape: RoundedRectSliderTrackShape(),
                        activeTrackColor: Colors.redAccent,
                        inactiveTrackColor: Colors.redAccent.withOpacity(0.6),
                      ),
                      child: Slider(
                          value: watch(sliderProvider).state.toDouble(),
                          min: 8,
                          max: 25,
                          label: context.read(sliderProvider).state.toString(),
                          onChanged: (value) {
                            context.read(sliderProvider).state = value.toInt();
                            passwrdControl.text = RandomBullshitGo(
                                    context.read(sliderProvider).state.toInt(),
                                    context.read(numberProvider).state,
                                    context.read(symbolProvider).state)
                                .toString();
                          }),
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.add_outlined,
                        color: Colors.redAccent,
                      ),
                      onPressed: () => {
                            context.read(sliderProvider).state >= 25
                                ? null
                                : context.read(sliderProvider).state++,
                            passwrdControl.text = RandomBullshitGo(
                                    context.read(sliderProvider).state.toInt(),
                                    context.read(numberProvider).state,
                                    context.read(symbolProvider).state)
                                .toString(),
                          }),
                ],
              ),
            ),
          ),
          Consumer(
            builder: (context, watch, child) => Flexible(
              flex: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    checkColor: Colors.redAccent,
                    activeColor: Colors.red.shade100,
                    value: watch(numberProvider).state,
                    onChanged: (value) {
                      watch(numberProvider).state =
                          !context.read(numberProvider).state;
                      passwrdControl.text = RandomBullshitGo(
                          context.read(sliderProvider).state,
                          context.read(numberProvider).state,
                          context.read(symbolProvider).state);
                    },
                  ),
                  Text("Include Numbers"),
                  SizedBox(
                    width: 20,
                  ),
                  Checkbox(
                    checkColor: Colors.redAccent,
                    activeColor: Colors.red.shade100,
                    value: watch(symbolProvider).state,
                    onChanged: (value) {
                      watch(symbolProvider).state =
                          !context.read(symbolProvider).state;
                      passwrdControl.text = RandomBullshitGo(
                          context.read(sliderProvider).state,
                          context.read(numberProvider).state,
                          context.read(symbolProvider).state);
                    },
                  ),
                  Text("Include Symbols"),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Consumer(
            builder: (context, watch, child) => ElevatedButton(
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed))
                    return Colors.redAccent.shade100;
                  return Colors.redAccent.shade200;
                })),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: passwrdControl.text));
                  final snackBar = SnackBar(
                    content: Text('Password copied to clipboard'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text("Copy to clipboard")),
          )
        ],
      ),
    );
  }
}

import 'package:bellman/data/bellman_category.dart';
import 'package:bellman/data/bellman_data.dart';
import 'package:flutter/material.dart';
import 'package:bellman/bellman.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'checkbox_field.dart';

late final SharedPreferences sharedPref;

const showAfterDurationKey = 'showAfterDuration';
const showOnceOnAppStartKey = 'showOnceOnAppStar';
const showAlwaysOnAppStartKey = 'showAlwaysOnAppStart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Bellman Demo',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const gap = SizedBox(height: 4.0);

  GlobalKey key = GlobalKey();
  BellmanConfig bellmanConfig = BellmanConfig();

  bool showOnceOnAppStart = false;
  bool showAlwaysOnAppStart = true;

  @override
  void initState() {
    super.initState();
    final showAfterDuration = sharedPref.getInt(showAfterDurationKey);

    bellmanConfig = bellmanConfig.copyWith(
      showAfterDuration: showAfterDuration == null
          ? null
          : Duration(
              milliseconds: showAfterDuration,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BellmanWidget(
      config: bellmanConfig,
      data: BellmanData(
        title: "What's new!",
        categories: [
          BellmanCategory(
            displayTitle: "📣 Changelog",
            content: BellmanMarkdown("Sample 1"),
          ),
          BellmanCategory(
            displayTitle: "🚀 Roadmap",
            content: BellmanMarkdown("Sample 2"),
          ),
          BellmanCategory(
            displayTitle: "📅 Events",
            content: BellmanMarkdown("Sample 3"),
          ),
        ],
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: bellmanConfig.showAfterDuration?.inMilliseconds.toString(),
                onChanged: (value) {
                  if (value.isEmpty) return;
                  sharedPref.setInt(showAfterDurationKey, int.parse(value));
                },
                decoration: getInputDecoration('Open after delay (in ms)'),
              ),
              gap,
              CheckboxField(
                initialValue: false,
                title: const Text('Show once on app start'),
                onChanged: (value) {},
              ),
              gap,
              CheckboxField(
                initialValue: false,
                title: const Text('Show always on app start'),
                onChanged: (value) {},
              ),
              gap,
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    sharedPref.clear();
                    BellmanConfig();
                  });
                },
                child: const Text('Clear storage'),
              )
              // CheckboxListTile(
              //   value: checkboxValue,
              //   onChanged: (val) {
              //     setState(() => checkboxValue = val
              //   },
              //   subtitle: !checkboxValue
              //       ? Text(
              //           'Required.',
              //           style: TextStyle(color: Colors.red),
              //         )
              //       : null,
              //   title: new Text(
              //     'I agree.',
              //     style: TextStyle(fontSize: 14.0),
              //   ),
              //   controlAffinity: ListTileControlAffinity.leading,
              //   activeColor: Colors.green,
              // ),
            ],
          ),
        ),
        floatingActionButton: Test(),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () {
        //     print(Bellman.maybeOf(context));
        //     // showBellmanDialog(
        //     //   context: context,
        //     // );
        //   },
        //   label: const Text('Show dialog'),
        // ),
      ),
    );
  }

  InputDecoration getInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      isDense: true,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    );
  }
}

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showBellmanDialog(context: context);
      },
      label: const Text('Show dialog'),
    );
  }
}

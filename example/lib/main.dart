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
            content: BellmanChangelog(changelog: [
              ChangelogData(
                title: "🎉 New features",
                changes: [
                  "Added page for doing XYZ",
                  "Added button to invite friends to join the app",
                ],
              ),
              ChangelogData(
                title: "🚀 Improvements",
                changes: [
                  "Improved layout on analytics screen",
                  "Added button to easily access profile",
                  "Added translations for French, Italian, and German"
                ],
              ),
              ChangelogData(
                title: "🐛 Bug fixes",
                changes: [
                  "Fixed crash when making payment",
                  "Fixed infinite loading screen",
                  "Fixed issue during login flow",
                ],
              ),
            ]),
          ),
          BellmanCategory(
            displayTitle: "📚 Markdown",
            content: BellmanMarkdown(
              markdown: markdown,
            ),
          ),
          BellmanCategory(
            displayTitle: "✨ Custom builder",
            content: BellmanCustomBuilder(
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: const [
                      Text('This is some custom flutter code!'),
                      SizedBox(height: 10),
                      FlutterLogo(size: 100),
                    ],
                  ),
                );
              },
            ),
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
              ),
            ],
          ),
        ),
        floatingActionButton: const Fab(),
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

class Fab extends StatelessWidget {
  const Fab({super.key});

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

const markdown = '''
# Markdown syntax guide

## Headers

# This is a Heading h1
## This is a Heading h2 
###### This is a Heading h6

## Emphasis

*This text will be italic*  
_This will also be italic_

**This text will be bold**  
__This will also be bold__

_You **can** combine them_

## Lists

### Unordered

* Item 1
* Item 2
* Item 2a
* Item 2b

### Ordered

1. Item 1
1. Item 2
1. Item 3
  1. Item 3a
  1. Item 3b

## Images

![This is a alt text.](https://fastly.picsum.photos/id/13/2500/1667.jpg?hmac=SoX9UoHhN8HyklRA4A3vcCWJMVtiBXUg0W4ljWTor7s "This is a sample image.")

## Links

You may be using [Markdown Live Preview](https://markdownlivepreview.com/).

## Blockquotes

> Markdown is a lightweight markup language with plain-text-formatting syntax, created in 2004 by John Gruber with Aaron Swartz.
>
>> Markdown is often used to format readme files, for writing messages in online discussion forums, and to create rich text using a plain text editor.

## Tables

| Left columns  | Right columns |
| ------------- |:-------------:|
| left foo      | right foo     |
| left bar      | right bar     |
| left baz      | right baz     |

## Blocks of code

```
let message = 'Hello world';
alert(message);
```
''';

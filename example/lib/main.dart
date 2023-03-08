import 'package:bellman/data/bellman_category.dart';
import 'package:bellman/data/bellman_data.dart';
import 'package:flutter/material.dart';
import 'package:bellman/bellman.dart';

import 'checkbox_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLightMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: isLightMode ? ThemeData.light() : ThemeData.dark(),
      home: MyHomePage(
        title: 'Bellman Demo',
        isLightMode: isLightMode,
        onChangeTheme: (lightMode) {
          setState(() {
            isLightMode = lightMode;
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final bool isLightMode;
  final void Function(bool lightMode)? onChangeTheme;

  const MyHomePage({
    super.key,
    required this.title,
    this.isLightMode = true,
    this.onChangeTheme,
  });

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

    // bellmanConfig = bellmanConfig.copyWith(
    //   showAfterDuration: showAfterDuration == null
    //       ? null
    //       : Duration(
    //           milliseconds: showAfterDuration,
    //         ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return BellmanWidget(
      config: bellmanConfig,
      data: BellmanData(
        categories: bellmanCategories,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Icon(widget.isLightMode ? Icons.dark_mode : Icons.light_mode),
              tooltip: 'Toggle theme',
              onPressed: () {
                widget.onChangeTheme?.call(!widget.isLightMode);
              },
            )
          ],
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
                  // sharedPref.setInt(showAfterDurationKey, int.parse(value));
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
                onPressed: () {},
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
        showBellmanDialog(
          context: context,
          // barrierDismissible: true,
        );
      },
      label: const Text('Show dialog'),
    );
  }
}

final bellmanCategories = [
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
          "Fixed layout issue on mobile",
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
        return Column(
          children: const [
            Text('This is some custom flutter code!'),
            SizedBox(height: 10),
            FlutterLogo(size: 100),
          ],
        );
      },
    ),
  ),
];

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

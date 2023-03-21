import 'package:bellman/data/bellman_category.dart';
import 'package:bellman/data/bellman_data.dart';
import 'package:bellman/util/bellman_config.dart';
import 'package:bellman/util/bellman_dialog_config.dart';
import 'package:flutter/material.dart';
import 'package:bellman/bellman.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void simulateRestart(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()?.simulateRestart(context);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLightMode = true;

  BellmanConfig config = BellmanConfig();
  BellmanDialogConfig dialogConfig = BellmanDialogConfig(
    barrierDismissible: true,
    barrierLabel: 'Dismiss Bellman dialog',
  );
  BellmanData data = BellmanData(
    categories: bellmanCategories,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: isLightMode ? ThemeData.light() : ThemeData.dark(),
      home: BellmanWidget(
        data: data,
        config: config,
        dialogConfig: dialogConfig,
        child: MyHomePage(
          title: 'Bellman Demo',
          isLightMode: isLightMode,
          onChangeConfig: (config) {
            setState(() {
              this.config = config;
            });
          },
          onChangeTheme: (lightMode) {
            setState(() {
              isLightMode = lightMode;
            });
          },
        ),
      ),
    );
  }

  void simulateRestart(BuildContext context) {
    setState(() {});
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final bool isLightMode;
  final void Function(bool lightMode)? onChangeTheme;
  final void Function(BellmanConfig config)? onChangeConfig;

  const MyHomePage({
    super.key,
    required this.title,
    this.isLightMode = true,
    this.onChangeTheme,
    this.onChangeConfig,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const gap = SizedBox(height: 4.0);

  @override
  Widget build(BuildContext context) {
    // final bellmanProvider =
    return Scaffold(
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
              initialValue: Bellman.of(context).config?.showAfterDuration?.inMilliseconds.toString(),
              onChanged: (value) {
                if (value.isEmpty) return;
                // sharedPref.setInt(showAfterDurationKey, int.parse(value));
              },
              decoration: getInputDecoration('Open after delay (in ms)'),
            ),
            gap,
            DropdownButtonFormField(
              value: Bellman.of(context).config?.displayOption,
              items: const [
                DropdownMenuItem(
                  value: AppStartDisplay.once,
                  child: Text('Display once on startup'),
                ),
                DropdownMenuItem(
                  value: AppStartDisplay.always,
                  child: Text('Always display on startup'),
                ),
                DropdownMenuItem(
                  value: AppStartDisplay.never,
                  child: Text('Never display on startup'),
                ),
              ],
              onChanged: (value) {
                final config = Bellman.of(context).config;
                if (config == null) return;
                widget.onChangeConfig?.call(config.copyWith(displayOption: value));
              },
            ),
            gap,
            ElevatedButton(
              onPressed: () {
                MyApp.simulateRestart(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('App restarted'),
                    duration: Duration(milliseconds: 500),
                  ),
                );
              },
              child: const Text('Simulate app restart'),
            ),
            gap,
            ElevatedButton(
              onPressed: () {
                final bellman = Bellman.of(context);
                bellman.storage.clearStorage();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Local storage has been cleared'),
                    duration: Duration(milliseconds: 500),
                  ),
                );
              },
              child: const Text('Clear Bellman data'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final bellman = Bellman.of(context);
          bellman.showDialog(
            context: context,
            dialogConfig: bellman.dialogConfig,
            data: bellman.data!,
          );
        },
        label: const Text('Show dialog'),
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

final bellmanCategories = [
  BellmanCategory(
    displayTitle: "📣 Changelog",
    content: BellmanChangelog(changelog: [
      Changelog(
        title: "🎉 New features",
        changes: [
          "Added page for doing XYZ",
          "Added button to invite friends to join the app",
        ],
      ),
      Changelog(
        title: "🚀 Improvements",
        changes: [
          "Improved layout on analytics screen",
          "Added button to easily access profile",
          "Added translations for French, Italian, and German"
        ],
      ),
      Changelog(
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
      onTapLink: (_, href, __) {
        print("Go to $href!");
      },
    ),
  ),
  BellmanCategory(
    displayTitle: "✨ Custom builder",
    content: BellmanCustomBuilder(
      builder: (context) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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

![This is a alt text.](https://picsum.photos/200/300 "This is a sample image.")

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

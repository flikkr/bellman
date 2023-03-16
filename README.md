# 🛎️ Bellman
---

Bellman is a UI library for Flutter that allows you to easily make in-app announcements to your users.

You've probably encountered this before, you log in to an app and are shown a dialog or popup with the new features and bug fixes since the last app version, or some important announcements before the main app experience. Bellman helps with all that, by abstracting away the implementation, you can have the same experience in your app by providing the data you want to show to your users.

> 🚨 WARNING! This package is still very early stage and experimental. APIs will likely change and cause breaking changes so I do not suggest you use this in any production application yet.

## Features

- [ ] Deeplink to bellman
- [x] Style customisation
- [ ] Theme data
- [x] Custom builder

## Usage

Just wrap your app with the `BellmanWidget` to provide functionality anywhere within your app.

```dart
void main() {
    runApp(
        BellmanWidget(child: MyApp()),
    );
}
```

Optionally, you can pass in a `BellmanConfig` object as parameter to configure the behaviour of Bellman according to your requirements.

```dart
BellmanWidget(
    config: BellmanConfig(
        displayOption: AppStartDisplay.once,
        showAfterDuration: Duration(seconds: 2),
        // Optionally, the function below has the same behaviour as the above parameter
        // showAfterFunctionEnds: () async {
        //     await Future.delayed(Duration(seconds: 2));
        // }
    ),
)
```

### What can I use it for?

Bellman comes ready with a few preconfigured widgets out of the box. Just provide some data
and they will automatically display according to their type.

- Changelog
- Markdown
- Custom

#### Changelog

When building an app, it's not unusual to update your users on new developments such as features, 
bug fixes, improvements, etc. 

Pass in a list of `Changelog` to the `BellmanCategory` widget to display all your changes to
your users.

```dart
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
                "Added translations for French, Italian, and German"
            ],
        ),
    ]),
  ),
```

#### Markdown

If you want to render rich text data with different styles and images, you can use `BellmanMarkdown` 
for that. Simply pass a string formatted in markdown and the text will be rendered accordingly.

```dart
BellmanCategory(
    displayTitle: "📚 Markdown",
    content: BellmanMarkdown(
        markdown: '''
# This is a *Heading* h1

![This is a alt text.](https://picsum.photos/200/300 "This is a sample image.")

This is a [web link](https://markdownlivepreview.com/).
        ''',
    ),
),

```

#### Custom builder

Sometimes you just want to do things your own way, we get that. `BellmanCustomBuilder` allows you to display your own Flutter widgets in however way you want. just supply a function to the `builder` method to get started.

```dart
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
)
```

### Customisation

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.

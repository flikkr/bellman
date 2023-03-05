# 🛎️ Bellman
---

Bellman is a UI library for Flutter that allows you to easily make in-app announcements to your users.

You've probably seen this before, you log in to an app and are shown a dialog or pop-up with the new features and bug fixes since the last app version, or some important announcements before the main app experience. Bellman helps with all that, by abstracting away the implementation, you can have the same experience in your app by providing the data you want to show to your users.

## Features

- [ ] Deeplink to bellman
- [ ] Style customisation
- [ ] Theme data
- [ ] Custom builder
- [ ] Display on separate page

Bellman was built while trying to minimise dependencies on third-party packages, which is why
it only uses essential packages to render markdown, or to access shared preferences.

## Usage

Just wrap your root widget with the `BellmanWidget` to provide the functionality anywhere in your app.

```dart
```

### What can I use it for?

Bellman comes ready with a few preconfigured widgets out of the box. Just provide some data
and you don't have to worry about how it's displayed to your users.

- Changelog
- Text/Markdown
- Image carousel
- Custom

#### Changelog

When building an app, it's not unusual to update your users on any new developments such as features, bug fixes, improvements, etc. `BellmanChangelog` helps with that by making it easy to display those changes separated by category. 

#### Markdown

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

# ballastlane_app

A shows search app.

## Dependencies setup

```
flutter pub add flutter_bloc http provider shared_preferences simple_html_css
flutter pub add dev:test dev:mockito dev:build_runner
```

## Generating Test Mocks

```
dart run build_runner build
```

## Project Proccess

I started by designing all user interface, trying to avoid using StatefulWidget unless
is complety necessary, later I will inject interactivity through BLoC.

The Second step was defining the main entities and interfaces for data access, I used
Clean Architecture, I focused in domain first and then building the implementation in a
way could be easily tested, injecting the http client as a dependency so it's easy inject
a MockClient in testing, all this dependencies were instantiated in the widget root using
Provider to let them exposed down across the widget tree.

Once I finished the definition of the interfaces, I just needed to use flutter_bloc adding
BlocBuilder or similar widgets to make the UI interactive without a lot of changes, this
way I could easly respond to state updating the UI with BlocConsumer or BlocBuilder or just
listen with BlocListener, BLoC permitted share state across different widgets using the
simplified mechanism of Provider based on InheritedWidget.

import 'package:aomlah/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    // Register all views
    MaterialRoute(page: StartupView, initial: true),
  ],
  dependencies: [
    // Register all services and deps.
  ],
)
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}

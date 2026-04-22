import 'package:secure_stream_docs/flavors.dart';
import 'package:secure_stream_docs/main.dart' as runner;

void main() {
  F.appFlavor = Flavor.prod;
  runner.main();
}

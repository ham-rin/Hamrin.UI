import 'package:flutter_test/flutter_test.dart';
import 'package:hamrin_app/presentation/controllers/splash_controller.dart';

void main() {
  group('isCurrentVersionOk', () {
    SplashController controller = SplashController();
    test(
        'returns true when current version is greater than or equal to mandatory version',
        () {
      expect(controller.isCurrentVersionOk('1.0.0', '1.0.0'), true);
      expect(controller.isCurrentVersionOk('2.0.0', '1.0.0'), true);
      expect(controller.isCurrentVersionOk('1.1.0', '1.0.0'), true);
      expect(controller.isCurrentVersionOk('1.0.1', '1.0.0'), true);
      expect(controller.isCurrentVersionOk('2.1.1', '1.0.0'), true);
    });

    test('returns false when current version is less than mandatory version',
        () {
      expect(controller.isCurrentVersionOk('1.0.0', '2.0.0'), false);
      expect(controller.isCurrentVersionOk('1.0.0', '1.1.0'), false);
      expect(controller.isCurrentVersionOk('1.0.0', '1.0.1'), false);
      expect(controller.isCurrentVersionOk('1.0.0', '2.1.1'), false);
    });
  });
}

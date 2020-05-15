import 'package:flutter_test/flutter_test.dart';
import 'package:superbikelock/lock_confirm_screen.dart';
import 'package:superbikelock/model/lock_model.dart';

void main() {
  test('title', () {
    // setup

    // run

    // verify
  });

  test('call lock_and_unlock on locked lock, expect lock.available to be true', () {
    Lock lock = Lock(
        "Lock 1", "Lock 1 Description", "Belongs to rack 1", false);

    lock_confirm_screen_state detail_screen = lock_confirm_screen_state();

    detail_screen.lock_and_unlock(lock);

    expect(lock.available, true);
  });

  test('call lock_and_unlock on unlocked lock, expect lock.available to be false', () {
    Lock lock = Lock("Lock 1", "Lock 1 Description", "Belongs to rack 1", true);

    lock_confirm_screen_state detail_screen = lock_confirm_screen_state();

    detail_screen.lock_and_unlock(lock);

    expect(lock.available, false);
  });
}
import 'package:flutter_test/flutter_test.dart';
import 'package:superbikelock/model/lock_model.dart';
import 'package:superbikelock/view/lock_confirm_screen.dart';

void main() {
  test('title', () {
    // setup

    // run

    // verify
  });

  test('call lock_and_unlock on locked lock, expect lock.available to be true', () {
    Lock lock = Lock("lockid", "Lock 1", "Lock 1 Description",
        "b80e7c2a-91d1-4718-a1f3-2e2c7d260646", false);

    lock_confirm_screen_state detail_screen = lock_confirm_screen_state();

    detail_screen.lock_and_unlock(lock);

    expect(lock.available, true);
  });

  test('call lock_and_unlock on unlocked lock, expect lock.available to be false', () {
    Lock lock = Lock("lockid", "Lock 1", "Lock 1 Description",
        "b80e7c2a-91d1-4718-a1f3-2e2c7d260646", true);

    lock_confirm_screen_state detail_screen = lock_confirm_screen_state();

    detail_screen.lock_and_unlock(lock);

    expect(lock.available, false);
  });
}
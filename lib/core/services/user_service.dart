import 'package:aomlah/core/app/app.locator.dart';
import 'package:aomlah/core/services/realtime_wallet_service.dart';
import 'package:aomlah/core/services/supabase_service.dart';
import 'package:rxdart/rxdart.dart';

import 'package:aomlah/core/app/logger.dart';
import 'package:aomlah/core/models/aomlah_user.dart';

class UserService {
  late AomlahUser user;

  final _logger = getLogger("UserService");

  final _supabaseService = locator<SupabaseService>();
  final _realtimeWalletService = locator<RealtimeWalletService>();

  BehaviorSubject<AomlahUser> userController = BehaviorSubject<AomlahUser>();

  Future<void> initUser(String uuid) async {
    final user = await _supabaseService.getUser(uuid);
    updateUser(user);
    _realtimeWalletService.connectSocket(user.wallet?.address ?? "");
  }

  void updateUser(AomlahUser user) {
    _logger.i("updateUser | user=${user.toString()}");

    this.user = user;
    userController.add(user);
  }
}

import 'package:aomlah/core/app/app.locator.dart';
import 'package:aomlah/core/app/logger.dart';
import 'package:aomlah/core/app/utils/currency_helper.dart';
import 'package:aomlah/core/enums/trade_state.dart';
import 'package:aomlah/core/models/trade.dart';
import 'package:aomlah/core/models/wallet.dart';
import 'package:aomlah/core/services/supabase_service.dart';
import 'package:aomlah/core/services/user_service.dart';
import 'package:aomlah/core/services/wallet_managment_service.dart';

class TradingService {
  final _logger = getLogger("TradingService");

  final _supabaseService = locator<SupabaseService>();
  final _userService = locator<UserService>();
  final _walletManService = locator<WalletManagmentService>();

  Future<Trade> createTrade(Trade trade) async {
    _logger.i("createTrade");

    if (!trade.offer!.isBuyTrader) {
      await updateDebt(trade.amount);
    }
    return _supabaseService.createTrade(trade);
  }

  Future<void> updateTradeStatus({
    required Trade trade,
    required TradeStatus newStatus,
  }) async {
    _logger.i("cancelTrade | newStatus=$newStatus");

    if (newStatus == TradeStatus.canceled) {
      return cancelTrade(trade);
    } else if (!trade.offer!.isBuyTrader &&
        newStatus == TradeStatus.completed) {
      String to = trade.offer!.ownerWallet!.address;
      return sendTransaction(
        from: trade.traderWallet!,
        to: to,
        btcAmount: trade.amount,
      );
    }

    return _supabaseService.changeTradeStatus(trade.tradeId, newStatus);
  }

  Future<void> sendTransaction({
    required Wallet from,
    required String to,
    required double btcAmount,
  }) async {
    await _walletManService.sendAndSignTransaction(
      from: from,
      to: to,
      satAmount: CurrencyHelper.btcToSat(btcAmount),
    );
  }

  Future<void> cancelTrade(Trade trade) async {
    _logger.i("cancelTrade");

    // If the trade is a trader selling a coin revert the debte
    if (!trade.offer!.isBuyTrader) {
      updateDebt(-1 * trade.amount);
    }

    _supabaseService.changeTradeStatus(trade.tradeId, TradeStatus.canceled);
  }

  // Increases/decreases user deb +value for adding -value for subtracting
  Future<void> updateDebt(double debt) async {
    _logger.i("updateDebt | args: debt = $debt");

    final finalDebt = _userService.user.debt + debt;
    _supabaseService.updateUserDebt(_userService.user.profileId, finalDebt);
  }
}

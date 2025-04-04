import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';
import '../models/delivery_address.dart';
import '../models/payment_method.dart';
import '../models/order.dart';

class ProfileProvider with ChangeNotifier {
  UserProfile _user = UserProfile(
    id: '1',
    name: 'N V RAKESH',
    email: 'rakesh123@gmail.con',
    phoneNumber: '+1 234 567 8900',
    notificationsEnabled: true,
  );

  List<Order> _recentOrders = [];
  List<DeliveryAddress> _savedAddresses = [];
  List<PaymentMethod> _paymentMethods = [];
  bool _notificationsEnabled = true;

  UserProfile get user => _user;
  List<Order> get recentOrders => _recentOrders;
  List<DeliveryAddress> get savedAddresses => _savedAddresses;
  List<PaymentMethod> get paymentMethods => _paymentMethods;
  bool get notificationsEnabled => _notificationsEnabled;

  void updateUser(UserProfile newUser) {
    _user = newUser;
    notifyListeners();
  }

  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
  }

  void updateAddresses(List<DeliveryAddress> addresses) {
    _savedAddresses = addresses;
    notifyListeners();
  }

  void updatePaymentMethods(List<PaymentMethod> methods) {
    _paymentMethods = methods;
    notifyListeners();
  }

  void updateRecentOrders(List<Order> orders) {
    _recentOrders = orders;
    notifyListeners();
  }
}
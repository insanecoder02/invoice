import 'dart:async';
import 'package:flutter/material.dart';
import 'package:invoice/functions/core_function.dart' show navigatorByPushNamed;
import 'package:invoice/states/invoice_state.dart';
import 'package:invoice/states/security_state.dart';
import 'package:invoice/widgets/home/homeScreen/home_app_bar_widget.dart';
import 'package:invoice/widgets/home/homeScreen/home_bottom_navigation_bar_widget.dart';
import 'package:invoice/widgets/drawer/drawer_widget.dart';
import 'package:invoice/widgets/home/homeScreen/home_latest_invoice_list_widget.dart';
import 'package:invoice/widgets/home/homeScreen/home_floating_action_button_widget.dart';
import 'package:invoice/animations/heart_animation.dart';

class HomeScreen extends StatefulWidget {
  
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver, TickerProviderStateMixin {

  Timer? _timer;

  bool _isTimeOuted = false;

  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animationController.forward(from: 2);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();
    _cancelTimer();
    super.dispose();
  }

  void _cancelTimer() => _timer != null && _timer!.isActive ? _timer!.cancel() : null;

  void _animationHandler() {
    if(!_animationController.isAnimating) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  void _throwForAuthentication(SecurityState securityState) {
    securityState.changeIsCheckingSecurity(true);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    navigatorByPushNamed(context, '/passcode');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    SecurityState securityState = getSecurityState(context, listen: false);
    switch (state) {
      case AppLifecycleState.resumed:
        try {
          if(securityState.passcode != null && securityState.autoLockDuration != 0 && !securityState.isCheckingSecurity) {
            _cancelTimer();
            if(_isTimeOuted) {
              _throwForAuthentication(securityState);
            }
          }
          securityState.changeIsCheckingSecurity(false);
          _isTimeOuted = false;
        } catch(error) {
          _cancelTimer();
          _isTimeOuted = false;
          _throwForAuthentication(securityState);
        }
        break;
      case AppLifecycleState.paused:
        if(securityState.passcode != null && securityState.autoLockDuration != 0) {
          _cancelTimer();
          _timer = Timer(Duration(milliseconds: securityState.autoLockDuration), () {
            _isTimeOuted = true;
            _cancelTimer();
          });
        }
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
    }
  }

  Future<bool> _willPopScopeHandler() async {
    InvoiceState invoiceState = getInvoiceState(context, listen: false);
    
    if(invoiceState.selectedInvoices.isNotEmpty) {
      invoiceState.removeSelectedInvoices();
      return Future.value(false);
    }

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    bool isSelectedInvoice = getInvoiceState(context).selectedInvoices.isNotEmpty;

    return WillPopScope(
      onWillPop: _willPopScopeHandler,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: HomeAppBarWidget(_animationHandler),
        drawer: ! isSelectedInvoice ? const DrawerWidget() : null,
        body: Stack(
          children: [
            const HomeLatestInvoiceListWidget(),
            HeartAnimation(controller: _animationController.view)
          ]
        ),
        floatingActionButton: ! isSelectedInvoice ? const HomeFloatingActionButtonWidget() : null,
        bottomNavigationBar: isSelectedInvoice ? const HomeBottomNavigationBarWidget() : null,
      ),
    );
  }
}

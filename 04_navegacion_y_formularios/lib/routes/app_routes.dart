import 'package:flutter/material.dart';
import '../screens/event_form_screen.dart';
import '../screens/ticket_summary_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String summary = '/summary';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const EventFormScreen(),
      summary: (context) => const TicketSummaryScreen(),
    };
  }
}

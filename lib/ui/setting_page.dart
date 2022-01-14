import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtiga_restaurant/provider/preferences_provider.dart';
import 'package:subtiga_restaurant/provider/scheduling_provider.dart';
import 'package:subtiga_restaurant/ui/widget/platform_widget.dart';

class SettingPage extends StatelessWidget {
  static const routeName = "/setting_screen";
  const SettingPage({Key key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text(
          "Setting",
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            ListTile(
              title: const Text('Restaurant Alarm'),
              trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
                  return Switch.adaptive(
                    value: provider.isDailyRestaurantActive,
                    onChanged: (value) async {
                        scheduled.scheduledRestaurant(value);
                        provider.enableDailyRestaurant(value);
                      },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
    );
  }
}

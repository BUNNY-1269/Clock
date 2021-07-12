import 'package:firstapp/alarm_page.dart';
import 'package:firstapp/constants/theme_data.dart';
import 'package:firstapp/enums.dart';
import 'package:firstapp/menu_info.dart';
import 'package:firstapp/models/alarm_info.dart';


List<MenuInfo> menuItems=[
  MenuInfo(MenuType.clock,title: 'Clock',imageSource: 'clock_icon.png'),
  MenuInfo(MenuType.alarm,title: 'Alarm',imageSource: 'alarm_icon.png'),
  MenuInfo(MenuType.timer,title: 'Timer',imageSource: 'timer_icon.png'),
  MenuInfo(MenuType.stopwatch,title: 'Stopwatch',imageSource: 'stopwatch_icon.png'),

];


   List<AlarmInfo> alarms=[
      AlarmInfo(DateTime.now().add(Duration(hours: 1)), description: 'Office',gradientColors:GradientColors.sky),
      AlarmInfo(DateTime.now().add(Duration(hours: 1)), description: 'Sport',gradientColors: GradientColors.sunset),
   ];
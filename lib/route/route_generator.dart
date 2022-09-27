import 'package:apwen/screens/about_apwen.dart';
import 'package:apwen/screens/about_speakers.dart';
import 'package:apwen/screens/comments.dart';
import 'package:apwen/screens/home_page.dart';
import 'package:apwen/screens/panelists.dart';
import 'package:apwen/screens/programme.dart';
import 'package:apwen/screens/young_engineers/social_events.dart';
import 'package:apwen/screens/sponsors.dart';
import 'package:apwen/screens/stream_live.dart';
import 'package:apwen/screens/topics_speakers.dart';
import 'package:apwen/screens/young_engineers/questions.dart';
import 'package:apwen/screens/young_engineers/schedule_items/schedule.dart';
import 'package:apwen/screens/young_engineers/speakers.dart';
import 'package:apwen/screens/young_engineers/young_engineers_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );

      case TopicsSpeakers.routeName:
        return CupertinoPageRoute(
          builder: (_) => TopicsSpeakers(),
        );
      case AboutSpeaker.routeName:
        if (args is Map)
          return CupertinoPageRoute(
            builder: (_) => AboutSpeaker(
              index: args['index'],
              aboutSpeaker: args['about'],
              image: args['image'],
              name: args['name'],
            ),
          );
        return errorPage(settings);

      case Comments.routeName:
        if (args is Map)
          return CupertinoPageRoute(builder: (_) => Comments(id: args['id']));
        return errorPage(settings);
      case Sponsors.routeName:
        return CupertinoPageRoute(builder: (_) => Sponsors());
      case Programme.routeName:
        return CupertinoPageRoute(builder: (_) => Programme());
      case SocialEvents.routeName:
        return CupertinoPageRoute(builder: (_) => SocialEvents());
      case YoungEngineersHome.routeName:
        return CupertinoPageRoute(builder: (_) => YoungEngineersHome());
      case YoungEngineersSchedule.routeName:
        return CupertinoPageRoute(builder: (_) => YoungEngineersSchedule());
      case AboutAPWEN.routeName:
        return CupertinoPageRoute(builder: (_) => AboutAPWEN());
      case YoungEngineersSpeakers.routeName:
        return CupertinoPageRoute(builder: (_) => YoungEngineersSpeakers());

      case Questions.routeName:
        return CupertinoPageRoute(builder: (_) => Questions());

      case StreamLive.routeName:
        return CupertinoPageRoute(builder: (_) => StreamLive());

      case Panelists.routeName:
        return CupertinoPageRoute(builder: (_) => Panelists());

      default:
        return errorPage(settings);
    }
  }

  static Route<dynamic> errorPage(settings) {
    return CupertinoPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('An error occurred. Page does not exist'),
        ),
      );
    });
  }
}

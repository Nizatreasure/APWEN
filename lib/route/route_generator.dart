import 'package:apwen/screens/about_apwen.dart';
import 'package:apwen/screens/about_speakers.dart';
import 'package:apwen/screens/comments.dart';
import 'package:apwen/screens/home_page.dart';
import 'package:apwen/screens/programme.dart';
import 'package:apwen/screens/social_events.dart';
import 'package:apwen/screens/sponsors.dart';
import 'package:apwen/screens/topic_brief.dart';
import 'package:apwen/screens/topics_speakers.dart';
import 'package:apwen/screens/young_engineers/schedule_items/schedule.dart';
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
        return MaterialPageRoute(
          builder: (_) => TopicsSpeakers(),
        );
      case AboutSpeaker.routeName:
        if (args is Map)
          return CupertinoPageRoute(
            builder: (_) => AboutSpeaker(
              index: args['index'],
              aboutSpeaker: args['aboutSpeakers'],
              image: args['image'],
              name: args['name'],
            ),
          );
        return errorPage(settings);
      case TopicBrief.routeName:
        if (args is Map)
          return CupertinoPageRoute(
            builder: (_) => TopicBrief(
                index: args['index'],
                aboutSpeaker: args['aboutSpeaker'],
                aboutTopic: args['aboutTopic'],
                id: args['id'],
                image: args['image'],
                name: args['name'],
                topic: args['topic']),
          );
        return errorPage(settings);
      case Comments.routeName:
        if (args is Map)
          return MaterialPageRoute(builder: (_) => Comments(id: args['id']));
        return errorPage(settings);
      case Sponsors.routeName:
        return MaterialPageRoute(builder: (_) => Sponsors());
      case Programme.routeName:
        return MaterialPageRoute(builder: (_) => Programme());
      case SocialEvents.routeName:
        return MaterialPageRoute(builder: (_) => SocialEvents());
      case YoungEngineersHome.routeName:
        return MaterialPageRoute(builder: (_) => YoungEngineersHome());
      case YoungEngineersSchedule.routeName:
        return CupertinoPageRoute(builder: (_) => YoungEngineersSchedule());
      case AboutAPWEN.routeName:
        return MaterialPageRoute(builder: (_) => AboutAPWEN());

      default:
        return errorPage(settings);
    }
  }

  static Route<dynamic> errorPage(settings) {
    return MaterialPageRoute(builder: (_) {
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

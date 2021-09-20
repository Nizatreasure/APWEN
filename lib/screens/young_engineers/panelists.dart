import 'package:apwen/screens/young_engineers/p_and_s_about.dart';
import 'package:flutter/material.dart';

class YoungEngineersPanelists extends StatelessWidget {
  static const String routeName = '/youngengineerspanelists';
  YoungEngineersPanelists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 5, top: 5),
          child: RichText(
            text: TextSpan(
              style:
                  Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 21),
              children: [
                TextSpan(text: 'P'),
                TextSpan(text: 'A'),
                TextSpan(text: 'N'),
                TextSpan(text: 'E'),
                TextSpan(
                  text: 'L',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                TextSpan(text: 'I'),
                TextSpan(text: 'S'),
                TextSpan(text: 'T'),
                TextSpan(text: 'S'),
              ],
            ),
          ),
        ),
        toolbarHeight: 65,
        elevation: 1,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(height: 20),
              ListTile(
                leading: Hero(
                  tag: 'image$index',
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red[200]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        'assets/y_panelists/${index + 1}.jpg',
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                      context, YoungEngineersPAndSAbout.routeName,
                      arguments: {
                        'index': index,
                        'path': 'y_panelists/${index + 1}.jpg',
                        'about': panelists[index].about,
                        'subAbout': panelists[index].subAbout,
                        'name': panelists[index].name
                      });
                },
                title: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    panelists[index].name,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat'),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4, left: 10),
                  child: Text(
                    panelists[index].title,
                    style: TextStyle(
                        fontSize: 15, fontFamily: 'Lato', height: 1.3),
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 70, right: 10),
                  child: Divider(
                    color: Colors.black,
                  ))
            ],
          );
        },
        itemCount: panelists.length,
      ),
    );
  }

  final List<YEPanelistsAndSpeakers> panelists = [
    YEPanelistsAndSpeakers(
      name: 'Saadat Aliyu',
      title: 'Founder Shamrock Innovations - A Tech Innovation Hub in Kano',
      about: [
        'Founder, Shamrock Innovations - a Tech Innovation Hub in Kano',
        'Women In Tech Advocate & a Technology Community Builder',
        'Mobile Application Developer',
        'Developed HELPIO – an app to help victims of sexual abuse report case anonymously without stigmatization - in collaboration with NGOs fighting against sexual and gender-based violence (SGBV). Victims can also get medical, legal, financial and psychological assistance',
        'HELPIO was showcased on Al Jazeera in April 2021',
        'Awards & Recognition'
      ],
      subAbout: [
        '60 Women Champions Nigeria; Business Day ',
        '2020 Top 100 Women in Tech; #100WomentoTech Initiative',
        'Top 50 Northern Women in Tech; Jobberman/Startup Kano',
        'Merit Award, Advocating for Women in Technology, Youth Creative Forum.',
        '2021 Inspiring Women in Tech; JobberMan Nigeria'
      ],
    ),
    YEPanelistsAndSpeakers(
        name: 'Nanna Rimtip',
        title:
            'Lecturer, Department of Petroleum and Gas Engineering, Baze University Abuja.',
        about: [
          'Lecturer, Department of Petroleum and Gas Engineering, Baze University Abuja',
          'Holds a Bachelor’s degree in Petroleum Engineering from London South Bank University, Post-Graduate Diploma in Petroleum Engineering from Heriot-Watt University, Edinburgh; and a Master’s degree in Industrial Chemistry from Nile University, Abuja.',
          'Assistant Treasurer, Society of Petroleum Engineers, Abuja Section',
          'Research interests - developing environmentally friendly drilling fluids, smart/intelligent wells, petroleum economics and climate change.',
          'Passionate and committed to advancement of girls in STEM'
        ]),
    YEPanelistsAndSpeakers(
        name: 'Josephine Adah',
        title:
            'Final Year Civil Engineering Student at the University of Nigeria, Nsukka.',
        about: [
          'Final year Civil Engineering student at University of Nigeria, Nsukka',
          'Seeks to revolutionize the world of  Civil Engineering with technology in areas of Virtual Reality, Data Science, Building Information Modelling (BIM), Machine Learning, and Additive Manufacturing.',
          'A team player, an empathetic and visionary leader who is equally self-aware, solution-oriented, willing to make a positive difference and empower others to achieve the same.',
          'A fervent advocate for quality education and gender equality',
          'Awards & Recognition'
        ],
        subAbout: [
          '2021 - Scholar, Nigeria Higher Education Foundation.',
          '2021 - EMEA & Global Scholar to attend Grace Hopper Celebration.',
          '2020 & 2021 - Excellence Officer Award; the Society of Petroleum Engineers (SPE)',
          '2019 - Scholar/Ambassador, Women in Leadership Award; SPE',
          '2018 - Scholar, Agbami Medical and Engineering scholarship.',
          '2017 - National Merit Award from Total E&P.'
        ]),
    YEPanelistsAndSpeakers(
      name: 'Kaltume Giwa',
      title: 'National Vice Chairman, Nigerian Institute of ICT Engineers.',
      about: [
        'Electrical Engineer with specialisation in Electronic/Telecommunication Engineering',
        'Diploma in Radio Frequency Spectrum Management, USA Telecommunications Training Institute',
        'National Vice Chairman, Nigerian Institute of ICT Engineers (NIICTE)',
        'Pioneer Project Director, APWEN Abuja Biennial Magazine',
        'Works at National Broadcasting Commission - the agency responsible for Broadcast Regulation in Nigeria and ongoing Digital Terrestrial Transition (DTT); i.e.migration from analogue to digital TV broadcasting',
        'Member, Technical Advisory Committee (TAC) on Nigeria\'s participation at International Telecommunication Union (ITU)',
        'Currently working on the GE 84 Plan Optimization Project for Africa, an ITU & ATU initiative',
        'Volunteer, SciETech academic program & Counsellor/adviser for girls and youth in STEM'
      ],
    )
  ];
}

class YEPanelistsAndSpeakers {
  String title;
  String name;
  List<String> about;
  List<String> subAbout;
  YEPanelistsAndSpeakers(
      {required this.name,
      required this.title,
      required this.about,
      this.subAbout = const []});
}

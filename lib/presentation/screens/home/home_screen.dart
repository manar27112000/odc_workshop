import 'package:flutter/material.dart';

import '../../../constants/app_assets.dart';
import '../../../data/Models/home_card_model.dart';
import '../../views/home_card_item.dart';
import '../events/events_screen.dart';
import '../finals/finals_screen.dart';
import '../lectures/lectures_screen.dart';
import '../midterms/midterms_screen.dart';
import '../notes/notes_screen.dart';
import '../sections/sections_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  List<HomeCardModel> homeCards = [
    HomeCardModel(
        title: 'Lectures', image: lecturesIconSVG, screen: LecturesScreen()),
    HomeCardModel(
        title: 'Section', image: sectionsIconSVG, screen: SectionsScreen()),
    HomeCardModel(
        title: 'Midterm', image: midtermIconSVG, screen: MidtermScreen()),
    HomeCardModel(title: 'Final', image: finalIconSVG, screen: FinalsScreen()),
    HomeCardModel(title: 'Events', image: eventIconSVG, screen: EventsScreen()),
    HomeCardModel(title: 'Notes', image: notesIconSVG, screen: NotesScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width / 30),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: size.height / 30),
                child: Image.asset(
                  odcImagePng,
                  height: size.height / 11,
                  width: size.width / 1.5,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: size.height/1.5,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 5),
                  itemBuilder: (context, index) {
                    return HomeCard(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => homeCards[index].screen,
                              ));
                        },
                        image: homeCards[index].image,
                        title: homeCards[index].title);
                  },
                  itemCount: homeCards.length,
                ),
              )
            ],
          ),
        ));
  }
}

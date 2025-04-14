import 'package:flutter/material.dart';
import '../Resources/colors.dart';
import '../Resources/constants.dart';
import 'Label.dart';
import 'kCard.dart';

ValueNotifier activePageNotifier = ValueNotifier(0);

class KNavigationBar extends StatelessWidget {
  final List navList;
  String get navIconPath => "$kIconPath/navigation";
  const KNavigationBar({super.key, required this.navList});

  @override
  Widget build(BuildContext context) {
    return KCard(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 5,
      ).copyWith(bottom: 10),
      color: Kolor.scaffold,
      radius: 0,
      child: SafeArea(
        child: Row(
          spacing: 5,
          children:
              navList
                  .map(
                    (e) => btn(
                      icon: e['icon'],
                      index: e['index'],
                      label: e['label'],
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }

  Widget btn({
    required IconData icon,
    required int index,
    required String label,
  }) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: activePageNotifier,
        builder: (context, activePage, _) {
          final selected = activePage == index;
          return InkWell(
            onTap: () {
              activePageNotifier.value = index;
            },
            child: Column(
              spacing: 7,
              mainAxisSize: MainAxisSize.min,
              children: [
                KCard(
                  color: selected ? Kolor.secondary : Kolor.scaffold,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  child: Icon(
                    icon,
                    color: selected ? Kolor.tertiary : Kolor.fadeText,
                  ),
                ),
                Label(
                  label,
                  weight: selected ? 700 : 600,
                  color: selected ? null : Kolor.fadeText,
                  fontSize: 13,
                ).regular,
              ],
            ),
          );
        },
      ),
    );
  }
}

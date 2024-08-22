import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class NumberPage extends StatefulWidget {
  const NumberPage({super.key});

  @override
  State<NumberPage> createState() => _NumberPageState();
}

class _NumberPageState extends State<NumberPage> {
  var hour = 0;
  var minute = 0;
  var timeFormat = "AM";

  @override
  Widget build(BuildContext context) {
    // Utiliser le thème actuel pour obtenir les couleurs
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final selectedTextColor = theme.colorScheme.inversePrimary;
    final borderColor = theme.dividerColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Pick Your Time! ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $timeFormat",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23 * 0.7, // Réduction de la taille de la police
              color: textColor,
            ),
          ),
          const SizedBox(
            height: 10 * 0.7, // Réduction de la hauteur de l'espace
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20 * 0.7,
              vertical: 10 * 0.7, // Réduction du padding
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme
                  .surface, // Utiliser la couleur de surface du thème
              borderRadius:
                  BorderRadius.circular(10 * 0.7), // Réduction du border radius
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberPicker(
                  minValue: 0,
                  maxValue: 12,
                  value: hour,
                  zeroPad: true,
                  infiniteLoop: true,
                  itemWidth: 80 * 0.7, // Réduction de la largeur de l'item
                  itemHeight: 60 * 0.7, // Réduction de la hauteur de l'item
                  onChanged: (value) {
                    setState(() {
                      hour = value;
                    });
                  },
                  textStyle: TextStyle(
                    color: textColor,
                    fontSize: 20 * 0.7, // Réduction de la taille de la police
                  ),
                  selectedTextStyle: TextStyle(
                    color: selectedTextColor,
                    fontSize: 30 * 0.7, // Réduction de la taille de la police
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: borderColor),
                      bottom: BorderSide(color: borderColor),
                    ),
                  ),
                ),
                NumberPicker(
                  minValue: 0,
                  maxValue: 59,
                  value: minute,
                  zeroPad: true,
                  infiniteLoop: true,
                  itemWidth: 80 * 0.7, // Réduction de la largeur de l'item
                  itemHeight: 60 * 0.7, // Réduction de la hauteur de l'item
                  onChanged: (value) {
                    setState(() {
                      minute = value;
                    });
                  },
                  textStyle: TextStyle(
                    color: textColor,
                    fontSize: 20 * 0.7, // Réduction de la taille de la police
                  ),
                  selectedTextStyle: TextStyle(
                    color: selectedTextColor,
                    fontSize: 30 * 0.7, // Réduction de la taille de la police
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: borderColor),
                      bottom: BorderSide(color: borderColor),
                    ),
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          timeFormat = "AM";
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20 * 0.7,
                          vertical: 10 * 0.7, // Réduction du padding
                        ),
                        decoration: BoxDecoration(
                          color: timeFormat == "AM"
                              ? theme.colorScheme.primary
                              : theme.colorScheme.surface,
                          border: Border.all(
                            color: timeFormat == "AM"
                                ? theme.colorScheme.primary
                                : borderColor,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "AM",
                          style: TextStyle(
                            color: selectedTextColor,
                            fontSize:
                                25 * 0.7, // Réduction de la taille de la police
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15 * 0.7, // Réduction de la hauteur de l'espace
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          timeFormat = "PM";
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20 * 0.7,
                          vertical: 10 * 0.7, // Réduction du padding
                        ),
                        decoration: BoxDecoration(
                          color: timeFormat == "PM"
                              ? theme.colorScheme.primary
                              : theme.colorScheme.surface,
                          border: Border.all(
                            color: timeFormat == "PM"
                                ? theme.colorScheme.primary
                                : borderColor,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "PM",
                          style: TextStyle(
                            color: selectedTextColor,
                            fontSize:
                                25 * 0.7, // Réduction de la taille de la police
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

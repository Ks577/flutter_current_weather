import 'package:flutter/material.dart';

import 'colors.dart';

Widget bigContainer(String txtTemp, String image, String txtFeelsLike,
    String minTemp, String maxTemp) {
  return Container(
    width: 350,
    padding: const EdgeInsets.fromLTRB(5, 20, 25, 20),
    decoration: BoxDecoration(
      color: Colors.white12,
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          //  spreadRadius: 6,
          //blurRadius: 2,
          offset: const Offset(2, 5),
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(
          child: Image.network(image),
        ),
        Column(
          children: [
            Text(
              txtTemp,
              style: const TextStyle(fontSize: 45, color: textColor),
            ),
            Text(
              txtFeelsLike,
              style: const TextStyle(fontSize: 15, color: textColor),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              minTemp,
              style: const TextStyle(fontSize: 15, color: textColor),
            ),
            Text(
              maxTemp,
              style: const TextStyle(fontSize: 15, color: textColor),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget smallContainer(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
    height: 75,
    width: 80,
    decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              //  spreadRadius: 6,
              //blurRadius: 2,
              offset: const Offset(2, 5))
        ]),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(color: textColor),
      ),
    ),
  );
}

Widget sunContainer(String txtSunrise, String txtSunset) {
  return Container(
    width: 250,
    padding: const EdgeInsets.fromLTRB(10, 20, 20, 15),
    decoration: BoxDecoration(
      color: Colors.white12,
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.2),
            //  spreadRadius: 6,
            //blurRadius: 2,
            offset: const Offset(2, 5))
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Image.asset('assets/images/sunrise.gif', width: 50),
            Text(
              txtSunrise,
              style: const TextStyle(color: textColor),
            ),
          ],
        ),
        Column(
          children: [
            Image.asset('assets/images/sunset.gif', width: 50),
            Text(
              txtSunset,
              style: const TextStyle(color: textColor),
            ),
            // Text(DateFormat.j().format(_sunrise)),
          ],
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/app_colors.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_cached_image.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity person;
  const PersonDetailPage({required this.person, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: SingleChildScrollView(
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              person.name,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            PersonCacheImage(
              imageUrl: person.image,
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: person.status == "Alive" ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 20),
                Text(person.status),
              ],
            ),
            ..._textValueDescription("Gendre:", person.gender),
            ..._textValueDescription(
                "Number of episodes:", "${person.episode.length}"),
            ..._textValueDescription("Species:", person.species),
            ..._textValueDescription("Last location:", person.location.name),
            ..._textValueDescription("Origin:", person.origin.name),
            ..._textValueDescription("Was created:",
                "${person.created.year}-${person.created.month}-${person.created.day}")
          ]),
        ),
      ),
    );
  }

  List<Widget> _textValueDescription(String texts, String value) {
    return [
      const SizedBox(height: 20),
      Text(
        texts,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
            color: AppColors.greyColor),
      ),
      const SizedBox(height: 1),
      Text(value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          )),
    ];
  }
}

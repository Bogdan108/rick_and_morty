import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_cached_image.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity person;
  const PersonDetailPage({required this.person, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail info')),
      body: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Expanded(flex: 1, child: Text(person.name)),
        const SizedBox(height: 20),
        Flexible(
          fit: FlexFit.loose,
          flex: 1,
          child: PersonCacheImage(
            imageUrl: person.image,
            width: 200,
            height: 200,
          ),
        )
      ]),
    );
  }
}

import 'package:clean_architecture/features/domain/entities/person_entity.dart';
import 'package:clean_architecture/features/presentation/widgets/person_cache_image_widget.dart';
import 'package:flutter/material.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity person;

  const PersonDetailPage({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Character"), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 24),
            Text(
              person.name,
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12),
            PersonCacheImageWidget(
              width: 260,
              height: 260,
              imageUrl: person.image,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: person.status == "Alive" ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  person.status,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: 1,
                ),
              ],
            ),
            SizedBox(height: 16),
            if (person.type.isNotEmpty) ...{
              ...buildTextWidget('Type: ', person.type),
            },
            ...buildTextWidget('Gender: ', person.gender),
            ...buildTextWidget(
              'Number of episodes: ',
              person.episode.length.toString(),
            ),
            ...buildTextWidget('Species: ', person.species),
            ...buildTextWidget('Last known location: ', person.location.name),
            ...buildTextWidget('Origin: ', person.origin.name),
            ...buildTextWidget('Was created: ', person.created.toString()),
          ],
        ),
      ),
    );
  }

  List<Widget> buildTextWidget(String title, String value) {
    return [
      Text(title, style: TextStyle(color: Colors.grey)),
      SizedBox(height: 16),
      Text(value, style: TextStyle(color: Colors.white)),
      SizedBox(height: 4),
    ];
  }
}

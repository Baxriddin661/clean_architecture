import 'package:clean_architecture/features/domain/entities/person_entity.dart';
import 'package:clean_architecture/features/presentation/pages/person_detail_page.dart';
import 'package:clean_architecture/features/presentation/widgets/person_cache_image_widget.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  PersonEntity personResult;

  SearchResult({super.key, required this.personResult});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonDetailPage(person: personResult),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: PersonCacheImageWidget(imageUrl: personResult.image),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                personResult.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                personResult.location.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

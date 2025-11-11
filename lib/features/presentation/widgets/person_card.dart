import 'package:clean_architecture/common/app_colors.dart';
import 'package:clean_architecture/features/domain/entities/person_entity.dart';
import 'package:clean_architecture/features/presentation/widgets/person_cache_image_widget.dart';
import 'package:flutter/material.dart';

import '../pages/person_detail_page.dart';

class PersonCard extends StatelessWidget {
  final PersonEntity person;

  const PersonCard({required this.person, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => PersonDetailPage(person: person)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cellBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: PersonCacheImageWidget(
                imageUrl: person.image,
              ),
            ),

            SizedBox(width: 12),

            // RIGHT SIDE INFO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 6),

                  Row(
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: person.status == 'Alive'
                              ? Colors.green
                              : Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${person.status} - ${person.species}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  Text(
                    'Last known location:',
                    style: TextStyle(
                      color: AppColors.greyBackground,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    person.location.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Origin:',
                    style: TextStyle(color: AppColors.greyBackground),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${person.origin.name}',
                    style: TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}

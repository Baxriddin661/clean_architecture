import 'package:clean_architecture/common/app_colors.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_search_delegate.dart';
import '../widgets/persons_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: AppBar(
        title: Text('Characters'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              
              showSearch(context: context, delegate: CustomSearchDelegate());
              
            },
            icon: Icon(Icons.search),
            color: Colors.white,
          ),
        ],
      ),
    body: PersonsList(),
    );
  }
}

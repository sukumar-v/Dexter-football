import 'package:flutter/cupertino.dart';
import 'package:dexter/data/categories.dart';
import 'package:dexter/widgets/player_category_card.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.44,
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
      ),
      padding: EdgeInsets.only(left: 28, right: 28, bottom: 58),
      itemCount: categories.length,
      itemBuilder: (context, index) => PlayerCategoryCard(
        categories[index],
        onPress: () => Navigator.of(context).pushNamed("/playerdex"),
      ),
    );
  }
}

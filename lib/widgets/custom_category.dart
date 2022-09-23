import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/price_model.dart';

// ignore: must_be_immutable
class CustomCategory extends StatefulWidget {
  final bool enableMultiselect;
  List<String> selectedCategories;

  CustomCategory({
    Key? key,
    required this.enableMultiselect,
    required this.selectedCategories,
  }) : super(key: key);
  @override
  State<CustomCategory> createState() => _CustomCategoryState();
}

class _CustomCategoryState extends State<CustomCategory> {
  int selectOne = 0;
  List<int> selectMany = [];
  final List<String> categories = [
    "Arts & Entertainment",
    "Business & Career",
    "Communities & Lifestyles",
    "Cultures & Languages",
    "Health & Support",
    "Hobbies",
    "Internet & Technology",
    "Parenting & Family",
    "Pets & Animals",
    "Politics & Activism",
    "Religion & Beliefs",
    "Science",
    "Social",
    "Sports & Recreation",
    "Education",
    "Other"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
      child: SizedBox(
        width: 500,
        child: ChipList(
          shouldWrap: true,
          runSpacing: 0,
          spacing: 0,
          style: const TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w500,
              fontSize: 15),
          listOfChipNames: categories,
          listOfChipIndicesCurrentlySeclected:
              widget.enableMultiselect == true ? selectMany : [selectOne],

          extraOnToggle: (val) {
            if (widget.enableMultiselect != true) {
              selectOne = val;
              widget.selectedCategories.clear();
              widget.selectedCategories.add(categories[selectOne]);
              setState(() {});
            }
            if (widget.enableMultiselect == true) {
              //widget.selectedCategories.clear();
              // widget.selectedCategories.add(categories[selectOne]);
              setState(() {});
            }
          },

          supportsMultiSelect: widget.enableMultiselect,
          borderRadiiList: const [5],
          activeBgColorList: const [Color.fromARGB(225, 255, 183, 0)],
          inactiveBgColorList: const [Colors.grey],
          activeTextColorList: const [Colors.black],
          inactiveTextColorList: const [Colors.white70],
          activeBorderColorList: const [Colors.black12],
          //inactiveBorderColorList: const [Colors.black54],
        ),
      ),
    );
  }
}

class CustomPriceFilter extends StatelessWidget {
  final List<Price> prices;
  const CustomPriceFilter({Key? key, required this.prices}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: prices
          .map(
            (price) => InkWell(
              onTap: () {},
              child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    price.price,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w500),
                  )),
            ),
          )
          .toList(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lets_connect/widgets/custom_category.dart';
// ignore: unused_import
import '../../datamodels/price_model.dart';
import 'package:chip_list/chip_list.dart';
import 'package:intl/intl.dart';

class FilterEventsPage extends StatefulWidget {
  const FilterEventsPage({Key? key}) : super(key: key);
  @override
  State<FilterEventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<FilterEventsPage>
    with TickerProviderStateMixin {
  bool _value = false;
  double val = 20;

  TimeOfDay? startTime = TimeOfDay.now();
  TimeOfDay? endTime = TimeOfDay(hour: 11, minute: 59);
  late String? startTime_formatted = startTime?.format(context);
  late String? endTime_formatted = endTime?.format(context);

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 365));
  late String starttime_formatted = DateFormat.yMd().format(startDate);
  late String endtime_formatted = DateFormat.yMd().format(endDate);

  final _errordate = const SnackBar(
      content: Text('Cannot have end date before the selected start date!'));
  final _errortime = const SnackBar(
      content: Text('Cannot have end time before the selected start time!'));

  _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
        starttime_formatted = DateFormat.yMd().format(startDate);
      });
    }
  }

  _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != startDate) {
      setState(() {
        endDate = picked;
        //var tempDifference = endDate.subtract)
        if (startDate.isBefore(endDate)) {
          endtime_formatted = DateFormat.yMd().format(endDate);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(_errordate);
        }
      });
    }
  }

  List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    var priceEnable = false;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Filters',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w800,
                fontSize: 25),
            textAlign: TextAlign.start,
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.restore),
              color: Colors.black,
              tooltip: 'Reset',
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          // color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Price',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
              CustomPriceFilter(prices: Price.prices),
              const Divider(
                height: 20,
                thickness: 0.5,
                indent: 0,
                endIndent: 0,
                color: Colors.grey,
              ),
              const Text('Group Category',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
              CustomCategory(
                enableMultiselect: true,
                selectedCategories: selectedCategories,
              ),
              const Divider(
                height: 20,
                thickness: 0.5,
                indent: 0,
                endIndent: 0,
                color: Colors.grey,
              ),
              const Text('Date',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
              //CustomDateFilter(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text("Start: "),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(
                            225, 255, 183, 0), // Background color
                      ),
                      //style: ButtonStyle(backgroundColor: Colors.orange),
                      onPressed: () {
                        _selectStartDate(context);
                      },
                      child: Text(starttime_formatted.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'QuickSand',
                            fontSize: 17,
                          )),
                    ),
                  ),
                  const Text("  ─  ",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w100)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(
                            225, 255, 183, 0), // Background color
                      ),
                      onPressed: () {
                        _selectEndDate(context);
                      },
                      child: Text(endtime_formatted.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'QuickSand',
                            fontSize: 17,
                          )),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 20,
                thickness: 0.5,
                indent: 0,
                endIndent: 0,
                color: Colors.grey,
              ),
              const Text('Location',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: const TextField(
                      keyboardType: TextInputType.number,
                      maxLength: 5,
                      decoration: InputDecoration(
                          helperText: "Ex: 10010", hintText: "Zip Code"),
                    ),
                  ),
                  Text(
                    "   ⎯   " + val.toInt().toString() + " miles",
                    style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                ],
              ),
              Wrap(
                children: [
                  Slider(
                    value: val,
                    onChanged: (value) {
                      setState(() {
                        val = value;
                      });
                    },
                    label: val.round().toString(),
                    min: 10,
                    max: 50,
                    inactiveColor: Colors.amberAccent,
                    activeColor: Colors.orange,
                  ),
                ],
              ),
              const Divider(
                height: 20,
                thickness: 0.5,
                indent: 0,
                endIndent: 0,
                color: Colors.grey,
              ),
              const Text('Time',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text("Start: "),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            225, 255, 183, 0), // Background color
                      ),
                      onPressed: () async {
                        TimeOfDay? newTime = await showTimePicker(
                            context: context, initialTime: startTime!);
                        if (newTime != null) {
                          setState(() {
                            startTime = newTime;
                            startTime_formatted = startTime?.format(context);
                          });
                        }
                      },
                      child: Text(startTime_formatted.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'QuickSand',
                            fontSize: 17,
                          )),
                    ),
                  ),
                  const Text("  ─  ",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w100)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            225, 255, 183, 0), // Background color
                      ),
                      onPressed: () async {
                        TimeOfDay? newTime = await showTimePicker(
                          context: context,
                          initialTime: endTime!,
                        );
                        if (newTime != null) {
                          setState(() {
                            endTime = newTime;
                            endTime_formatted = endTime?.format(context);
                          });
                        }
                      },
                      child: Text(endTime_formatted.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'QuickSand',
                            fontSize: 17,
                          )),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 20,
                thickness: 0.5,
                indent: 0,
                endIndent: 0,
                color: Colors.grey,
              ),
              Row(
                children: [
                  const Text('Only for 21+?',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w700,
                          fontSize: 18)),
                  const Spacer(),
                  Switch(
                    value: priceEnable,
                    onChanged: (value) {
                      setState(() {
                        priceEnable = value;
                      });
                    },
                    activeTrackColor: Colors.orangeAccent,
                    activeColor: Colors.orange,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// class CustomDateFilter extends StatelessWidget {
//   CustomDateFilter({Key? key}) : super(key: key);
//   DateTime beginning = DateTime.now();
//   DateTime future = DateTime.now().add(Duration(days: 365));
//   late final String _begginingFormatted = DateFormat.yMMMMd().format(beginning);
//   late final String _futureFormatted = DateFormat.yMMMMd().format(future);
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         // Text("Start: "),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ElevatedButton(
//             onPressed: () {
//               Scaffold(
//                   body: Container(
//                 child: SfDateRangePicker(),
//               ));
//             },
//             child: Text(_begginingFormatted.toString()),
//           ),
//         ),
//         const Text("─",
//             style: TextStyle(fontSize: 13, fontWeight: FontWeight.w100)),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ElevatedButton(
//             onPressed: () {},
//             child: Text(_futureFormatted.toString()),
//           ),
//         ),
//       ],
//     );
//   }
// }




// class CustomPriceFilter extends StatelessWidget {
//   final List<String> categories = [
//     "ANY",
//     "FREE",
//     "\$\$\$",
//   ];
//   CustomPriceFilter({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
//       child: SizedBox(
//         width: 500,
//         child: ChipList(
//           shouldWrap: true,
//           runSpacing: 5,
//           spacing: 0,
//           style: const TextStyle(
//               color: Colors.white,
//               fontFamily: 'Quicksand',
//               fontWeight: FontWeight.bold),
//           listOfChipNames: categories,
//           listOfChipIndicesCurrentlySeclected: [0],
//           supportsMultiSelect: false,
//           borderRadiiList: const [10],
//           activeBgColorList: const [Colors.orange],
//           inactiveBgColorList: const [Colors.grey],
//           activeTextColorList: const [Colors.white],
//           inactiveTextColorList: const [Colors.white70],
//           activeBorderColorList: const [Colors.black12],
//           //inactiveBorderColorList: const [Colors.black54],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

bool value = false;
bool showDialog = false;
List searchList = [];
List continents = [
  "Africa",
  "Europe",
  "Australia",
  "Asia",
  "South America",
  "North America",
  "Antartica"
];
List values = [false, false, false, false, false, false, false];

class Contains extends StatefulWidget {
  const Contains({
    Key? key,
  }) : super(key: key);

  @override
  State<Contains> createState() => _ContainsState();
}

class _ContainsState extends State<Contains> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Wrap(
          children: [
            SizedBox(
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Filter",
                            style: TextStyle(
                                fontFamily: "Axiforma",
                                fontWeight: FontWeight.w900),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.cancel))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Continent",
                            style: TextStyle(
                                fontFamily: "Axiforma",
                                fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  showDialog = !showDialog;
                                });
                              },
                              icon: const Icon(Icons.keyboard_arrow_down))
                        ],
                      ),
                      Visibility(
                        visible: showDialog,
                        child: Column(
                          children: [
                            ...List.generate(continents.length, (i) {
                              return CheckboxListTile(
                                  value: values[i],
                                  title: Text("${continents[i]}"),
                                  onChanged: ((bool? newValue) {
                                    setState(() {
                                      values[i] = newValue!;
                                      if (values[i] == true) {
                                        searchList.add(continents[i]);
                                        print(searchList);
                                      } else {
                                        searchList.remove(continents[i]);
                                        print(searchList);
                                      }
                                    });
                                  }));
                            }),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Timezone",
                            style: TextStyle(
                                fontFamily: "Axiforma",
                                fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.keyboard_arrow_down))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                for (var i = 0; i < values.length; i++) {
                                  values[i] = false;
                                  searchList = [];
                                }
                              },
                              child: const Text("Reset")),
                          ElevatedButton(
                              onPressed: () {}, child: Text("Show Results"))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

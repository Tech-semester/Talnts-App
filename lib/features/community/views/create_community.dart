import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:talnts_app/common/widgets/chip_input.dart';
import 'package:talnts_app/common/widgets/colors.dart';
import 'package:talnts_app/common/widgets/constants/constants.dart';
import 'package:talnts_app/common/widgets/textform_field.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class CreateCommunity extends StatefulWidget {
  const CreateCommunity({Key? key}) : super(key: key);

  @override
  State<CreateCommunity> createState() => _CreateCommunityState();
}

class _CreateCommunityState extends State<CreateCommunity> {

  final GlobalKey<ChipsInputState> _chipKey = GlobalKey();
  String? selectedPlatform;
  String? selectedStatus;
  List<String> inputValues = [];
  String? selectedCategories; // List to store selected options
  bool isDropdownOpen =
      false; // State to track whether dropdown is open or closed

  final TextEditingController _communityName = TextEditingController();
  final TextEditingController _communityDescription = TextEditingController();
  final TextEditingController _inviteLink = TextEditingController();
  final TextEditingController _instructions = TextEditingController();
  final TextEditingController _categories = TextEditingController();
  final TextEditingController _tags = TextEditingController();
  List<String> _myActivities = [];


  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Community',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LabelTextFormField(
                    controller: _communityName,
                    hintText: 'Community Name',
                    validator: (value) {
                      if (value != '') {
                        return null;
                      } else {
                        return "Community Name cannot be empty!";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: const Color.fromRGBO(130, 130, 130, 1),
                          width: 0.5),
                    ),
                    child: TextField(
                      controller: _communityDescription,
                      cursorColor: grey,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Community Description',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField2(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(130, 130, 130, 1),
                          width: 0.5,
                        ),
                      ),
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'Platform',
                      style: TextStyle(color: Color.fromRGBO(130, 130, 130, 1)),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 30,
                    style: const TextStyle(
                        color: Color.fromRGBO(130, 130, 130, 1)),
                    buttonHeight: 50,
                    buttonPadding: const EdgeInsets.only(left: 1, right: 10),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    items: platform
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onSaved: (value) {
                      selectedPlatform = value.toString();
                    },
                    onChanged: (value) {
                      setState(() {
                        selectedPlatform = value.toString();
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Please select a type";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField2(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(130, 130, 130, 1),
                          width: 0.1,
                        ),
                      ),
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'Status',
                      style: TextStyle(color: Color.fromRGBO(130, 130, 130, 1)),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 30,
                    style: const TextStyle(
                        color: Color.fromRGBO(130, 130, 130, 1)),
                    buttonHeight: 50,
                    buttonPadding: const EdgeInsets.only(left: 1, right: 10),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    items: communityTypes
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onSaved: (value) {
                      selectedStatus = value.toString();
                    },
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value.toString();
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Please select a type";
                      } else {
                        return null;
                      }
                    },
                  ),
                  if (selectedStatus != null &&
                      selectedStatus == "Open Community")
                    openCommunity(),
                  if (selectedStatus != null &&
                      selectedStatus == "Closed Community")
                    closedCommunity(),
                  const SizedBox(
                    height: 20,
                  ),
                  TagsInput(
                    inputValues: inputValues,
                    onTagAdded: (tag) {
                      setState(() {
                        inputValues.add(tag);
                      });
                    },
                    onTagRemoved: (tag) {
                      setState(() {
                        inputValues.remove(tag);
                      });
                    },
                  ),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: const Color.fromRGBO(130, 130, 130, 1),
                          width: 0.5),
                    ),
                    child: Wrap(
                      children: inputValues.map((value) {
                        return InputChip(
                          label: Text(value),
                          onDeleted: () {
                            setState(() {
                              inputValues.remove(value);
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: MultiSelectFormField(
                            autovalidate: AutovalidateMode.disabled,
                            chipBackGroundColor: Colors.blue,
                            chipLabelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                            dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                            checkBoxActiveColor: Colors.blue,
                            checkBoxCheckColor: Colors.white,
                            dialogShapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12.0))),
                            title: Text(
                              "My workouts",
                              style: TextStyle(fontSize: 16),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select one or more options';
                              }
                              return null;
                            },
                            dataSource: const [
                              {
                                "display": "Running",
                                "value": "Running",
                              },
                              {
                                "display": "Climbing",
                                "value": "Climbing",
                              },
                              {
                                "display": "Walking",
                                "value": "Walking",
                              },
                              {
                                "display": "Swimming",
                                "value": "Swimming",
                              },
                              {
                                "display": "Soccer Practice",
                                "value": "Soccer Practice",
                              },
                              {
                                "display": "Baseball Practice",
                                "value": "Baseball Practice",
                              },
                              {
                                "display": "Football Practice",
                                "value": "Football Practice",
                              },
                            ],
                            textField: 'display',
                            valueField: 'value',
                            okButtonLabel: 'OK',
                            cancelButtonLabel: 'CANCEL',
                            hintWidget: Text('Please choose one or more'),
                            initialValue: _myActivities,
                            onSaved: (value) {
                              if (value == null) return;
                              setState(() {
                                _myActivities = value;
                              });
                            },
                          ),
                        ),
                        Wrap(
                          spacing: 8.0, // Adjust the spacing between chips
                          children: _myActivities.map((activity) {
                            return Chip(
                              label: Text(activity),
                              onDeleted: () {
                                setState(() {
                                  _myActivities.remove(activity);
                                });
                              },
                              deleteIcon: Icon(Icons.cancel),
                              backgroundColor: Colors.blue,
                              labelStyle: TextStyle(color: Colors.white),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  )
                  // MultiSelectDropdown.simpleList(
                  //   list: categories,
                  //   initiallySelected: const [],
                  //   boxDecoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(15),
                  //   ),
                  //   onChange: (value) {
                  //     setState(() {
                  //       selectedCategories = value.toString();
                  //     });
                  //     // your logic
                  //   },
                  //   includeSearch: true,
                  // ),
                ],
              ),
            )),
      ),
    );
  }

  Widget openCommunity() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        LabelTextFormField(
          controller: _inviteLink,
          hintText: 'Invite Link/Instructions',
          labelstyle:
              const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          validator: (value) {
            if (value == null) {
              return 'Invite link is required!';
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }

  Widget closedCommunity() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        LabelTextFormField(
          controller: _instructions,
          hintText:
              'Instructions to join(email or phone number of group admin)',
          labelstyle:
              const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          validator: (value) {
            if (value == null) {
              return 'Field is required!';
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}

class TagsInput extends StatefulWidget {
  final List<String> inputValues;
  final Function(String) onTagAdded;
  final Function(String) onTagRemoved;

  const TagsInput({
    Key? key,
    required this.inputValues,
    required this.onTagAdded,
    required this.onTagRemoved,
  }) : super(key: key);

  @override
  _TagsInputState createState() => _TagsInputState();
}

class _TagsInputState extends State<TagsInput> {
  final TextEditingController _tagsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: widget.inputValues.map((value) {
            return InputChip(
              label: Text(value),
              onDeleted: () {
                widget.onTagRemoved(value);
              },
            );
          }).toList(),
        ),
        LabelTextFormField(
          controller: _tagsController,
          hintText: 'Tags',
          onChanged: (value) {
            if (value.endsWith(' ')) {
              widget.onTagAdded(value.trim());
              _tagsController.clear();
            }
          },
        ),
      ],
    );
  }
}


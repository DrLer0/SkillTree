import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skilltree_app/screens/screens.dart';
import 'package:skilltree_app/res/custom_colors.dart';
import 'package:skilltree_app/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skilltree_app/utils/validator.dart';
import 'package:skilltree_app/utils/checkbox_state.dart';

class AddSkillForm extends StatefulWidget {
  final FocusNode nameFocusNode;
  final FocusNode notesFocusNode;

  const AddSkillForm(
      {Key? key, required this.nameFocusNode, required this.notesFocusNode})
      : super(key: key);
  @override
  _AddSkillFormState createState() => _AddSkillFormState();
}

class _AddSkillFormState extends State<AddSkillForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  bool value = false;

  TimeOfDay selectedTime = TimeOfDay.now();

  List selectedDays = List.empty(growable: true);

  final days = {
    CheckBoxState(title: 'Sun'),
    CheckBoxState(title: 'Mon'),
    CheckBoxState(title: 'Tue'),
    CheckBoxState(title: 'Wed'),
    CheckBoxState(title: 'Thu'),
    CheckBoxState(title: 'Fri'),
    CheckBoxState(title: 'Sat'),
  };

  final GlobalKey<FormState> _addSkillFormKey = GlobalKey<FormState>();

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SkillScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Future<void> _startDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
      });
    }
  }

  Future<void> _endDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(startDate.day, startDate.month, startDate.year),
        lastDate: DateTime(2101));
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Widget createAlarm(CheckBoxState checkbox) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: CustomColors.firebaseAmber,
        title: Text(checkbox.title,
            style: TextStyle(fontSize: 15, color: CustomColors.firebaseAmber)),
        onChanged: (bool? value) => setState(() => {checkbox.value = value!}),
        value: checkbox.value,
      );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _addSkillFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            child: Column(
              children: [
                CustomFormField(
                  controller: _nameController,
                  focusNode: widget.nameFocusNode,
                  keyboardType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  isCapitalized: true,
                  validator: (value) => Validator.validateName(
                    name: value,
                  ),
                  label: 'Name',
                  hint: 'Enter skill name',
                ),
                SizedBox(height: 16.0),
                Text(
                  'Start Date',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      color: CustomColors.firebaseYellow),
                ),
                ElevatedButton(
                  onPressed: () => _startDate(context),
                  style: ElevatedButton.styleFrom(
                    primary: CustomColors.firebaseGrey.withOpacity(0.2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 10),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                  child: Text("${startDate.toLocal()}".split(' ')[0],
                      style: TextStyle(
                          fontSize: 15.0, color: CustomColors.firebaseAmber)),
                ),
                SizedBox(height: 16.0),
                Text(
                  'End Date',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      color: CustomColors.firebaseYellow),
                ),
                ElevatedButton(
                  onPressed: () => _endDate(context),
                  style: ElevatedButton.styleFrom(
                    primary: CustomColors.firebaseGrey.withOpacity(0.2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 10),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                  child: Text("${endDate.toLocal()}".split(' ')[0],
                      style: TextStyle(
                          fontSize: 15.0, color: CustomColors.firebaseAmber)),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Set Alarm',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      color: CustomColors.firebaseYellow),
                ),
                ...days.map(createAlarm).toList(),
                SizedBox(height: 16.0),
                Text(
                  'Notify at',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      color: CustomColors.firebaseYellow),
                ),
                InkWell(
                  onTap: () {
                    _selectTime(context);
                  },
                  child: Text("$selectedTime".split('(')[1].split(')')[0],
                      style: TextStyle(
                          fontSize: 15.0, color: CustomColors.firebaseAmber)),
                ),
                SizedBox(height: 16.0),
                CustomFormField(
                  controller: _notesController,
                  focusNode: widget.notesFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  label: 'Notes',
                  hint: 'Notes',
                  validator: (String value) {},
                ),
                // )
              ],
            ),
          ),
          SizedBox(height: 24.0),
          Padding(
            padding: EdgeInsets.only(left: 0.0, right: 0.0),
            child: Container(
              width: double.maxFinite,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    CustomColors.firebaseAmber,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () async {
                  widget.nameFocusNode.unfocus();
                  widget.notesFocusNode.unfocus();
                  List<String> selectedDays = [];

                  for (var day in days) {
                    if (day.value == true) selectedDays.add(day.title);
                  }

                  if (_addSkillFormKey.currentState!.validate()) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    FirebaseFirestore.instance.collection('user_skills').add({
                      'user': prefs.getString('user').toString(),
                      'name': _nameController.text,
                      'startDate': startDate,
                      'endDate': endDate,
                      'reminderTime':
                          "$selectedTime".split('(')[1].split(')')[0],
                      'completionStatus': 0.0,
                      'notes': _notesController.text,
                      'selectedDays': selectedDays
                    });
                    Navigator.of(context).pushReplacement(
                      _routeToSignInScreen(),
                    );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.firebaseGrey,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

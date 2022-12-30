import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notes_app/models/note_model.dart';

import 'colors_list_view.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? title, subTitle;
  var time = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          TextFormField(
            onSaved: (value) {
              title = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter Text";
              }
              return null;
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Title",
              labelStyle: TextStyle(
                color: Colors.deepPurple.shade400, //<-- SEE HERE
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(color: Colors.black, width: 8),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            onSaved: (value) {
              subTitle = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter Text";
              }
              return null;
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
              labelText: "Notes",
              labelStyle: TextStyle(
                color: Colors.deepPurple.shade400, //<-- SEE HERE
              ),
              // labelStyle: TextStyle(color: Colors.white),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
            ),

            // hint: 'content',
            maxLines: 5,
          ),
          const SizedBox(
            height: 32,
          ),
          const ColorsListView(),
          const SizedBox(
            height: 32,
          ),
          BlocBuilder<AddNoteCubit, AddNoteState>(
            builder: (context, state) {
              return CustomButton(
                isLoading: state is AddNoteLoading ? true : false,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    var currentDate = DateTime.now();

                    var formattedCurrentDate =
                        DateFormat('dd-MM-yyy').format(currentDate);
                    var noteModel = NoteModel(
                        title: title!,
                        subTitle: subTitle!,
                        date: formattedCurrentDate,
                        color: Colors.blue.value);
                    BlocProvider.of<AddNoteCubit>(context).addNote(noteModel);
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                  if (formKey.currentState!.validate()) {
                    // ScaffoldMessenger.of(context)
                    //     .showSnackBar(SnackBar(content: Text("valid Data")));
                  } else {
                    // Text("Invalid data");
                  }
                },
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/views/widgets/colors_list_view.dart';
import 'package:notes_app/views/widgets/custom_app_bar.dart';
import 'package:notes_app/views/widgets/custom_text_field.dart';

import '../../constants.dart';
import 'edit_note_colors_list_view.dart';

class EditNoteViewBody extends StatefulWidget {
  const EditNoteViewBody({Key? key, required this.note}) : super(key: key);

  final NoteModel note;

  @override
  State<EditNoteViewBody> createState() => _EditNoteViewBodyState();
}

class _EditNoteViewBodyState extends State<EditNoteViewBody> {
  String? title, content;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              const Color(0xFF2C2B4B),
              const Color(0xFF2C2B7B),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            CustomAppBar(
              onPressed: () {
                widget.note.title = title ?? widget.note.title;
                widget.note.subTitle = content ?? widget.note.subTitle;
                widget.note.save();
                BlocProvider.of<NotesCubit>(context).fetchAllNotes();
                Navigator.pop(context);
              },
              title: 'Edit Note',
              icon: Icons.check,
            ),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              onChanged: (value) {
                title = value;
              },

              style: TextStyle(color: Colors.white),
              initialValue: widget.note.title,
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
              // hint: widget.note.title,
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              onChanged: (value) {
                content = value;
              },
              initialValue: widget.note.subTitle,
              maxLines: 5,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Notes",
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
            EditNoteColorsList(
              note: widget.note,
            ),
          ],
        ),
      ),
    );
  }
}

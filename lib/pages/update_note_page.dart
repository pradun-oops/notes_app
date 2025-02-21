import 'package:flutter/material.dart';
import 'package:notes/helper/db_helper.dart';
import 'package:notes/models/model.dart';
import 'package:notes/widgets/custom_text.dart';
import 'package:notes/widgets/custom_textfield.dart';

class UpdateNotePage extends StatefulWidget {
  final String? title;
  final String? desc;
  final int? id;
  bool isUpdated;
  UpdateNotePage(
      {super.key, this.title, this.desc, this.id, this.isUpdated = false});

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  TextEditingController updatedTitleController = TextEditingController();
  TextEditingController updatedDescriptionController = TextEditingController();
  DbHelper? mDb;

  @override
  void initState() {
    super.initState();
    mDb = DbHelper.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: CustomText(
          text: 'Update Note',
          size: 30,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60.0),
            child: Image.asset(
              "assets/logo/notes.png",
              width: 200,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          CustomTextfield(
            hint: 'Note Title',
            controller: updatedTitleController,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextfield(
            hint: 'Note Description',
            controller: updatedDescriptionController,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: CustomText(
                  text: "Cancel",
                  size: 18,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              OutlinedButton(
                onPressed: () async {
                  bool check = await mDb!.updateNote(
                    NoteModel(
                      nTitle: updatedTitleController.text,
                      nDescription: updatedDescriptionController.text,
                      nCreatedAt:
                          DateTime.now().microsecondsSinceEpoch.toString(),
                      nId: widget.id,
                    ),
                  );
                  if (check) {
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                },
                child: CustomText(
                  text: "Update",
                  size: 18,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

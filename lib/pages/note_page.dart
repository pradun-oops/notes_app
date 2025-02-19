import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:notes/color/color_list.dart';
import 'package:notes/helper/db_helper.dart';
import 'package:notes/models/model.dart';
import 'package:notes/widgets/custom_text.dart';
import 'package:notes/widgets/custom_textfield.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<NoteModel> mData = [];
  DbHelper? mDb;

  DateFormat df = DateFormat.yMMMEd();

  @override
  void initState() {
    super.initState();
    mDb = DbHelper.getInstance();
    getAllNotes();
  }

  void getAllNotes() async {
    mData = await mDb!.fetchAllNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: CustomText(
          text: 'Notes',
          size: 30,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: mData.isNotEmpty
          ? MasonryGridView.builder(
              itemCount: mData.length,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                var eachDate = DateTime.fromMicrosecondsSinceEpoch(
                  int.parse(mData[index].nCreatedAt),
                );
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: colorList[index]['color'],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Text(
                            mData[index].nTitle,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            mData[index].nDescription,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            df.format(eachDate),
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CustomText(
                text: 'No Notes Available',
                size: 20,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          titleController.clear();
          descriptionController.clear();
          showModalBottomSheet(
              context: context,
              builder: (_) {
                return Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      CustomText(
                        text: 'Add Note',
                        size: 20,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextfield(
                        hint: 'Note Title',
                        controller: titleController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextfield(
                        hint: 'Note Description',
                        controller: descriptionController,
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
                            child: Text('Cancel'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          OutlinedButton(
                            onPressed: () async {
                              bool check = await mDb!.addNote(
                                newNote: NoteModel(
                                  nTitle: titleController.text,
                                  nDescription: descriptionController.text,
                                  nCreatedAt: DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString(),
                                ),
                              );
                              if (check) {
                                getAllNotes();
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              }
                            },
                            child: Text('Save'),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

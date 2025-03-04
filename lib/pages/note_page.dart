import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:notes/color/color_list.dart';
import 'package:notes/models/model.dart';
import 'package:notes/pages/update_note_page.dart';
import 'package:notes/provider/db_provider.dart';
import 'package:notes/route/page_route.dart';
import 'package:notes/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController updatedTitleController = TextEditingController();
  TextEditingController updatedDescriptionController = TextEditingController();

  List<NoteModel> mData = [];

  DateFormat df = DateFormat.yMMMEd();

  @override
  void initState() {
    super.initState();
    context.read<DbProvider>().getInitialNotes();
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
      body: Consumer<DbProvider>(
        builder: (ctx, provider, child) {
          mData = provider.getAllNotes();
          return mData.isNotEmpty
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
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
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
                                    color: Colors.black87,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  df.format(eachDate),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.ROUTE_DETAIL_PAGE,
                              arguments: mData[index]);
                        },
                        onLongPress: () {
                          showBottomSheet(
                            backgroundColor: Colors.black,
                            context: context,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateNotePage(
                                                id: mData[index].nId,
                                              ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        child: CustomText(
                                          text: "Edit",
                                          textColor: Colors.black,
                                          size: 25,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          context.read<DbProvider>().deleteNote(
                                                mData[index].nId!,
                                              );
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        child: CustomText(
                                          text: "Delete",
                                          textColor: Colors.black,
                                          size: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logo/out-of-stock.png",
                        width: 250,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomText(
                        text: "No Notes found...",
                        size: 25,
                      ),
                    ],
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, AppRoutes.ROUTE_ADD_NOTE);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

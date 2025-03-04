import 'package:flutter/material.dart';
import 'package:notes/models/model.dart';
import 'package:notes/widgets/custom_text.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as NoteModel;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.white,
          ),
        ),
        title: CustomText(
          text: "Details Page",
          size: 30,
          textColor: Colors.white,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                children: [
                  CustomText(
                    text: args.nTitle,
                    size: 35,
                    textColor: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  CustomText(
                    text: args.nDescription,
                    size: 23,
                    textColor: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

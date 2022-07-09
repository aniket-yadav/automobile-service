import 'package:automobileservice/controller/data_controller.dart';
import 'package:automobileservice/widgets/custom_number_selection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFeedback extends StatefulWidget {
  const AddFeedback({Key? key}) : super(key: key);

  @override
  State<AddFeedback> createState() => _AddFeedbackState();
}

class _AddFeedbackState extends State<AddFeedback> {
  int rate = 5;
  TextEditingController commentController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 20.0,
              ),
              child: TextField(
                controller: commentController,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "Comment",
                ),
                minLines: 4,
                maxLines: null,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 20.0,
              ),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "Email",
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: const Text("Give rate to us"),
            ),
            CustomNumberSelection(
                minValue: 1,
                maxValue: 5,
                currentValue: rate,
                onChanged: (v) {
                  setState(() {
                    rate = v;
                  });
                }),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 20.0,
              ),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final comment = commentController.text.trim();
                  final email = emailController.text.trim();
                  if (comment.isNotEmpty && email.isNotEmpty) {
                    final dataProvider =
                        Provider.of<DataController>(context, listen: false);
                    dataProvider.addFeedback(
                        comment: comment, rate: rate, email: email);
                  } else {
                    print("object");
                  }
                },
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
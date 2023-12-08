import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_app/models/flashcard.dart';
import 'package:your_app/controllers/flashcard_controller.dart';

class FlashcardView extends StatelessWidget {
  final FlashcardController flashcardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcards'),
      ),
      body: Obx(() {
        final List<Flashcard> flashcards = flashcardController.flashcards;

        return PageView.builder(
          itemCount: flashcards.length,
          itemBuilder: (context, index) {
            final flashcard = flashcards[index];
            bool showQuestion = true;

            return GestureDetector(
              onTap: () {
                showQuestion = !showQuestion;
                // To update the UI after flipping the card
                Get.find<FlashcardController>().update();
              },
              onHorizontalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dx > 0) {
                  if (index > 0) {
                    // Swipe right to view previous flashcard
                    Get.find<FlashcardController>().goToPrevious();
                  }
                } else {
                  if (index < flashcards.length - 1) {
                    // Swipe left to view next flashcard
                    Get.find<FlashcardController>().goToNext();
                  }
                }
              },
              child: Card(
                elevation: 4,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: Text(
                    showQuestion ? flashcard.question : flashcard.answer,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

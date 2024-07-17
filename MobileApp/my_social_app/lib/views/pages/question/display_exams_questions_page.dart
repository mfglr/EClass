import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_social_app/state/exam_entity_state/actions.dart';
import 'package:my_social_app/state/exam_entity_state/exam_state.dart';
import 'package:my_social_app/state/question_entity_state/question_state.dart';
import 'package:my_social_app/state/state.dart';
import 'package:my_social_app/views/shared/app_back_button_widget.dart';
import 'package:my_social_app/views/shared/question/question_items_widget.dart';

class DisplayExamsQuestionsPage extends StatelessWidget {
  const DisplayExamsQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final exam = ModalRoute.of(context)!.settings.arguments as ExamState;
    
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButtonWidget(),
        title: Text(
          "Exam: ${exam.shortName}",
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: StoreConnector<AppState,Iterable<QuestionState>>(
        onInit: (store) => store.dispatch(NextPageOfExamQuestionsAction(examId: exam.id)),
        converter: (store) => store.state.questionEntityState.getBySubjectId(exam.id),
        builder: (context,questions) => QuestionItemsWidget(
          questions: questions.toList(),
        ),
      ),
    );
  }
}
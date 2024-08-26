import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_social_app/state/app_state/question_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/question_entity_state/question_state.dart';
import 'package:my_social_app/state/app_state/solution_entity_state/solution_state.dart';
import 'package:my_social_app/state/app_state/state.dart';
import 'package:my_social_app/views/shared/app_back_button_widget.dart';
import 'package:my_social_app/views/shared/loading_view.dart';
import 'package:my_social_app/views/solution/widgets/no_solutions.dart';
import 'package:my_social_app/views/solution/widgets/solution_items_widget.dart';

class DisplayQuestionCorrectSolutionsPage extends StatelessWidget {
  final int questionId;
  final int? solutionId;
  const DisplayQuestionCorrectSolutionsPage({
    super.key,
    required this.questionId,
    this.solutionId
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,QuestionState?>(
      onInit: (store) => store.dispatch(LoadQuestionAction(questionId: questionId)),
      converter: (store) => store.state.questionEntityState.entities[questionId],
      builder: (context,question){
        if(question == null) return const LoadingView();
        return Scaffold(
          appBar: AppBar(
            leading: const AppBackButtonWidget(),
            title: const Text(
              "Correct Solutions",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          body: StoreConnector<AppState,Iterable<SolutionState>>(
            onInit: (store) => store.dispatch(GetNextPageQuestionCorrectSolutionsIfNoPageAction(questionId: question.id)),
            converter: (store) => store.state.selectQuestionCorrectSolutions(question.id),
            builder:(context,solutions) => Builder(
              builder: (context) {
                if(question.correctSolutions.ids.isEmpty && question.correctSolutions.isLast){
                  return const NoSolutions(text: "No Correct Solutions",);
                }
                return SolutionItemsWidget(
                  solutions: solutions,
                  pagination: question.correctSolutions,
                  solutionId: solutionId,
                  onScrollBottom: (){
                    final store = StoreProvider.of<AppState>(context,listen: false);
                    store.dispatch(GetNextPageQuestionCorrectSolutionsIfReadyAction(questionId: question.id));
                  },
                );
              }
            )
          ),
        );
      }
    );
  }
}
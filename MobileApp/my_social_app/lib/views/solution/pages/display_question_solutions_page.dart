import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_social_app/constants/routes.dart';
import 'package:my_social_app/state/question_entity_state/actions.dart';
import 'package:my_social_app/state/question_entity_state/question_state.dart';
import 'package:my_social_app/state/solution_entity_state/solution_state.dart';
import 'package:my_social_app/state/state.dart';
import 'package:my_social_app/views/shared/app_back_button_widget.dart';
import 'package:my_social_app/views/shared/loading_view.dart';
import 'package:my_social_app/views/solution/widgets/no_solutions_widget.dart';
import 'package:my_social_app/views/solution/widgets/solution_items_widget.dart';

class DisplayQuestionSolutionsPage extends StatelessWidget {
  final int questionId;
  final int offset;

  const DisplayQuestionSolutionsPage({
    super.key,
    required this.questionId,
    required this.offset
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,QuestionState?>(
      onInit: (store) => store.dispatch(AddQuestionSolutionsPaginationAction(offset: offset, questionId: questionId)),
      converter: (store) => store.state.questionEntityState.entities[questionId],
      builder: (context,question){
        if(question == null) return const LoadingView();
        return Scaffold(
          appBar: AppBar(
            leading: const AppBackButtonWidget(),
            title: const Text(
              "Solutions",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          floatingActionButton: 
            !question.isOwner ? FloatingActionButton(
              onPressed: () => Navigator.of(context).pushNamed(addSolutionImagesRoute),
              shape: const CircleBorder(),
              child: const Icon(Icons.add),
            ) : null,
          body: StoreConnector<AppState,Iterable<SolutionState>>(
            onInit: (store) => store.dispatch(GetNextPageQuestionSolutionsIfNoPageAction(offset: offset, questionId: question.id)),
            converter: (store) => store.state.selectQuestionSolutions(offset,question.id),
            builder:(context,solutions) => Builder(
              builder: (context) {
                final pagination = question.solutionPaginations.selectPagination(offset);
                if(pagination.ids.isEmpty && pagination.isLast){
                  return NoSolutionsWidget(question: question);
                }
                return SolutionItemsWidget(
                  solutions: solutions,
                  pagination: pagination,
                  onScrollBottom: (){
                    final store = StoreProvider.of<AppState>(context,listen: false);
                    store.dispatch(GetNextPageQuestionSolutionsIfReadyAction(offset: offset, questionId: question.id));
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
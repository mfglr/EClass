import 'package:flutter/material.dart';
import 'package:my_social_app/state/app_state/create_comment_state/actions.dart';
import 'package:my_social_app/state/app_state/solution_entity_state/solution_state.dart';
import 'package:my_social_app/state/app_state/store.dart';
import 'package:my_social_app/views/comment/modals/display_solution_comments_modal.dart';

class SolutionCommentButtonWidget extends StatelessWidget {
  final SolutionState solution;
  const SolutionCommentButtonWidget({super.key,required this.solution});

 void showCommentModal(BuildContext context){
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => DisplaySolutionCommentsModal(solutionId: solution.id),
      isDismissible: true
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        showCommentModal(context);
        store.dispatch(ChangeSolutionAction(solution: solution));
      },
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 5),
            child: const Icon(Icons.mode_comment_outlined)
          ),
          Text(solution.numberOfComments.toString())
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_social_app/state/app_state/question_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/question_entity_state/question_state.dart';
import 'package:my_social_app/state/app_state/solution_entity_state/solution_state.dart';
import 'package:my_social_app/state/app_state/state.dart';
import 'package:my_social_app/views/shared/app_back_button_widget.dart';
import 'package:my_social_app/views/shared/label_pagination_widget/label_pagination_widget.dart';
import 'package:my_social_app/views/shared/loading_view.dart';
import 'package:my_social_app/views/solution/pages/display_question_correct_solutions_page.dart';
import 'package:my_social_app/views/solution/pages/display_question_incorrect_solutions_page.dart';
import 'package:my_social_app/views/solution/pages/display_question_pending_solutions_page.dart';
import 'package:my_social_app/views/solution/pages/display_question_solutions_page.dart';
import 'package:my_social_app/views/solution/pages/question_solutions_page.dart/widgets/create_solution_speed_dial.dart';
import 'package:my_social_app/views/solution/widgets/no_solutions.dart';
import 'package:my_social_app/views/solution/widgets/no_solutions_widget.dart';
import 'package:my_social_app/views/solution/widgets/solution_abstract_items.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const List<IconData> icons = [Icons.all_out_sharp, Icons.check, Icons.pending, Icons.close];

class QuestionsSolutionsPage extends StatefulWidget {
  final int questionId;
  const QuestionsSolutionsPage({
    super.key,
    required this.questionId
  });

  @override
  State<QuestionsSolutionsPage> createState() => _QuestionsSolutionsPageState();
}

class _QuestionsSolutionsPageState extends State<QuestionsSolutionsPage> {
  final PageController _pageController = PageController();
  late final void Function() _setPage;
  double _page = 0;

  @override
  void initState() {
    _setPage = (){
      setState(() {
        _page = _pageController.page ?? 0;
      });
    };
    _pageController.addListener(_setPage);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_setPage);
    _pageController.dispose();
    super.dispose();
  }


  Widget _displayAllSolutions(QuestionState question){
    return StoreConnector<AppState,Iterable<SolutionState>>(
      onInit: (store) => store.dispatch(GetNextPageQuestionSolutionsIfNoPageAction(questionId: widget.questionId)),
      converter: (store) => store.state.selectQuestionSolutions(widget.questionId),
      builder: (context,solutions) => SolutionAbstractItems(
        solutions: solutions,
        pagination: question.solutions,
        noItems: NoSolutionsWidget(question: question),
        onTap: (solutionId) =>
          Navigator
            .of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => DisplayQuestionSolutionsPage(
                  questionId: widget.questionId,
                  solutionId: solutionId,
                )
              )
            ),
        onScrollBottom: (){
          final store = StoreProvider.of<AppState>(context,listen: false);
          store.dispatch(GetNextPageQuestionSolutionsIfReadyAction(questionId: widget.questionId));
        },
      )
    );
  }

  Widget _displayAllCorrectSolutions(QuestionState question){
    return StoreConnector<AppState,Iterable<SolutionState>>(
      onInit: (store) => store.dispatch(GetNextPageQuestionCorrectSolutionsIfNoPageAction(questionId: widget.questionId)),
      converter: (store) => store.state.selectQuestionCorrectSolutions(widget.questionId),
      builder: (context,solutions) => SolutionAbstractItems(
        solutions: solutions,
        pagination: question.correctSolutions,
        noItems: NoSolutions(
          text: AppLocalizations.of(context)!.display_question_solutions_page_no_correct_solutins
        ),
        onTap: (solutionId) =>
          Navigator
            .of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => DisplayQuestionCorrectSolutionsPage(
                  questionId: widget.questionId,
                  solutionId: solutionId,  
                )
              )
            ),
        onScrollBottom: (){
          final store = StoreProvider.of<AppState>(context,listen: false);
          store.dispatch(GetNextPageQuestionCorrectSolutionsIfReadyAction(questionId: widget.questionId));
        },
      )
    );
  }

  Widget _displayPendingSolutions(QuestionState question){
    return StoreConnector<AppState,Iterable<SolutionState>>(
      onInit: (store) => store.dispatch(GetNextPageQuestionPendingSolutionsIfNoPageAction(questionId: widget.questionId)),
      converter: (store) => store.state.selectQuestionPendingSolutions(widget.questionId),
      builder: (context,solutions) => SolutionAbstractItems(
        solutions: solutions,
        pagination: question.pendingSolutions,
         noItems: NoSolutions(
          text: AppLocalizations.of(context)!.display_question_solutions_page_no_pending_solutions
        ),
        onTap: (solutionId) =>
          Navigator
            .of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => DisplayQuestionPendingSolutionsPage(
                  questionId: widget.questionId,
                  solutionId: solutionId,
                )
              )
            ),
        onScrollBottom: (){
          final store = StoreProvider.of<AppState>(context,listen: false);
          store.dispatch(GetNextPageQuestionPendingSolutionsIfReadyAction(questionId: widget.questionId));
        },
      )
    );
  }

  Widget _displayIncorrectSolutions(QuestionState question){
    return StoreConnector<AppState,Iterable<SolutionState>>(
      onInit: (store) => store.dispatch(GetNextPageQuestionIncorrectSolutionsIfNoPageAction(questionId: widget.questionId)),
      converter: (store) => store.state.selectQuestionIncorrectSolutions(widget.questionId),
      builder: (context,solutions) => SolutionAbstractItems(
        solutions: solutions,
        pagination: question.incorrectSolutions,
         noItems: NoSolutions(
          text: AppLocalizations.of(context)!.display_question_solutions_page_no_incorrect_solutions
        ),
        onTap: (solutionId) =>
          Navigator
            .of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => DisplayQuestionIncorrectSolutionsPage(
                  questionId: widget.questionId,
                  solutionId: solutionId,
                )
              )
            ),
        onScrollBottom: (){
          final store = StoreProvider.of<AppState>(context,listen: false);
          store.dispatch(GetNextPageQuestionIncorrectSolutionsIfReadyAction(questionId: widget.questionId));
        },
      )
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,QuestionState?>(
      onInit: (store) => store.dispatch(LoadQuestionAction(questionId: widget.questionId)),
      converter: (store) => store.state.questionEntityState.entities[widget.questionId],
      builder:(context,question){
        if(question == null) return const LoadingView();
        return Scaffold(
          appBar: AppBar(
            leading: const AppBackButtonWidget(),
            title: Text(
              AppLocalizations.of(context)!.display_question_solutions_page_title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          floatingActionButton: 
            !question.isOwner ? CreateSolutionSpeedDial(questionId: question.id) : null,
          body: Column(
            children: [
              LabelPaginationWidget(
                labelBuilder: (isActive,index) => Icon(
                  icons[index],
                  color: isActive ? Colors.black : Colors.grey,
                ),
                page: _page,
                labelCount: icons.length,
                width: MediaQuery.of(context).size.width,
                initialPage: 0,
                pageController: _pageController
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: [
                    _displayAllSolutions(question),
                    _displayAllCorrectSolutions(question),
                    _displayPendingSolutions(question),
                    _displayIncorrectSolutions(question),
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }

  
}
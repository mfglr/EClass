import 'package:flutter/widgets.dart';
import 'package:my_social_app/state/pagination.dart';
import 'package:my_social_app/state/question_entity_state/question_state.dart';
import 'package:my_social_app/views/shared/loading_circle_widget.dart';
import 'package:my_social_app/views/question/widgets/question_item_widget.dart';
import 'package:my_social_app/views/shared/space_saving_widget.dart';

class QuestionItemsWidget extends StatefulWidget {
  final Pagination pagination;
  final int questionIndex;
  final Iterable<QuestionState> questions;
  final Function onScrollBottom;
  
  const QuestionItemsWidget({
    super.key,
    required this.questionIndex,
    required this.questions,
    required this.pagination,
    required this.onScrollBottom
  });

  @override
  State<QuestionItemsWidget> createState() => _QuestionItemsWidgetState();
}

class _QuestionItemsWidgetState extends State<QuestionItemsWidget> {
  final ScrollController _scrollController = ScrollController();
  late final void Function() _onScrollBottom;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    _onScrollBottom = (){
      if(_scrollController.hasClients && _scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        widget.onScrollBottom();
      }
    };
    _scrollController.addListener(_onScrollBottom);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(_key.currentContext != null){
        Scrollable.ensureVisible(_key.currentContext!);
      }
    });

    super.initState();
  }
 
  @override
  void dispose() {
    _scrollController.removeListener(_onScrollBottom);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          ...List.generate(
            widget.questions.length,
            (index) => Container(
              key: index == widget.questionIndex ? _key : null,
              margin: const EdgeInsets.only(bottom: 16),
              child: QuestionItemWidget(question: widget.questions.elementAt(index))
            ),
          ),
          Builder(
            builder: (context){
              if(widget.pagination.loading){
                return const LoadingCircleWidget(strokeWidth: 3);
              }
              return const SpaceSavingWidget();
            } 
          )
        ]
      ),
    );
  }
}
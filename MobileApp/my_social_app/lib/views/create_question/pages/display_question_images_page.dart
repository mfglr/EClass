import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_social_app/constants/routes.dart';
import 'package:my_social_app/state/create_question_state/actions.dart';
import 'package:my_social_app/state/create_question_state/create_question_state.dart';
import 'package:my_social_app/state/state.dart';
import 'package:my_social_app/utilities/toast_creator.dart';
import 'package:my_social_app/views/create_question/widgets/carousel_slider_widget.dart';
import 'package:my_social_app/views/shared/app_back_button_widget.dart';

class DisplayQuestionImagesPage extends StatefulWidget {

  const DisplayQuestionImagesPage({super.key});

  @override
  State<DisplayQuestionImagesPage> createState() => _DisplayQuesionImagesPageState();
}

class _DisplayQuesionImagesPageState extends State<DisplayQuestionImagesPage> {
  final ValueNotifier<bool> _isDialOpen = ValueNotifier(false);

  SpeedDial _createSpeedDial(CreateQuestionState state,SpeedDialDirection direction){
    return SpeedDial(
      icon: Icons.camera,
      activeIcon: Icons.close,
      openCloseDial: _isDialOpen,
      spaceBetweenChildren: 15,
      direction: direction,
      renderOverlay: true,
      buttonSize: const Size.fromRadius(35),
      animationCurve: Curves.bounceOut,
      animationDuration: const Duration(milliseconds: 200),
      children: [
        SpeedDialChild(
          child: const Icon(Icons.photo),
          shape: const CircleBorder(),
          backgroundColor: Colors.green,
          onTap: (){
            if(state.images.length >= 5){
              ToastCreator.displayError("You can upload up to 5 images per a question!");
              return;
            }
            final store = StoreProvider.of<AppState>(context,listen: false);
            ImagePicker()
              .pickMultiImage(imageQuality: 100)
              .then((images){
                if(images.length + state.images.length > 5){
                  ToastCreator.displayError("You can upload up to 5 images per a question! The remain will be not load!");
                  final count = 5 - state.images.length;
                  final newImages = images.whereIndexed((i,e) => i < count);
                  store.dispatch(CreateQuestionImagesAction(images: newImages));
                }
                else{
                  store.dispatch(CreateQuestionImagesAction(images: images));
                }
              });
          }
        ),
        SpeedDialChild(
          child: const Icon(Icons.photo_camera),
          shape: const CircleBorder(),
          backgroundColor: Colors.blue,
          onTap: () async {
            if(state.images.length >= 5){
              ToastCreator.displayError("You can upload up to 5 images per a question!");
              return;
            }

            final store = StoreProvider.of<AppState>(context,listen: false);
            final dynamic image = await Navigator.of(context).pushNamed(takeImageRoute);
            
            if(image != null && context.mounted){
              store.dispatch(CreateQuestionImageAction(image: image));
            } 
          }
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override 
  Widget build(BuildContext context) {
    return StoreConnector<AppState,CreateQuestionState>(
      converter: (store) => store.state.createQuestionState,
      builder: (context,state) => Scaffold(
        appBar: AppBar(
          leading: const AppBackButtonWidget(),
          title: const Text("Upload Images"),
        ),
        body: Builder(
          builder: (context){
            if(state.images.isNotEmpty) return CarouselSliderWidget(images: state.images);
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.photo_outlined,
                      size: 75,
                    ),
                    const Text(
                      "Upload pictures and your question will get more attention from other users.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                    _createSpeedDial(state, SpeedDialDirection.down)
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButtonLocation: state.images.isNotEmpty ? FloatingActionButtonLocation.endFloat : null,
        floatingActionButton: state.images.isNotEmpty ? _createSpeedDial(state,SpeedDialDirection.left) : null,
        bottomNavigationBar: Padding(
          padding: const  EdgeInsets.all(15),
          child: OutlinedButton(
            onPressed: (){
              final store = StoreProvider.of<AppState>(context,listen: false);
              store.dispatch(const CreateQuestionAction());
              Navigator.of(context).popUntil(ModalRoute.withName(selectExamRoute));
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 4),
                  child: const Text("Create Question"),
                ),
                const Icon(Icons.create)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
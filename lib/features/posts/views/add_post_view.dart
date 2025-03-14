import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onegid/features/auth/bloc/bloc.dart';
import 'package:onegid/features/auth/bloc/states.dart';
import 'package:onegid/features/map/map.dart';
import 'package:onegid/features/posts/bloc/bloc.dart';
import 'package:onegid/features/posts/bloc/states.dart';
import 'package:onegid/features/posts/posts.dart';
import 'package:onegid/features/posts/repositories/posts_repository.dart';
import 'dart:io';
import 'package:onegid/utils/prefs.dart';

class AddPost extends StatefulWidget{
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPost();
}

class _AddPost extends State<AddPost>{
  _AddPost();

  final PostsRepository posts_repository = GetIt.I<PostsRepository>();

  final UserBloc userBloc = GetIt.I<UserBloc>();
  final PostsBloc postsBloc = GetIt.I<PostsBloc>();

  String selectedCat = '0';
  Map<String, String>? categories;
  var imagePreview;
  List<Place> choosenPlaces = [];
  List<String> choosenAudios = [];

  late final TextEditingController title = TextEditingController(text: '');
  late final TextEditingController description = TextEditingController(text: '');

  void pickImage() async {
    ImagePicker picker = ImagePicker();
    XFile? ximage = await picker.pickImage(source: ImageSource.gallery);
    if (ximage != null){
      File image = File(ximage.path);
      setState(() {
        imagePreview = image;
      });
    }
  }

  void pickAudios() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.audio);

    if (result != null) {
      choosenAudios.addAll(result.paths.map((path) => (path as String)));
      setState(() {});
    }
  }

  void choosePlaces(BuildContext context) async {
    final places = (await Navigator.pushNamed(context, '/map', arguments: MapArguments(mode: MapMode.choosePlaces)) as List<dynamic>?);
    if (places != null){
      setState(() {
        choosenPlaces = (places as List<Place>);
      });
    }
  }

  void addPost() async {
    if (userBloc.state is UserStateLoaded) {
      final audios = choosenAudios.map((path) => File(path)).toList();
      final PostModel post = PostModel(
        title: title.text, 
        description: description.text,
        author: (userBloc.state as UserStateLoaded).account.login,
        places: choosenPlaces, 
        cat: selectedCat,
        catId: selectedCat,
        image: imagePreview,
        audios: audios,
        region: (userBloc.state as UserStateLoaded).account.region,
      );
      await posts_repository.addPost(post);
    }
  }

  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                alignment: Alignment.centerLeft,
                height: 50,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset('assets/images/back_button_green.png', width: 50),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('Создать пост', style: theme.textTheme.headlineLarge)
                    )
                  ],
                )
              ),
            ),
            Field(
              heading: 'Добавьте фотографию',
              widget: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: InkWell(
                    onTap: pickImage,
                    child: imagePreview == null ? Image.asset('assets/images/choose_photo.png', width: 200, height: 200) : Image.file(imagePreview),
                  )
                )
              ),
            ),
            Field(
              heading: 'Дайте название посту',
              widget: TextFormField(
                style: theme.textTheme.labelLarge,
                controller: title,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Название (не больше 30 символов)'
                ),
              ),
            ),
            Field(
              heading: 'Выберите категорию поста',
              widget: BlocBuilder<PostsBloc, PostsState>(
                bloc: postsBloc,
                builder: (context, state) {
                  if (state is PostsStateLoaded) {
                    final List<DropdownMenuItem<String>> children = state.categories.map((category) => DropdownMenuItem(child: Text(category.title), value: category.id)).toList();
                    return DropdownButton(
                      isExpanded: true,
                      value: selectedCat,
                      onChanged: (value) {
                        setState(() {
                          selectedCat = (value as String);
                        });
                      },
                      items: children,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                } 
              )
            ),
            Field(
              heading: 'О чем вы хотите рассказать',
              widget: TextFormField(
                style: theme.textTheme.labelLarge,
                controller: description,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Описание поста'
                ),
              ),
            ),
            Field(
              heading: 'Добавьте связанные места',
              widget: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: InkWell(
                        onTap: () => choosePlaces(context),
                        child: Image.asset('assets/images/mapadd_button.png', width: 100, height: 100),
                      )
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: List.generate(choosenPlaces.length, (i) => PlaceItem(place: choosenPlaces[i], places: choosenPlaces))
                    )
                  )
                ],
              )
            ),
            Field(
              heading: 'Аудиогид',
              widget: Column(
                children: [
                  TextButton(
                    onPressed: pickAudios,
                    child: Text('Добавить аудиогида', style: theme.textTheme.labelLarge?.copyWith(color: Colors.blue)),
                  ),
                  Column(
                    children: choosenAudios.map((path) =>
                      AudiogidWidget(path: path, isOnDevice: true)
                    ).toList()
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  addPost();
                  Navigator.of(context).pop();
                },
                child: const Text('Создать пост'),
              )
            ),
          ]
        ),
      ),
    );
  }
}

class Field extends StatelessWidget{
  const Field({super.key, required this.heading, required this.widget});
  final String heading;
  final Widget widget;

  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            Text(heading, textAlign: TextAlign.center, style: theme.textTheme.titleLarge),
            widget
          ],
        )
      )
    );
  }
}
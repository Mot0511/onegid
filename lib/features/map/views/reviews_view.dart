import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:onegid/features/auth/bloc/bloc.dart';
import 'package:onegid/features/auth/bloc/states.dart';
import 'package:onegid/features/map/map.dart';

class ReviewsView extends StatefulWidget {
  const ReviewsView({super.key});

  @override
  State<ReviewsView> createState() => _ReviewsViewState();
}

class _ReviewsViewState extends State<ReviewsView> {

  final ReviewsRepository reviewsRepository = GetIt.I<ReviewsRepository>();
  final UserBloc userBloc = GetIt.I<UserBloc>();

  final textEditingController = TextEditingController();
  List<Review>? reviews;

  void getReviews(Place place) async {
    reviews = await reviewsRepository.getReviews(place);
    setState(() {});
  }

  void addPost(Place place) {
    if (userBloc.state is UserStateLoaded) {
      final author = (userBloc.state as UserStateLoaded).account.login;
      final text = textEditingController.text;

      reviewsRepository.addReview(place.uri as String, author, text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Place place = ModalRoute.of(context)!.settings.arguments as Place;
    getReviews(place);

    return Scaffold(
      body: ListView(
        children: [
          const AppBarWidget(),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place.title, style: theme.textTheme.headlineLarge),
                const SizedBox(height: 60),
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: TextField(
                        controller: textEditingController,
                        style: theme.textTheme.labelLarge,
                        decoration: InputDecoration(
                          hintText: 'Написать отзыв...',
                          hintStyle: theme.textTheme.labelMedium,
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 1, color: theme.colorScheme.secondary)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () => addPost(place),
                        child: Image.asset('assets/images/placesdescbtn.png')
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                reviews != null ? 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: reviews!.map((review) => 
                    ReviewWidget(review: review)
                  ).toList()
                ) : const SizedBox.shrink()
              ],
            )
          )
        ],
      ),
    );
  }
}
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/bloc_download/person_list_cubit.dart';
import 'package:rick_and_morty/feature/presentation/bloc_download/person_list_sate.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_card.dart';

class PersonsList extends StatefulWidget {
  @override
  _PersonsListState createState() => _PersonsListState();
}

class _PersonsListState extends State<PersonsList> {
  ScrollController scrollController = ScrollController();
  int page = -1;

  @override
  void initState() {
    super.initState();
    context.read<PersonListCubit>().loadPerson();
  }

  void setupScrollController() {
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = 0.0;
      if (maxScroll - currentScroll <= delta) {
        context.read<PersonListCubit>().loadPerson();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonListCubit, PersonState>(builder: (context, state) {
      List<PersonEntity> persons = [];
      bool isLoading = false;

      if (state is PersonLoading && state.isFirstFetch) {
        return _loadingIndicator();
      } else if (state is PersonLoading) {
        persons = state.oldPersonsList;
        isLoading = true;
      } else if (state is PersonLoaded) {
        persons = state.personsList;
      } else if (state is PersonError) {
        return Text(
          state.message,
          style: TextStyle(color: Colors.white, fontSize: 25),
        );
      }
      return ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < persons.length) {
            return PersonCard(person: persons[index]);
          } else {
            Timer(Duration(milliseconds: 100), () {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });
            return _loadingIndicator();
          }
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[400],
          );
        },
        itemCount: persons.length + (isLoading ? 1 : 0),
      );
    });
  }

  Widget _loadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

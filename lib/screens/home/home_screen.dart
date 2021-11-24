import 'dart:math';
import 'package:dictionary_using_bloc/bloc/dictionary_cubit.dart';
import 'package:dictionary_using_bloc/screens/list/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_words/random_words.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, int> searchedWords = {};

  getDictionaryFormWidget(BuildContext context) {
    final cubit = context.watch<DictionaryCubit>();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Spacer(),
          Text(
            "Dictionary App",
            style: TextStyle(
              color: Colors.amber,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Search any word you want quickly",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 32,
          ),
          TextField(
            controller: cubit.queryController,
            decoration: InputDecoration(
              hintText: "Search a word",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              fillColor: Colors.grey[100],
              filled: true,
              prefixIcon: Icon(Icons.search),
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          Spacer(),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  if (searchedWords.containsKey(cubit.queryController.text)) {
                    searchedWords[cubit.queryController.text] =
                        searchedWords[cubit.queryController.text] + 1;
                  } else {
                    searchedWords[cubit.queryController.text] = 1;
                  }
                });
                cubit.getWordSearched(searchedWords);
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.amber, padding: const EdgeInsets.all(16)),
              child: Text("SEARCH"),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // nouns.take(50).forEach(print);
                // print("lol");
                cubit.queryController.text =
                    nouns.elementAt(Random().nextInt(2536));
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.amber, padding: const EdgeInsets.all(16)),
              child: Text("RANDOM WORD GENERATOR"),
            ),
          ),
        ],
      ),
    );
  }

  getLoadingWidget() {
    return Center(child: CircularProgressIndicator());
  }

  getErrorWidget(message) {
    return Center(
        child: Text(
      message,
      style: TextStyle(color: Colors.white),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DictionaryCubit>();

    return BlocListener(
      listener: (context, state) {
        if (state is WordSearchedState && state.words != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ListScreen(state.words, state.searchedWords),
            ),
          );
        }
      },
      bloc: cubit,
      child: Scaffold(
          backgroundColor: Colors.blueGrey[900],
          body: cubit.state is WordSearchingState
              ? getLoadingWidget()
              : cubit.state is ErrorState
                  ? getErrorWidget("Some Error")
                  : cubit.state is NoWordSearchedState
                      ? getDictionaryFormWidget(context)
                      : Container()),
    );
  }
}

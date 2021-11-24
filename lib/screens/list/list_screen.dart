import 'package:dictionary_using_bloc/model/word_response.dart';
import 'package:dictionary_using_bloc/screens/detail/detail_screen.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  final List<WordResponse> words;
  final Map<String, int> searchedWords;
  ListScreen(this.words, this.searchedWords);

  @override
  Widget build(BuildContext context) {
    print(searchedWords);

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: ListView.separated(
        itemBuilder: (context, index) => ListTile(
          title: Text(
            "${index + 1}. ${words[index].word}",
            style: TextStyle(color: Colors.white),
          ),
          trailing: searchedWords[words[0].word] <= 1
              ? null
              : Icon(
                  Icons.star_outlined,
                  color: Colors.white,
                ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(words[index]),
              ),
            );
          },
        ),
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
        ),
        itemCount: words.length,
      ),
    );
  }
}

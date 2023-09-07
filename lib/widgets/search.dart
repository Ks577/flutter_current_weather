import 'dart:developer';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';

class SearchForm extends StatefulWidget {
  final Function(String) onSearch;

  const SearchForm({
    Key? key,
    required this.onSearch,
  }) : super(key: key);

  @override
  createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimSearchBar(
      rtl: true,
      width: 370,
      color: Colors.white,
      textController: _cityController,
      suffixIcon: const Icon(
        Icons.search,
        color: Colors.black,
      ),
      onSuffixTap: () async {
        _cityController.text == "" ? log("No city entered") : setState(() {});
        FocusScope.of(context).unfocus();
        _cityController.clear();
      },
      onSubmitted: (String city) => widget.onSearch(city),
    );
  }
}

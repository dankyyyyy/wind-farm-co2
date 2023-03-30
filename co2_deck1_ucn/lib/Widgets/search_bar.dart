import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const SearchBar({super.key, required this.onChanged});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _searchController,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
              hintText: "Search",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0))),
        ));
  }
}

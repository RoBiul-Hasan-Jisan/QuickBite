import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<String>? onSearchSubmitted;
  final VoidCallback? onSortPressed;

  const SearchWidget({
    Key? key,
    this.onSearchChanged,
    this.onSearchSubmitted,
    this.onSortPressed,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _hasText = _searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    if (widget.onSearchChanged != null) {
      widget.onSearchChanged!('');
    }
  }

  void _onSearchChanged(String value) {
    if (widget.onSearchChanged != null) {
      widget.onSearchChanged!(value);
    }
  }

  void _onSearchSubmitted(String value) {
    if (widget.onSearchSubmitted != null) {
      widget.onSearchSubmitted!(value);
    }
  }

  void _onSortPressed() {
    if (widget.onSortPressed != null) {
      widget.onSortPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        top: 5,
        right: 10,
        bottom: 5,
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              width: 1.5,
              color: Color(0xFFfb3132),
            ),
          ),
          filled: true,
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFFfb3132),
            size: 24,
          ),
          suffixIcon: _hasText
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Color(0xFFfb3132),
                    size: 20,
                  ),
                  onPressed: _clearSearch,
                )
              : IconButton(
                  icon: const Icon(
                    Icons.sort,
                    color: Color(0xFFfb3132),
                    size: 24,
                  ),
                  onPressed: _onSortPressed,
                ),
          fillColor: const Color(0xFFFAFAFA),
          hintStyle: const TextStyle(
            color: Color(0xFFd0cece),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          hintText: "What would you like to buy?",
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          isDense: true,
        ),
        style: const TextStyle(
          color: Color(0xFF3a3a3b),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        cursorColor: const Color(0xFFfb3132),
        onChanged: _onSearchChanged,
        onSubmitted: _onSearchSubmitted,
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_api_riverpod/Riverpod_StateNotifier/provider.dart';

class SearchField extends ConsumerWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
        onChanged: (valu) {
          print("searchQurery: $valu");
          ref.read(searchProvider.notifier).state = valu;
        },
        decoration: const InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          labelText: "Search",
          prefixIcon: Icon(Icons.search),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey)),
        ));
  }
}

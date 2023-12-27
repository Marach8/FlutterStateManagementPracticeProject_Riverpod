import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const films = [
  Film(id: '1', title: 'My mothers name', description: 'Description for my mothers name', isFavorite: false),
  Film(id: '2', title: 'First day in the uni', description: 'Description for my first day in the uni', isFavorite: false),
  Film(id: '3', title: 'A market day', description: 'Description for a market day', isFavorite: false),
  Film(id: '4', title: 'New Christmass', description: 'Description for new Christmass', isFavorite: false),
];

@immutable 
class Film{
  final String id;
  final String title;
  final String description;
  final bool isFavorite;

  const Film({required this.id, required this.title, required this.description, required this.isFavorite});

  //This function returns the same Film Object with with a different isFavorite flag
  Film copyFilm(bool favorite) => Film(description: description, title: title, id: id, isFavorite: favorite);

  @override 
  bool operator ==(covariant Film other) => id == other.id && isFavorite == other.isFavorite;

  @override
  int get hashCode => Object.hash(id, isFavorite);

  @override 
  String toString() => 'Film (description: $description, title: $title, id: $id, isFavorite: $isFavorite)';
}



class FilmsNotifier extends StateNotifier<List<Film>> {
  //By passing films to super, the state parameter of the StateNotifier is now set to the films
  //iterable. So films is more like a starter value.
  FilmsNotifier(): super(films);

  void updateFilm(Film film, bool isFavorite) => state = state.map((thisFilm)
    => thisFilm.id == film.id ? thisFilm.copyFilm(isFavorite) : thisFilm).toList();
}

enum FavoriteStatus{all, favorite, notFavorite}

//ensure to give your StateProvider a default value
final favoriteStatusProvider = StateProvider<FavoriteStatus>((_) => FavoriteStatus.all);

final allFilmsProvider = StateNotifierProvider<FilmsNotifier, List<Film>>((_) => FilmsNotifier());

final favoriteFilmsProvider = Provider<Iterable<Film>>((ref)
  => ref.watch(allFilmsProvider).where((film) => film.isFavorite));

final notFavoriteFilmsProvider = Provider<Iterable<Film>>((ref)
  => ref.watch(allFilmsProvider).where((film) => !film.isFavorite));

class FilmsWidget extends ConsumerWidget {
  //We are using this type below because we want instances of all, favorite and not favorite provider 
  //and both statenotifierprovider and the provider conform to this type.
  final AlwaysAliveProviderBase<Iterable<Film>> provider;
  const FilmsWidget({required this.provider, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final films = ref.watch(provider);
    return Expanded(
      child: ListView.builder(
        itemCount: films.length,
        itemBuilder: (_, index){
          final film = films.elementAt(index);
          final favoriteIcon = film.isFavorite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border);
          return ListTile(
            title: Text(film.title), 
            subtitle: Text(film.description),
            trailing: IconButton(
              icon: favoriteIcon,
              onPressed: (){
                final newIsFavorite = !film.isFavorite;
                ref.read(allFilmsProvider.notifier).updateFilm(film, newIsFavorite);
              }
            )
          );
        }
      ),
    );
  }
}


class DropDownWidget extends StatelessWidget {
  const DropDownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child){
        return DropdownButton(
          value: ref.watch(favoriteStatusProvider),
          items: FavoriteStatus.values.map((favValue) => 
            DropdownMenuItem(value: favValue, child: Text(favValue.name),)
          ).toList(),
          onChanged:(value) => ref.read(favoriteStatusProvider.notifier).state = value!
        );
      }
    );
  }
}



class Example6 extends ConsumerWidget {
  const Example6({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Films Example'), centerTitle: true),
      body: Column(
        children: [
          const DropDownWidget(),
          Consumer(
            builder: (_, ref, __){
              final provider = ref.watch(favoriteStatusProvider);
              switch(provider){                
                case FavoriteStatus.all:
                  return FilmsWidget(provider: allFilmsProvider);
                case FavoriteStatus.favorite:
                  return FilmsWidget(provider: favoriteFilmsProvider);
                case FavoriteStatus.notFavorite:
                  return FilmsWidget(provider: notFavoriteFilmsProvider);
              }
            }
          )
        ],
      )
    );
  }
}
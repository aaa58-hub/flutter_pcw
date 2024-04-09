import 'dart:convert';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

/*
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '${appState.favorites.length} favorites:'),
        ),
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          )
      ],
    );
  }
}*/

class PokemonFetcher {
  Future<Pokemon> fetchPokemon(int pokemonId) async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonId'),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Pokemon.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }
}

class Pokemon {
  final List<Ability> abilities;
  final int baseExperience;
  final Cry cries;
  final List<FormGame> form;
  final List<GameIndex> gameIndices;
  final int height;
  final List<HeldItem> heldItems;
  final int id;
  final bool isDefault;
  final String locationAreaEncounters;
  final List<Moves> moves;
  final String name;
  final int order;
  final List<Ability> pastAbilities;
  final List<PastType> pastTypes;
  final Species species;
  final Sprite sprites;
  final List<Statistics> stats;
  final List<TypeGame> types;
  final int weight;

  const Pokemon({
    required this.abilities,
    required this.baseExperience,
    required this.cries,
    required this.form,
    required this.gameIndices,
    required this.height,
    required this.heldItems,
    required this.id,
    required this.isDefault,
    required this.locationAreaEncounters,
    required this.moves,
    required this.name,
    required this.order,
    required this.pastAbilities,
    required this.pastTypes,
    required this.species,
    required this.sprites,
    required this.stats,
    required this.types,
    required this.weight,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      abilities: _parseAbilities(json['abilities']),
      baseExperience: json['base_experience'],
      cries: _parseCry(json['cries']),
      form: _parseFormGames(json['forms']),
      gameIndices: _parseGameIndices(json['game_indices']),
      height: json['height'],
      heldItems: _parseHeldItems(json['held_items']),
      id: json['id'],
      isDefault: json['is_default'],
      locationAreaEncounters: json['location_area_encounters'],
      moves: _parseMoves(json['moves']),
      name: json['name'],
      order: json['order'],
      pastAbilities: _parsePastAbilities(json['past_abilities']),
      pastTypes: _parsePastTypes(json['past_types']),
      species: _parseSpecies(json['species']),
      sprites: _parseSprites(json['sprites']),
      stats: _parseStats(json['stats']),
      types: _parseTypes(json['types']),
      weight: json['weight'],
    );
  }

  static List<Ability> _parseAbilities(List<dynamic> abilitiesJson) {
    return abilitiesJson
        .map((abilityJson) => Ability.fromJson(abilityJson))
        .toList();
  }

  static Cry _parseCry(dynamic cryJson) {
    return Cry.fromJson(cryJson);
  }

  static List<FormGame> _parseFormGames(List<dynamic>? formGamesJson) {
    if (formGamesJson == null) {
      return []; // Return an empty list if formGamesJson is null
    }

    return formGamesJson
        .map((formGameJson) => FormGame.fromJson(formGameJson))
        .toList();
  }

  static List<GameIndex> _parseGameIndices(List<dynamic> gameIndicesJson) {
    return gameIndicesJson
        .map((gameIndexJson) => GameIndex.fromJson(gameIndexJson))
        .toList();
  }

  static List<HeldItem> _parseHeldItems(List<dynamic> heldItemsJson) {
    return heldItemsJson
        .map((heldItemJson) => HeldItem.fromJson(heldItemJson))
        .toList();
  }

  static List<Moves> _parseMoves(List<dynamic> movesJson) {
    return movesJson.map((moveJson) => Moves.fromJson(moveJson)).toList();
  }

  static List<Ability> _parsePastAbilities(List<dynamic> pastAbilitiesJson) {
    return pastAbilitiesJson
        .map((abilityJson) => Ability.fromJson(abilityJson))
        .toList();
  }

  static List<PastType> _parsePastTypes(List<dynamic> pastTypesJson) {
    return pastTypesJson
        .map((pastTypeJson) => PastType.fromJson(pastTypeJson))
        .toList();
  }

  static Species _parseSpecies(Map<String, dynamic> speciesJson) {
    return Species.fromJson(speciesJson);
  }

  static Sprite _parseSprites(Map<String, dynamic> spritesJson) {
    return Sprite.fromJson(spritesJson);
  }

  static List<Statistics> _parseStats(List<dynamic> statsJson) {
    return statsJson.map((statJson) => Statistics.fromJson(statJson)).toList();
  }

  static List<TypeGame> _parseTypes(List<dynamic> typesJson) {
    return typesJson.map((typesJson) => TypeGame.fromJson(typesJson)).toList();
  }
}

class Statistic {
  final String name;
  final String url;

  Statistic({
    required this.name,
    required this.url,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic(
      name: json['name'],
      url: json['url'],
    );
  }
}

class Statistics {
  final int baseStat;
  final int effort;
  final Statistic stat;

  Statistics({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      baseStat: json['base_stat'],
      effort: json['effort'],
      stat: Statistic.fromJson(json['stat']),
    );
  }
}

class DreamWorld {
  final String? frontDefault;
  final String? frontFemale;

  DreamWorld({
    required this.frontDefault,
    required this.frontFemale,
  });

  factory DreamWorld.fromJson(Map<String, dynamic> json) {
    return DreamWorld(
      frontDefault: json['front_default'],
      frontFemale: json['front_female'],
    );
  }
}

class HomeSprite {
  final String? frontDefault;
  final String? frontFemale;
  final String? frontShiny;
  final String? frontShinyFemale;

  HomeSprite({
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
  });

  factory HomeSprite.fromJson(Map<String, dynamic> json) {
    return HomeSprite(
      frontDefault: json['front_default'],
      frontFemale: json['front_female'],
      frontShiny: json['front_shiny'],
      frontShinyFemale: json['front_shiny_female'],
    );
  }
}

class OfficialArtwork {
  final String? frontDefault;
  final String? frontShiny;

  OfficialArtwork({
    required this.frontDefault,
    required this.frontShiny,
  });

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) {
    return OfficialArtwork(
      frontDefault: json['front_default'],
      frontShiny: json['front_shiny'],
    );
  }
}

class Showdown {
  final String? backDefault;
  final String? backFemale;
  final String? backShiny;
  final String? backShinyFemale;
  final String? frontDefault;
  final String? frontFemale;
  final String? frontShiny;
  final String? frontShinyFemale;

  Showdown({
    required this.backDefault,
    required this.backFemale,
    required this.backShiny,
    required this.backShinyFemale,
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
  });

  factory Showdown.fromJson(Map<String, dynamic> json) {
    return Showdown(
      backDefault: json['back_default'],
      backFemale: json['back_female'],
      backShiny: json['back_shiny'],
      backShinyFemale: json['back_shiny_female'],
      frontDefault: json['front_default'],
      frontFemale: json['front_female'],
      frontShiny: json['front_shiny'],
      frontShinyFemale: json['front_shiny_female'],
    );
  }
}

class Other {
  final DreamWorld dreamWorld;
  final HomeSprite home;
  final OfficialArtwork officialArtwork;
  final Showdown showdown;

  Other({
    required this.dreamWorld,
    required this.home,
    required this.officialArtwork,
    required this.showdown,
  });

  factory Other.fromJson(Map<String, dynamic> json) {
    return Other(
      dreamWorld: DreamWorld.fromJson(json['dream_world']),
      home: HomeSprite.fromJson(json['home']),
      officialArtwork: OfficialArtwork.fromJson(json['official-artwork']),
      showdown: Showdown.fromJson(json['showdown']),
    );
  }
}

class VersionSprite {}

class Sprite {
  final String? backDefault;
  final String? backFemale;
  final String? backShiny;
  final String? backShinyFemale;
  final String? frontDefault;
  final String? frontFemale;
  final String? frontShiny;
  final String? frontShinyFemale;
  final Other other;
  //final VersionSprite versions;

  Sprite({
    required this.backDefault,
    required this.backFemale,
    required this.backShiny,
    required this.backShinyFemale,
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
    required this.other,
    //required this.versions,
  });

  factory Sprite.fromJson(Map<String, dynamic> json) {
    return Sprite(
      backDefault: json['back_default'],
      backFemale: json['back_female'],
      backShiny: json['back_shiny'],
      backShinyFemale: json['back_shiny_female'],
      frontDefault: json['front_default'],
      frontFemale: json['front_female'],
      frontShiny: json['front_shiny'],
      frontShinyFemale: json['front_shiny_female'],
      other: Other.fromJson(json['other']),
    );
  }
}

class Species {
  final String name;
  final String url;

  Species({
    required this.name,
    required this.url,
  });

  factory Species.fromJson(Map<String, dynamic> json) {
    return Species(
      name: json['name'],
      url: json['url'],
    );
  }
}

class Generation {
  final String name;
  final String url;

  Generation({
    required this.name,
    required this.url,
  });

  factory Generation.fromJson(Map<String, dynamic> json) {
    return Generation(
      name: json['name'],
      url: json['url'],
    );
  }
}

class TypeGameEntry {
  final String name;
  final String url;

  TypeGameEntry({
    required this.name,
    required this.url,
  });

  factory TypeGameEntry.fromJson(Map<String, dynamic> json) {
    return TypeGameEntry(
      name: json['name'],
      url: json['url'],
    );
  }
}

class TypeGame {
  final int slot;
  final TypeGameEntry type;

  TypeGame({required this.slot, required this.type});

  factory TypeGame.fromJson(Map<String, dynamic> json) {
    return TypeGame(
      slot: json['slot'],
      type: TypeGameEntry.fromJson(json['type']),
    );
  }
}

class PastType {
  final Generation generation;
  final List<TypeGame> types;

  PastType({required this.generation, required this.types});

  factory PastType.fromJson(Map<String, dynamic> json) {
    return PastType(
      generation: Generation.fromJson(json['generation']),
      types: (json['types'] as List<dynamic>)
          .map((typeJson) => TypeGame.fromJson(typeJson))
          .toList(),
    );
  }
}

class VersionGroup {
  final String name;
  final String url;

  VersionGroup({
    required this.name,
    required this.url,
  });

  factory VersionGroup.fromJson(Map<String, dynamic> json) {
    return VersionGroup(
      name: json['name'],
      url: json['url'],
    );
  }
}

class MoveLearnMethod {
  final String name;
  final String url;

  MoveLearnMethod({
    required this.name,
    required this.url,
  });

  factory MoveLearnMethod.fromJson(Map<String, dynamic> json) {
    return MoveLearnMethod(
      name: json['name'],
      url: json['url'],
    );
  }
}

class VersionGroupDetail {
  final int levelLearnedAt;
  final MoveLearnMethod moveLearnMethod;
  final VersionGroup versionGroup;

  VersionGroupDetail({
    required this.levelLearnedAt,
    required this.moveLearnMethod,
    required this.versionGroup,
  });

  factory VersionGroupDetail.fromJson(Map<String, dynamic> json) {
    return VersionGroupDetail(
      levelLearnedAt: json['level_learned_at'],
      moveLearnMethod: MoveLearnMethod.fromJson(json['move_learn_method']),
      versionGroup: VersionGroup.fromJson(json['version_group']),
    );
  }
}

class Move {
  final String name;
  final String url;

  Move({
    required this.name,
    required this.url,
  });

  factory Move.fromJson(Map<String, dynamic> json) {
    return Move(
      name: json['name'],
      url: json['url'],
    );
  }
}

class Moves {
  final Move move;
  final List<VersionGroupDetail> versionGroupDetails;

  Moves({required this.move, required this.versionGroupDetails});

  factory Moves.fromJson(Map<String, dynamic> json) {
    return Moves(
      move: Move.fromJson(json['move']),
      versionGroupDetails: (json['version_group_details'] as List<dynamic>)
          .map((detailJson) => VersionGroupDetail.fromJson(detailJson))
          .toList(),
    );
  }
}

class VersionDetail {
  final int rarity;
  final Version version;

  VersionDetail({
    required this.rarity,
    required this.version,
  });

  factory VersionDetail.fromJson(Map<String, dynamic> json) {
    return VersionDetail(
      rarity: json['rarity'],
      version: Version.fromJson(json['version']),
    );
  }
}

class Item {
  final String name;
  final String url;
  final List<VersionDetail> versionDetails;

  Item({required this.name, required this.url, required this.versionDetails});

  factory Item.fromJson(Map<String, dynamic> json) {
    print(json);
    return Item(
      name: json['name'],
      url: json['url'],
      versionDetails: (json['version_details'] != null)
          ? (json['version_details'] as List<dynamic>)
              .map((detailJson) => VersionDetail.fromJson(detailJson))
              .toList()
          : [],
    );
  }
}

class HeldItem {
  final Item item;
  final int? id;
  final bool? isDefault;
  final String? locationAreaEncounters;

  HeldItem({
    required this.item,
    required this.id,
    required this.isDefault,
    required this.locationAreaEncounters,
  });

  factory HeldItem.fromJson(Map<String, dynamic> json) {
    return HeldItem(
      item: Item.fromJson(json['item']),
      id: json['id'],
      isDefault: json['is_default'],
      locationAreaEncounters: json['location_area_encounters'],
    );
  }
}

class Version {
  final String name;
  final String url;

  Version({
    required this.name,
    required this.url,
  });

  factory Version.fromJson(Map<String, dynamic> json) {
    return Version(
      name: json['name'],
      url: json['url'],
    );
  }
}

class GameIndex {
  final int gameIndex;
  final Version version;

  GameIndex({required this.gameIndex, required this.version});

  factory GameIndex.fromJson(Map<String, dynamic> json) {
    return GameIndex(
      gameIndex: json['game_index'],
      version: Version.fromJson(json['version']),
    );
  }
}

class FormGame {
  final String name;
  final String url;

  FormGame({required this.name, required this.url});

  factory FormGame.fromJson(Map<String, dynamic> json) {
    return FormGame(
      name: json['name'],
      url: json['url'],
    );
  }
}

class Cry {
  final String latest;
  final String? legacy;

  Cry({
    required this.latest,
    required this.legacy,
  });

  factory Cry.fromJson(Map<String, dynamic> json) {
    return Cry(
      latest: json['latest'],
      legacy: json['legacy'],
    );
  }
}

class AbilityEntry {
  final String name;
  final String url;

  AbilityEntry({
    required this.name,
    required this.url,
  });

  factory AbilityEntry.fromJson(Map<String, dynamic> json) {
    return AbilityEntry(
      name: json['ability']['name'],
      url: json['ability']['url'],
    );
  }
}

class Ability {
  final AbilityEntry ability;
  final bool isHidden;
  final int slot;

  Ability({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(
      ability: AbilityEntry.fromJson(json),
      isHidden: json['is_hidden'],
      slot: json['slot'],
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

/*class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }

  @override
  State<MyApp> createState() => _MyAppState();
}*/

/*class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}*/

/*class _MyAppState extends State<MyApp> {
  late Future<Pokemon> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Pokemon>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                for (var element in snapshot.data!.abilities) {
                  print(element.ability.name);
                }

                return Text(snapshot.data!.name);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}*/

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var pokemonId = 184;
  late Pokemon? fetchedPokemon = null;

  void fetchAndStorePokemon() async {
    print("FETCH: $pokemonId");
    fetchedPokemon = await PokemonFetcher().fetchPokemon(pokemonId);
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const GeneratorPage();
        break;
      case 1:
        page = const GeneratorPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    /*return LayoutBuilder(builder: (context, constraints) {
      // Determine if the width is smaller than a certain value (indicating phone screen)
      final isPhone = constraints.maxWidth < 600;

      return Scaffold(
        body: Center(
          // Use a column to vertically align the content
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // If it's a phone, wrap the image and chips in a container with padding
              if (isPhone)
                Container(
                  padding: const EdgeInsets.all(16),
                  child: page,
                )
              else
                page, // Otherwise, display the content directly
            ],
          ),
        ),
      );
    });*/

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: page,
        /*body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Favorites'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),*/
      );
    });
  }
}

/*class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pokemonChosen = appState.fetchedPokemon;
    var pokemonId = appState.pokemonId;
    print(pokemonChosen);

    IconData icon;

    return Column(
      children: [
        ImageCard(pokemon: pokemonId),
      ],
    );
  }
}
class GeneratorPage extends StatelessWidget {
  const GeneratorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pokemonChosen = appState.fetchedPokemon;
    var pokemonId = appState.pokemonId;

    IconData icon;

    return Column(
      children: [
        pokemonChosen != null
            ? ImageCard(pokemon: pokemonId)
            : CircularProgressIndicator(), // Show CircularProgressIndicator while fetching // Show loading indicator while fetching data
      ],
    );
  }
}*/

class GeneratorPage extends StatefulWidget {
  const GeneratorPage({super.key});

  @override
  _GeneratorPageState createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  @override
  void initState() {
    super.initState();
    context.read<MyAppState>().fetchAndStorePokemon();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pokemonChosen = appState.fetchedPokemon;
    var pokemonId = appState.pokemonId;
    //print(pokemonChosen);

    IconData icon;

    if (pokemonChosen != null) {
      var pokemonName =
          pokemonChosen.name[0].toUpperCase() + pokemonChosen.name.substring(1);
      return Scaffold(
        appBar: AppBar(
          title: const Text('Pokemon Details'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  pokemonName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                PokemonImage(id: pokemonId),
                const SizedBox(height: 20),
                PokemonChips(types: pokemonChosen.types),
              ],
            ),
          ),
        ),
      );
    } else {
      return const Text("Error");
    }
  }
}

/*class ImageCard extends StatelessWidget {
  final Pokemon? pokemon;

  const ImageCard({required this.pokemon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.tertiary,
    );

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${pokemon!.id}.png",
              ),
              SizedBox(
                height: 50, // Set the height according to your requirement
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: pokemon!.types.length,
                      itemBuilder: (context, index) {
                        final typeName = pokemon!.types[index].type.name;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Chip(
                            label: Text(
                              typeName,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/

class PokemonImage extends StatelessWidget {
  final int id;

  const PokemonImage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/$id.png",
      width: 200, // Adjust width as needed
      height: 200, // Adjust height as needed
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
            Icons.error); // Show error icon if image fails to load
      },
    );
  }
}

class PokemonChips extends StatelessWidget {
  final List<TypeGame>? types;

  const PokemonChips({super.key, required this.types});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: types
              ?.map((typeGame) => Chip(label: Text(typeGame.type.name)))
              .toList() ??
          [],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_dto.dart';
import 'package:neo_pokedex/core/models/pokemon_hero.dart';
import 'package:neo_pokedex/core/services/graph_ql_service.dart';
import 'package:neo_pokedex/ui/shared/widgets/circle_background.dart';
import 'package:neo_pokedex/ui/shared/widgets/pokeball_barkground.dart';
import 'package:neo_pokedex/ui/themes/pokeball_background_colors.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_app_bar.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon.dart';
import 'package:neo_pokedex/utils/text_utils.dart';
// Added imports for DTOs
import 'package:neo_pokedex/core/models/dto/pokemon_about_tab_info_dto.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_evolution_tab_info_dto.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_moves_tab_info_dto.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_stats_tab_info_dto.dart';
import 'package:screenshot/screenshot.dart';

class PokemonPage extends StatefulWidget {
  static const String routeName = '/pokemon_page';

  const PokemonPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  final ScreenshotController _screenshotController = ScreenshotController();
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _scrollOffset = ValueNotifier(0.0);
  final double maxScrollOffset = 320.0;

  late final GraphQLService _graphQLService;
  late final int id;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final client = GraphQLProvider.of(context).value;
      _graphQLService = GraphQLService(client);
      id = ModalRoute.of(context)?.settings.arguments as int;
      _isInitialized = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels > maxScrollOffset) {
      _scrollController.jumpTo(maxScrollOffset);
    }

    _scrollOffset.value = _scrollController.position.pixels > maxScrollOffset
        ? maxScrollOffset
        : _scrollController.position.pixels;
  }

  Future<Map<String, dynamic>> fetchAllPokemonData(int id) async {
    final pokemon = await _graphQLService.getPokemonById(id);
    final type = await _graphQLService.getPokemonTypeById(id);
    final stats = await _graphQLService.getPokemonStatsById(id);
    final moves = await _graphQLService.fetchPokemonMoves(id);
    final eggGroups = await _graphQLService.getEggGroups(id);
    final breeding = await _graphQLService.getBreedingData(id);
    final evolutions = await _graphQLService.getPokemonsEvolutions(id);
    final megaEvolutions = await _graphQLService.getMegaEvolution(id);
    final about = await _graphQLService.getDescription(id);

    final PokemonAboutTabInfoDto aboutDto = PokemonAboutTabInfoDto(
        type: type.name,
        pokemonFlavourTextDto:
            PokemonFlavourTextDto.fromAbout(type.name, about),
        pokemonInformationTextDto:
            PokemonInformationTextDto.fromBreeding(type.name, breeding),
        pokemonBreedingTextDto: PokemonBreedingTextDto.fromBreeding(
            type.name, breeding, eggGroups));

    final PokemonStatsTabInfoDto statsDto = PokemonStatsTabInfoDto(
      pokemonStatsTextDto: PokemonStatsTextDto.fromStats(type.name, stats),
      pokemonTypeEffectivenessTextDto: PokemonTypeEffectivenessTextDto(
        type: type.name,
      ),
    );

    final PokemonMovesTabInfoDto movesDto = PokemonMovesTabInfoDto(
      type: type.name,
      moves: moves.map((move) => PokemonMoveTextDto.fromMove(move)).toList(),
    );

    final PokemonEvolutionTabInfoDto evolutionsDto = PokemonEvolutionTabInfoDto(
      type: type.name,
      pokemonEvolutionTextDto: evolutions
          .map((evolution) => PokemonEvolutionTextDto.fromEvolution(evolution))
          .toList(),
      pokemonMegaEvolutionTextDto: megaEvolutions
          .map((mega) => PokemonEvolutionTextDto.fromMegaEvolution(mega))
          .toList(),
    );

    final PokemonDto pokemonDto = PokemonDto(
      pokemonAboutTabInfoDto: aboutDto,
      pokemonStatsTabInfoDto: statsDto,
      pokemonMovesTabInfoDto: movesDto,
      pokemonEvolutionTabInfoDto: evolutionsDto,
    );

    return {
      'pokemon': pokemon,
      'pokemonDto': pokemonDto,
    };
  }

  Widget _buildLoadingState() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: PokemonAppBar(
        pokemonId: id.toString(),
        scrollOffsetNotifier: _scrollOffset,
        type: 'unknown',
        imageUrl: '',
        name: '',
        screenshotController: _screenshotController,
      ),
      body: const Center(
          child: Stack(
        children: [
          Positioned(child: CircleBackGround(types: ['dragon'])),
          Positioned(
            top: 170,
            right: 65,
            child: PokeballBackground(color: PokeballBackgroundColors.white),
          ),
          Positioned(
              top: 285,
              right: 180,
              child: CircularProgressIndicator(color: Colors.white)),
        ],
      )),
    );
  }

  Widget _buildErrorState(Object error) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: PokemonAppBar(
        pokemonId: id.toString(),
        scrollOffsetNotifier: _scrollOffset,
        type: 'unknown',
        imageUrl: '',
        name: '',
        screenshotController: _screenshotController,
      ),
      body: Center(child: Text('Error: $error')),
    );
  }

  Widget _buildPokemonDetails(Map<String, dynamic> data) {
    final PokemonHero pokemon = data['pokemon'];
    final PokemonDto pokemonDto = data['pokemonDto'];

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: PokemonAppBar(
        pokemonId: id.toString(),
        scrollOffsetNotifier: _scrollOffset,
        type: pokemonDto.pokemonEvolutionTabInfoDto.type,
        imageUrl: pokemon.imageUrl,
        name: toTitleCaseWithSpaces(pokemon.name),
        screenshotController: _screenshotController,
      ),
      body: Screenshot(
        controller: _screenshotController,
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Stack(
              children: [
                CircleBackGround(types: pokemon.types),
                const Positioned(
                  top: 100,
                  right: -100,
                  child:
                      PokeballBackground(color: PokeballBackgroundColors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 110),
                  child: Hero(
                    tag: pokemon.id,
                    child: Pokemon(
                      pokemonHero: pokemon,
                      pokemonDto: pokemonDto,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchAllPokemonData(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingState();
        }
        if (snapshot.hasError) return _buildErrorState(snapshot.error!);
        if (!snapshot.hasData) return _buildErrorState('No Pokémon found');

        return _buildPokemonDetails(snapshot.data!);
      },
    );
  }
}

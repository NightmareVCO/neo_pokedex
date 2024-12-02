// import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:neo_pokedex/core/services/graph_ql_service.dart';
// import 'package:neo_pokedex/core/models/pokemon.dart' as models;
// import 'package:neo_pokedex/ui/widgets/home_pokemon_list_widgets/pokemon_list.dart';
// import 'package:neo_pokedex/ui/widgets/home_pokemon_list_widgets/pokemon_list_app_bar.dart';

// class PokemonListPage extends StatefulWidget {
//   static const String routeName = '/';

//   const PokemonListPage({super.key});

// //   @override
// //   State<PokemonListPage> createState() => _PokemonListPageState();
// }

// // class _PokemonListPageState extends State<PokemonListPage> {
// //   late final GraphQLClient _client;
// //   late final GraphQLService _graphQLService;
// //   final List<models.Pokemon> _pokemons = [];
// //   int _offset = 0;
// //   int _limit = 20;
// //   bool _isLoading = false;
// //   bool _hasMore = true;
// //   bool _isInitialized = false;

// //   String _orderBy = "";
// //   String _sort = "desc";
// //   String _type = "";

// //   @override
// //   void initState() {
// //     super.initState();
// //   }

// //   @override
// //   void didChangeDependencies() {
// //     super.didChangeDependencies();
// //     if (!_isInitialized) {
// //       _client = GraphQLProvider.of(context).value;
// //       _graphQLService = GraphQLService(_client);
// //       _fetchPokemons();
// //       _isInitialized = true;
// //     }
// //   }

// //   Future<void> _fetchPokemons() async {
// //     if (_isLoading || !_hasMore) return;
// //     setState(() {
// //       _isLoading = true;
// //     });
// //     try {
// //       List<models.Pokemon> fetchedPokemons = await _graphQLService.getPokemons(
// //         _orderBy,
// //         _sort,
// //         _limit,
// //         _offset,
// //         _type,
// //       );
// //       setState(() {
// //         _pokemons.addAll(fetchedPokemons);
// //         _offset += _limit;
// //         _isLoading = false;
// //         if (fetchedPokemons.length < _limit) {
// //           _hasMore = false;
// //         }
// //       });
// //     } catch (e) {
// //       setState(() {
// //         _isLoading = false;
// //       });
// //     }
// //   }

// //   void _updateOrderBy(String newOrderBy) {
// //     setState(() {
// //       _orderBy = newOrderBy;
// //       _offset = 0;
// //       _pokemons.clear();
// //       _hasMore = true;
// //     });
// //     _fetchPokemons();
// //   }

// //   void _updateLimit(int newLimit) {
// //     setState(() {
// //       _limit = newLimit;
// //       _offset = 0;
// //       _pokemons.clear();
// //       _hasMore = true;
// //     });
// //     _fetchPokemons();
// //   }

// //   void _updateSort(String newSort) {
// //     setState(() {
// //       _sort = newSort;
// //       _offset = 0;
// //       _pokemons.clear();
// //       _hasMore = true;
// //     });
// //     _fetchPokemons();
// //   }

// //   void _updateType(String newType) {
// //     setState(() {
// //       _type = newType;
// //       _offset = 0;
// //       _pokemons.clear();
// //       _hasMore = true;
// //     });
// //     _fetchPokemons();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Stack(
// //       children: [
// //         Scaffold(
// //           extendBodyBehindAppBar: true,
// //           backgroundColor: Colors.white,
// //           appBar: PokemonListAppBar(
// //             orderBy: _orderBy,
// //             limit: _limit,
// //             sort: _sort,
// //             type: _type,
// //             onOrderByChanged: _updateOrderBy,
// //             onLimitChanged: _updateLimit,
// //             onSortChanged: _updateSort,
// //             onTypeChanged: _updateType,
// //           ),
// //           body: NotificationListener<ScrollNotification>(
// //             onNotification: (ScrollNotification scrollInfo) {
// //               if (!_isLoading &&
// //                   _hasMore &&
// //                   scrollInfo.metrics.pixels ==
// //                       scrollInfo.metrics.maxScrollExtent) {
// //                 _fetchPokemons();
// //               }
// //               return false;
// //             },
// //             child: PokemonList(pokemons: _pokemons),
// //           ),
// //         ),
// //         if (_isLoading)
// //           const Positioned(
// //             bottom: 10,
// //             left: 0,
// //             right: 0,
// //             child: Center(child: CircularProgressIndicator()),
// //           ),
// //       ],
// //     );
// //   }
// // }
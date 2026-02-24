import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/favorite_provider.dart';
import 'package:resto_app/ui/pages/detail_page.dart';
import 'package:resto_app/utils/result_state.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<FavoriteProvider>().loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Restaurants')),
      body: Consumer<FavoriteProvider>(
        builder: (context, provider, _) {
          final state = provider.state;

          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ErrorState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      (state as ErrorState).message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is SuccessState<List<Map<String, dynamic>>>) {
            final favorites = state.data;

            if (favorites.isEmpty) {
              return const Center(child: Text('Belum ada restoran favorit'));
            }

            return ListView.builder(
              key: const Key('favorite_list'),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final resto = favorites[index];

                return Card(
                  margin: const EdgeInsets.all(12),
                  child: ListTile(
                    leading: Image.network(
                      'https://restaurant-api.dicoding.dev/images/small/${resto['pictureId']}',
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(resto['name']),
                    subtitle: Text('${resto['city']} • ⭐ ${resto['rating']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        provider.removeFavorite(resto['id']);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailPage(id: resto['id']),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

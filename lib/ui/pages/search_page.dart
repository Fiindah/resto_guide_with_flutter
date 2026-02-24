import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/search_provider.dart';
import '../../ui/widgets/resto_card.dart';
import '../../utils/result_state.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'search-bar',
          child: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Cari resto atau cafe',
              border: InputBorder.none,
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              context.read<SearchProvider>().searchRestaurant(value);
            },
          ),
        ),
      ),
      body: Consumer<SearchProvider>(
        builder: (context, provider, _) {
          final state = provider.state;

          if (state == null) {
            return const Center(child: Text('Ketik nama restoran'));
          }

          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ErrorState) {
            return Center(
              child: Text(
                (state as ErrorState).message,
                textAlign: TextAlign.center,
              ),
            );
          }

          if (state is SuccessState) {
            final successState = state as SuccessState;

            return ListView.builder(
              itemCount: successState.data.restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = successState.data.restaurants[index];
                return RestaurantCard(restaurant: restaurant);
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

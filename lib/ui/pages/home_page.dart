import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/resto_list_provider.dart';
import 'package:resto_app/ui/widgets/home_footer.dart';
import 'package:resto_app/ui/widgets/resto_card.dart';
import 'package:resto_app/ui/widgets/theme_header.dart';
import '../../utils/result_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantListProvider>(
        builder: (context, provider, _) {
          final state = provider.state;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                stretch: true,
                actions: const [ThemeHeaderSwitch()],
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text('Resto Guide'),
                  background: Image.network(
                    'https://images.unsplash.com/photo-1555396273-367ea4eb4db5',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.pushNamed(context, '/search');
                    },
                    child: Container(
                      height: 52,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const Row(
                        children: [
                          Hero(
                            tag: 'search-bar',
                            child: Material(
                              color: Colors.transparent,
                              child: Icon(Icons.search),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Cari resto atau cafe...',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              if (state is LoadingState)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),

              if (state is ErrorState)
                SliverFillRemaining(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        (state as ErrorState).message,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),

              if (state is SuccessState)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final successState = state as SuccessState;
                      final restaurant = successState.data.restaurants[index];

                      return RestaurantCard(restaurant: restaurant);
                    },
                    childCount: (state as SuccessState).data.restaurants.length,
                  ),
                ),
              SliverToBoxAdapter(child: const HomeFooter()),
            ],
          );
        },
      ),
    );
  }
}

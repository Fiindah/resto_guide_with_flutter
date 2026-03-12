import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/api/resto_api_service.dart';
import 'package:resto_app/data/model/resto_detail_response.dart';
import 'package:resto_app/provider/resto_detail_provider.dart';
import 'package:resto_app/ui/widgets/customer_review_list.dart';
import 'package:resto_app/ui/widgets/detail/detail_header.dart';
import 'package:resto_app/ui/widgets/detail/detail_info_section.dart';
import 'package:resto_app/ui/widgets/detail/menu_section.dart';
import 'package:resto_app/ui/widgets/review_form.dart';
import 'package:resto_app/ui/widgets/theme_footer.dart';
import '../../../utils/result_state.dart';

class DetailPage extends StatelessWidget {
  final String id;
  final String source;

  const DetailPage({super.key, required this.id, this.source = 'home'});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantDetailProvider(
        apiService: RestaurantApiService(),
        restaurantId: id,
      ),
      child: Scaffold(
        key: const ValueKey("detail_page"),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, provider, _) {
            final state = provider.state;

            switch (state) {
              case LoadingState():
                return const Center(child: CircularProgressIndicator());

              case ErrorState(message: final message):
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
                          message,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                );

              case SuccessState<RestaurantDetailResponse>(data: final data):
                final restaurant = data.restaurant;

                return CustomScrollView(
                  key: const Key('detail_scroll'),
                  slivers: [
                    DetailHeader(restaurant: restaurant, source: source),

                    SliverToBoxAdapter(
                      child: DetailInfoSection(restaurant: restaurant),
                    ),

                    SliverToBoxAdapter(
                      child: MenuSection(
                        foods: restaurant.menus.foods,
                        drinks: restaurant.menus.drinks,
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            const SizedBox(height: 16),
                            const Text(
                              'Customer Reviews',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            CustomerReviewList(
                              reviews: restaurant.customerReviews,
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'Add Your Review',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const ReviewForm(),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(child: ThemeFooter()),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_app/models/products_models.dart';
import 'package:ecom_app/providers/wishlist_providers.dart';
import 'package:ecom_app/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListItem extends StatelessWidget {
  final Products? product;
  const ListItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(children: [
            CachedNetworkImage(
              alignment: Alignment.center,
              imageUrl: product!.image,
              height: Responsive.isMobile(context) ? 130 : 200,
            ),

            SizedBox(height: 4), // Add spacing between the image and text

            // Truncate title to 2 words
            Text(
              _truncateTitle(product?.title ?? 'test1', 2),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 4), // Add spacing between the title and rating

            // Display price
            Text(
              'Price: \$${product?.price.toStringAsFixed(2) ?? '0.00'}',
              style: const TextStyle(
                fontSize: 12,
                color: Color.fromARGB(
                    255, 92, 119, 255), // Customize the color of the price
              ),
            ),

            SizedBox(height: 4),
            Text(
              'Rating: ${product?.rating.rate ?? 0.0} (${product?.rating.count ?? 0} reviews)',
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey, // Customize the color of the rating
              ),
            ),
          ]),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Consumer<WishList>(
            builder: (context, wishList, _) => IconButton(
              icon: Icon(
                wishList.isFav(product?.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Color.fromARGB(255, 255, 180, 180),
                size: 20,
              ),
              onPressed: () {
                Provider.of<WishList>(context, listen: false)
                    .toggle(product?.id);

                WishList favList = Provider.of(context, listen: false);

                if (wishList.isFav(product?.id)) {
                  favList.addToWishList(product);
                } else {
                  favList.removeFromWishList(product);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  String _truncateTitle(String title, int words) {
    List<String> titleWords = title.split(' ');
    if (titleWords.length <= words) {
      return title;
    } else {
      return titleWords.sublist(0, words).join(' ');
    }
  }
}

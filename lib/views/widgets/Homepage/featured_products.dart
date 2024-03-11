import 'package:ecom_app/responsive/responsive_layout.dart';
import 'package:ecom_app/views/shared/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ecom_app/controllers/products_controllers.dart';
import 'package:ecom_app/models/products_models.dart';
import '../ProductsDetail/product_details.dart';

class FeaturedProducts extends StatefulWidget {
  const FeaturedProducts({Key? key}) : super(key: key);

  @override
  _FeaturedProductsState createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  final ProductController products = ProductController();

  @override
  void initState() {
    super.initState();
    products.fetchProductsData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: products.fetchProductsData(),
        builder: (context, AsyncSnapshot<List<Products>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            List<Products>? prod = snapshot.data;

            int maxProduct = 6;

            return LayoutBuilder(builder: (context, Constraints) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: GridView.builder(
                  itemCount:
                      prod != null ? prod.length.clamp(0, maxProduct) : 0,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 800 ? 4 : 2,
                    childAspectRatio: Responsive.isMobile(context)
                        ? MediaQuery.of(context).size.aspectRatio * 3 / 2
                        : 1,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                data: prod?[index],
                              ),
                            ));
                      },
                      child: ListItem(prod?[index])),
                ),
              );
            });
          }
        });
  }
}

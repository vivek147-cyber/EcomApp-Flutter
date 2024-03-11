
import 'package:ecom_app/providers/cart_providers.dart';
import 'package:ecom_app/providers/wishlist_providers.dart';
import 'package:ecom_app/views/shared/common_screen.dart';
import 'package:ecom_app/views/widgets/ProductsPage/product_by_category.dart';
import 'package:flutter/material.dart';
import '../../responsive/responsive_layout.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({ Key? key }) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {


  @override
  void initState()
  {
    super.initState();
    Provider.of<WishList>(context,listen: false).getCartToPreferences();
    Provider.of<Cart>(context,listen: false).getCartToPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
       body: Responsive(mobile: _mobileProductPage(),desktop: _desktopProductPage()),
    );
    
  }

  Widget _desktopProductPage()
  {
    return CommonScreen(
      body: const SingleChildScrollView(
        child: Column(
          children: [
               Padding(
              padding: EdgeInsets.all(14.0),
              child: ProductByCategory(),
            ),
          ],
        ),
      ),
    );
  }


  Widget _mobileProductPage()
  {
    return const SingleChildScrollView(
      child: Column(
        children: [
           Padding(
            padding: EdgeInsets.all(14.0),
            child: ProductByCategory(),
          ),
        ],
      ),
    );
  }
}
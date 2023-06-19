import 'package:flutter/material.dart';
import 'package:alert_dialog/alert_dialog.dart';
class CartPage extends StatelessWidget {
  final List<Product> products;

  const CartPage({required this.products});

  @override
  Widget build(BuildContext context) {
    int totalProducts = 0;
    for (var product in products) {
      totalProducts += product.counter;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cart'),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      ),
      body: Center(
        child: Text('Total Products: $totalProducts',
          style: new TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),),
      ),
    );
  }
}
void main() {
  runApp(ProductApp());
}

class ProductApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductList(),
    );
  }
}

class Product {
  double price;
  int counter;
  Product({ required this.price, this.counter = 0});
  void incrementCounter() {
    counter++;
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final int index;
  const ProductItem({
    required this.product,
    required this.onTap, required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Product $index'),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      trailing: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${product.counter}'),
            ElevatedButton(
              onPressed: onTap,
              child: Text('Buy Now'),
            ),
          ],
        ),
      ),
    );
  }
}
class ItemList{
  static List<Product>  products = [
    Product(price: 10),
    Product(price: 20),
    Product(price: 30),
    Product(price: 40),
    Product(price: 50),
    Product(price: 60),
    Product(price: 70),
    Product(price: 80),
    Product(price: 90),
    Product(price: 100),
    Product(price: 110),
    Product(price: 120),
    Product(price: 130),
    Product(price: 140),
    Product(price: 150),
  ];
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product List')),
      body: ListView.builder(
        itemCount: ItemList.products.length,
        itemBuilder: (context, index) {
          return ProductItem(
            index: index,
            product: ItemList.products[index],
            onTap: () {
              if (ItemList.products[index].counter >= 5) {
                alert(
                  context,
                  title: Text('Congratulations!'),
                  content: Text('You\'ve bought 5 Product ${index}!'),
                  textOK: Text('Yes'),
                );
              } else {
                setState(() {
                  ItemList.products[index].incrementCounter();
                });
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CartPage(products: ItemList.products),
          ));
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}

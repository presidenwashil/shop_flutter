import 'package:flutter/material.dart';
import 'package:shop_flutter/api/repository.dart';
import 'package:shop_flutter/components/product_view.dart';
import 'package:shop_flutter/model/product.dart';

class Home extends StatefulWidget {
  final String title;

  const Home({
    super.key,
    required this.title,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  final Repository _apiService = Repository();

  final List<Product> _products = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreProducts();
      }
    });
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await _apiService.fetchProducts(_currentPage);
      setState(() {
        _currentPage++;
        _products.addAll(result['products']);
        _hasMore = result['nextPageUrl'] != null;
      });
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMoreProducts() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await _apiService.fetchProducts(_currentPage);
      setState(() {
        _currentPage++;
        _products.addAll(result['products']);
        _hasMore = result['nextPageUrl'] != null;
      });
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _buildProductlist(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO action to add and edit post
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildProductlist() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _products.length + (_hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _products.length) {
          return const Center(child: CircularProgressIndicator());
        }
        final product = _products[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card.filled(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () {
                // Todo action ke detail post
              },
              child: Stack(
                children: [
                  ProductView(product: product),
                  Positioned(
                    top: 2,
                    right: 2,
                    child: IconButton(
                      onPressed: () {
                        // TODO action to edit post
                      },
                      icon: const Icon(Icons.edit_rounded),
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: IconButton(
                      onPressed: () {
                        //TODO action delete post
                      },
                      icon: const Icon(Icons.delete_rounded),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
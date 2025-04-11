import 'package:ecommerce_app/core/resources/api_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product_model/purchase_table.dart';
import '../models/product_model/product_model.dart';
import '../resources/sensitive_data.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'dart:developer';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final ApiServices _apiServices = ApiServices();
  final String userId = Supabase.instance.client.auth.currentUser!.id;

  List<ProductModel> products = [];
  List<ProductModel> searchResults = [];
  List<ProductModel> categoryProducts = [];
  Future<void> getProduct({String? query, String? category}) async {
    products = [];
    searchResults = [];
    categoryProducts = [];
    favoriteProductsList = [];
    userOrders = [];
    emit(GetDataLoading());
    try {
      Response response = await _apiServices.getData(EndPoint.getProduct);
      for (var product in response.data) {
        products.add(ProductModel.fromJson(product));
      }
      getFavoriteProducts();
      search(query);
      getProductByCategory(category);
      getUserOrdersProducts();
      if (!isClosed) emit(GetDataSuccess());
    } catch (e) {
      log(e.toString());
      if (!isClosed) emit(GetDataFailure(e.toString()));
    }
  }

  void search(String? query) {
    if (query != null) {
      for (var product in products) {
        if (product.productName!.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(product);
        }
      }
    }
  }

  void getProductByCategory(String? category) {
    if (category != null) {
      for (var product in products) {
        if (product.category!.trim().toLowerCase() ==
            category.trim().toLowerCase()) {
          categoryProducts.add(product);
        }
      }
    }
  }

  Map<String, bool> favoriteProducts = {};
  void addToFavorite(String productId) async {
    emit(AddToFavoriteLoading());
    try {
      await _apiServices.postData('favorite_product', {
        'is_favorite': true,
        'for_user': userId,
        'for_product': productId,
      });
      await getProduct();
      favoriteProducts.addAll({productId: true});

      emit(AddToFavoriteSuccess());
    } catch (e) {
      log(e.toString());
      emit(AddToFavoriteFailure(e.toString()));
    }
  }

  bool checkIsFavorite(String productId) {
    return favoriteProducts.containsKey(productId);
  }

  void removeFromFavorite(String productId) async {
    emit(RemoveFromFavoriteLoading());
    try {
      await _apiServices.deleteData(
        'favorite_product?for_user=eq.$userId&for_product=eq.$productId',
      );
      await getProduct();
      favoriteProducts.removeWhere((key, value) => key == productId);
      emit(RemoveFromFavoriteSuccess());
    } catch (e) {
      log(e.toString());
      emit(RemoveFromFavoriteFailure(e.toString()));
    }
  }

  List<ProductModel> favoriteProductsList = [];
  void getFavoriteProducts() {
    for (ProductModel product in products) {
      if (product.favoriteProduct != null &&
          product.favoriteProduct!.isNotEmpty) {
        for (var favoriteProduct in product.favoriteProduct!) {
          if (favoriteProduct.forUser == userId) {
            favoriteProductsList.add(product);
            favoriteProducts.addAll({product.productId!: true});
          }
        }
      }
    }
  }

  Future<void> buyProduct({required String productId}) async {
    emit(BuyProductLoading());
    try {
      await _apiServices.postData('purchase_table', {
        'for_user': userId,
        'is_bought': true,
        'for_product': productId,
      });
      emit(BuyProductSuccess());
    } catch (e) {
      log(e.toString());
      emit(BuyProductFailure(e.toString()));
    }
  }

  List<ProductModel> userOrders = [];
  void getUserOrdersProducts() {
    for (ProductModel product in products) {
      if (product.purchaseTable != null && product.purchaseTable!.isNotEmpty) {
        for (PurchaseTable userOrder in product.purchaseTable!) {
          if (userOrder.forUser == userId) {
            userOrders.add(product);
          }
        }
      }
    }
  }
}

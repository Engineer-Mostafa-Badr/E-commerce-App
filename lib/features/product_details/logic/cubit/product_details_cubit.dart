import 'package:ecommerce_app/features/product_details/data/models/rate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/resources/api_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'dart:developer';
part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  final ApiServices _apiServices = ApiServices();
  String userId = Supabase.instance.client.auth.currentUser!.id;
  List<Rate> rates = [];
  int averageRate = 0;
  int userRate = 5;

  Future<void> getRate({required String productId}) async {
    if (isClosed) return;
    emit(GetRateLoading());
    try {
      Response response = await _apiServices.getData(
        'rate_product?select=*&for_product=eq.$productId',
      );
      for (var productRate in response.data) {
        rates.add(Rate.fromJson(productRate));
      }
      _getAverageRate();
      _getUserRate();

      if (!isClosed) emit(GetRateSuccess());
    } catch (e) {
      log(e.toString());
      if (!isClosed) emit(GetRateError(e.toString()));
    }
  }

  void _getUserRate() {
    List<Rate> userRates =
        rates.where((Rate rate) {
          return rate.forUser == userId;
        }).toList();
    if (userRates.isNotEmpty) {
      userRate = userRates[0].rate!;
    }
  }

  void _getAverageRate() {
    for (var userRate in rates) {
      if (userRate.rate != null) {
        averageRate += userRate.rate!;
      }
    }
    if (rates.isNotEmpty) {
      averageRate = averageRate ~/ rates.length;
    }
  }

  bool _isUserRateExest({required String productId}) {
    for (var rate in rates) {
      if ((rate.forUser == userId) && (rate.forProduct == productId)) {
        return true;
      }
    }
    return false;
  }

  Future<void> addOrUpdateRate({
    required String productId,
    required Map<String, dynamic> data,
  }) async {
    String path =
        'rate_product?select=*&for_user=eq.$userId&for_product=eq.$productId';
    if (isClosed) return;
    emit(AddOrUpdateRateLoading());
    try {
      if (_isUserRateExest(productId: productId)) {
        await _apiServices.patchData(path, data);
      } else {
        await _apiServices.postData(path, data);
      }
      if (!isClosed) emit(AddOrUpdateRateSuccess());
    } catch (e) {
      log(e.toString());
      if (!isClosed) emit(AddOrUpdateRateError(e.toString()));
    }
  }

  Future<void> addComment({required Map<String, dynamic> data}) async {
    if (isClosed) return;
    emit(AddCommentLoading());
    try {
      await _apiServices.postData('comments_table', data);
      if (!isClosed) emit(AddCommentSuccess());
    } catch (e) {
      log(e.toString());
      if (!isClosed) emit(AddCommentError(e.toString()));
    }
  }
}

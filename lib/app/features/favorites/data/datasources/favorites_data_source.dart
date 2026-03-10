import 'package:first_project/app/core/services/network/dio_client.dart';

abstract class FavoritesDataSource {
  Future<List<Map<String, dynamic>>> fetchFavorites();
}

class FavoritesDataSourceImpl extends FavoritesDataSource {
  final DioClient dioClient;
  FavoritesDataSourceImpl({required this.dioClient});
  
  @override
  Future<List<Map<String, dynamic>>> fetchFavorites() async {
    try {
      final response = await dioClient.get('https://wqdddfrlzvzsqezjnycd.supabase.co/rest/v1/wishlist?select=*');
      if(response.statusCode == 200){
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception("Failed to fetch favorites: ${response.statusMessage}");
      }
    } catch (e) {
      throw Exception("Failed to fetch favorites: ${e.toString()}");
    }
  }
}
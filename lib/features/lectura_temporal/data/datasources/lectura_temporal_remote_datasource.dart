import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/lectura_temporal_model.dart';

abstract class LecturaTemporalRemoteDataSource {
  Future<List<LecturaTemporalModel>> getLecturas();
  Future<LecturaTemporalModel> getLecturaById(String id);
  Future<void> saveLectura(LecturaTemporalModel lectura);
  Future<void> deleteLectura(String id);
}

class LecturaTemporalRemoteDataSourceImpl
    implements LecturaTemporalRemoteDataSource {
  final Dio dio;

  LecturaTemporalRemoteDataSourceImpl(this.dio);

  @override
  Future<List<LecturaTemporalModel>> getLecturas() async {
    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}${AppConstants.lecturaEndpoint}',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => LecturaTemporalModel.fromJson(json)).toList();
      } else {
        throw Exception('Error al obtener lecturas: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  @override
  Future<LecturaTemporalModel> getLecturaById(String id) async {
    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}${AppConstants.lecturaEndpoint}/$id',
      );

      if (response.statusCode == 200) {
        return LecturaTemporalModel.fromJson(response.data);
      } else {
        throw Exception('Error al obtener lectura: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  @override
  Future<void> saveLectura(LecturaTemporalModel lectura) async {
    try {
      final response = await dio.post(
        '${AppConstants.baseUrl}${AppConstants.lecturaEndpoint}',
        data: lectura.toJson(),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Error al guardar lectura: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  @override
  Future<void> deleteLectura(String id) async {
    try {
      final response = await dio.delete(
        '${AppConstants.baseUrl}${AppConstants.lecturaEndpoint}/$id',
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Error al eliminar lectura: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}

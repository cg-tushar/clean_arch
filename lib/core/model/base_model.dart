library base_model.dart;

abstract class BaseModel<T> {
  T fromJson(Map<String, dynamic> data);
}

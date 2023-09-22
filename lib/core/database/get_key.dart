
// * Creating local Storage key from url and endpoint to store cache data
class CacheKeyGenerator {
  String generate(String path, Map<String, String>? query) {
    return path+query.toString();
  }
}

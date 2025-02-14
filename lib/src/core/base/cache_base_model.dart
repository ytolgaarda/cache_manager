/// [TR] CacheModel isminde soyut  bir sınıf.
/// [EN] An abstract class named CacheModel .
abstract class CacheModel {
  /// [TR] Bu sınıf içinde 'id' isminde bir değişken tanımlanıyor. final olduğu için bu değer yalnızca bir kez atanabilir.
  /// [EN] A final variable 'id' is defined inside the class, which can only be assigned once.
  final String id;

  /// [TR] CacheModel sınıfının yapıcı metodu (constructor), 'id' parametresini alır ve bu değeri 'id' değişkenine atar.
  /// [EN] The constructor of the CacheModel class takes the 'id' parameter and assigns it to the 'id' variable.
  CacheModel(this.id);

  /// [TR] 'fromJson' metodu, JSON verisini alarak CacheModel nesnesine dönüştürmeyi amaçlar.
  /// [EN] The 'fromJson' method aims to convert JSON data into a CacheModel object.
  CacheModel fromJson(Map<String, dynamic> json);

  /// [TR] 'toJson' metodu, CacheModel nesnesini JSON formatına dönüştürür ve bir Map döner.
  /// [EN] The 'toJson' method converts the CacheModel object into JSON format and returns a Map.
  Map<String, dynamic> toJson();
}

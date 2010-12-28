# Change Log

## 1.1 - 12/22/10

* Support for `radius` in SimpleGeo Places
* Support for address queries against SimpleGeo Context + SimpleGeo Places
* Changed `didLoadContext:(NSDictionary *)for:(SGPoint *)` to
  `didLoadContext:(NSDictionary *)forQuery:(NSDictionary *)` in
  `SimpleGeoContextDelegate`
* Changed `didLoadPlaces:(SGFeatureCollection *)near:(SGPoint *):matching:(NSString *):inCategory:(NSString *)`
  to `didLoadPlaces:(SGFeatureCollection *)forQuery:(NSDictionary *)` in
  `SimpleGeoPlacesDelegate`
* Changed `didUpdatePlace:(NSString *)token:(NSString *)` to
  `didUpdatePlace:(SGFeature *)handle:(NSString *)token:(NSString *)` in
  `SimpleGeoPlacesDelegate`
* Changed `getContext:(SGPoint *)` to `getContextForPoint:(SGPoint *)` in
  `SimpleGeo+Context`
* `SimpleGeo` `delegate` property is now read/write

## 1.0 - 12/8/10

* Initial release
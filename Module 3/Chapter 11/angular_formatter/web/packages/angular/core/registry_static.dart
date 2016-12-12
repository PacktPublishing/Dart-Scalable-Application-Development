library angular.core_static;

import 'package:di/annotations.dart';
import 'package:angular/core/registry.dart';

@Injectable()
class StaticMetadataExtractor extends MetadataExtractor {
  final Map<Type, Iterable> metadataMap;
  final List empty = const [];

  StaticMetadataExtractor(this.metadataMap);

  Iterable call(Type type) {
    Iterable i = metadataMap[type];
    return i == null ? empty : i;
  }
}

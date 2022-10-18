import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'parsing_test.freezed.dart';
part 'parsing_test.g.dart';

void main() {
  group('Polymorphic parsing', () {
    test('Default parsing', () async {
      final jsonDecoding = json.decode(json1);
      final list = jsonDecoding
          .map<PolymorphicParsing>((e) => PolymorphicParsing.fromJson(e))
          .toList();
      expect(list is List<PolymorphicParsing>, true);
    });
    test('Custom key parsing', () async {
      final jsonDecoding = json.decode(json2);

      final list = jsonDecoding
          .map<PolymorphicParsingWithCustomType>(
              (e) => PolymorphicParsingWithCustomType.fromJson(e))
          .toList();
      expect(list is List<PolymorphicParsingWithCustomType>, true);
    });
  });
}

@freezed
class PolymorphicParsing with _$PolymorphicParsing {
  factory PolymorphicParsing.dog({
    required String name,
    required String furLength,
  }) = _Dog;
  factory PolymorphicParsing.bird({
    required String name,
    required bool isMigratory,
  }) = _Bird;
  factory PolymorphicParsing.fish({
    required String name,
    required String mainClass,
  }) = _Fish;

  factory PolymorphicParsing.fromJson(Map<String, dynamic> json) =>
      _$PolymorphicParsingFromJson(json);
}

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.pascal)
class PolymorphicParsingWithCustomType with _$PolymorphicParsingWithCustomType {
  factory PolymorphicParsingWithCustomType.dog({
    required String name,
    required String furLength,
  }) = _TypeDog;
  factory PolymorphicParsingWithCustomType.bird({
    required String name,
    required bool isMigratory,
  }) = _TypeBird;
  factory PolymorphicParsingWithCustomType.fish({
    required String name,
    required String mainClass,
  }) = _TypeFish;

  factory PolymorphicParsingWithCustomType.fromJson(
          Map<String, dynamic> json) =>
      _$PolymorphicParsingWithCustomTypeFromJson(json);
}

const String json1 = '''
[
   {
      "name":"Bird 0",
      "isMigratory":true,
      "runtimeType":"bird"
   },
   {
      "name":"Fish 1",
      "mainClass":"bony fish",
      "runtimeType":"fish"
   },
   {
      "name":"Dog 2",
      "furLength":"Long",
      "runtimeType":"dog"
   },
   {
      "name":"Bird 3",
      "isMigratory":false,
      "runtimeType":"bird"
   },
   {
      "name":"Dog 4",
      "furLength":"Long",
      "runtimeType":"dog"
   },
   {
      "name":"Fish 5",
      "mainClass":"bony fish",
      "runtimeType":"fish"
   },
   {
      "name":"Bird 6",
      "isMigratory":false,
      "runtimeType":"bird"
   },
   {
      "name":"Fish 7",
      "mainClass":"bony fish",
      "runtimeType":"fish"
   },
   {
      "name":"Dog 8",
      "furLength":"Long",
      "runtimeType":"dog"
   },
   {
      "name":"Bird 9",
      "isMigratory":true,
      "runtimeType":"bird"
   }
]
''';

const String json2 = '''[
   {
      "name":"Bird 0",
      "isMigratory":false,
      "type":"Bird"
   },
   {
      "name":"Fish 1",
      "mainClass":"bony fish",
      "type":"Fish"
   },
   {
      "name":"Dog 2",
      "furLength":"Long",
      "type":"Dog"
   },
   {
      "name":"Bird 3",
      "isMigratory":false,
      "type":"Bird"
   },
   {
      "name":"Dog 4",
      "furLength":"Long",
      "type":"Dog"
   },
   {
      "name":"Fish 5",
      "mainClass":"bony fish",
      "type":"Fish"
   }
]
''';

String generateData(final int length) {
  return json.encode(List.generate(length, (index) {
    if (index % 3 == 0) {
      return PolymorphicParsing.bird(
              name: 'Bird $index', isMigratory: Random().nextBool())
          .toJson();
    }
    if (index % 2 == 0) {
      return PolymorphicParsing.dog(name: 'Dog $index', furLength: 'Long')
          .toJson();
    }
    return PolymorphicParsing.fish(name: 'Fish $index', mainClass: 'bony fish')
        .toJson();
  }));
}

String generateCustomData(final int length) {
  return json.encode(List.generate(length, (index) {
    if (index % 3 == 0) {
      return PolymorphicParsingWithCustomType.bird(
              name: 'Bird $index', isMigratory: Random().nextBool())
          .toJson();
    }
    if (index % 2 == 0) {
      return PolymorphicParsingWithCustomType.dog(
              name: 'Dog $index', furLength: 'Long')
          .toJson();
    }
    return PolymorphicParsingWithCustomType.fish(
            name: 'Fish $index', mainClass: 'bony fish')
        .toJson();
  }));
}

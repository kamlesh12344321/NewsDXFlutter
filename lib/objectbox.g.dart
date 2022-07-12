// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'bookmark/model/bookmark_article.dart';
import 'myfeed/model/myfeed_section.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 934554475604040173),
      name: 'BookMarkArticleModel',
      lastPropertyId: const IdUid(2, 5557730123500033637),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 44303476820572409),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5557730123500033637),
            name: 'articleId',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 891773605931791420),
      name: 'MyFeedModel',
      lastPropertyId: const IdUid(2, 3158588960085952935),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1159779364145500183),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3158588960085952935),
            name: 'sectionId',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 891773605931791420),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    BookMarkArticleModel: EntityDefinition<BookMarkArticleModel>(
        model: _entities[0],
        toOneRelations: (BookMarkArticleModel object) => [],
        toManyRelations: (BookMarkArticleModel object) => {},
        getId: (BookMarkArticleModel object) => object.id,
        setId: (BookMarkArticleModel object, int id) {
          object.id = id;
        },
        objectToFB: (BookMarkArticleModel object, fb.Builder fbb) {
          final articleIdOffset = fbb.writeString(object.articleId);
          fbb.startTable(3);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, articleIdOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = BookMarkArticleModel(
              articleId: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        }),
    MyFeedModel: EntityDefinition<MyFeedModel>(
        model: _entities[1],
        toOneRelations: (MyFeedModel object) => [],
        toManyRelations: (MyFeedModel object) => {},
        getId: (MyFeedModel object) => object.id,
        setId: (MyFeedModel object, int id) {
          object.id = id;
        },
        objectToFB: (MyFeedModel object, fb.Builder fbb) {
          final sectionIdOffset = fbb.writeString(object.sectionId);
          fbb.startTable(3);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, sectionIdOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = MyFeedModel(
              sectionId: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [BookMarkArticleModel] entity fields to define ObjectBox queries.
class BookMarkArticleModel_ {
  /// see [BookMarkArticleModel.id]
  static final id =
      QueryIntegerProperty<BookMarkArticleModel>(_entities[0].properties[0]);

  /// see [BookMarkArticleModel.articleId]
  static final articleId =
      QueryStringProperty<BookMarkArticleModel>(_entities[0].properties[1]);
}

/// [MyFeedModel] entity fields to define ObjectBox queries.
class MyFeedModel_ {
  /// see [MyFeedModel.id]
  static final id =
      QueryIntegerProperty<MyFeedModel>(_entities[1].properties[0]);

  /// see [MyFeedModel.sectionId]
  static final sectionId =
      QueryStringProperty<MyFeedModel>(_entities[1].properties[1]);
}

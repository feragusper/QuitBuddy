import 'dart:async';

import 'package:intl/intl.dart';

typedef LibraryLoader = Future<dynamic> Function();

Map<String, LibraryLoader> _deferredLibraries = {
  'en': () => Future.value(null),
};

/// User programs should call this before using [localeName] for messages.
Future initializeMessages(String localeName) async {
  var lib = _deferredLibraries[Intl.canonicalizedLocale(localeName)];
  await (lib == null ? Future.value(false) : lib());
//  initializeInternalMessageLookup(() => CompositeMessageLookup());
//  messageLookup.addLocale(localeName, _findGeneratedMessagesFor);
}

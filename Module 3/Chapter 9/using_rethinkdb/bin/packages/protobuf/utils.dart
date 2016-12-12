// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of protobuf;

// TODO(antonm): reconsider later if PbList should take care of equality.
bool _deepEquals(lhs, rhs) {
  if ((lhs is List) && (rhs is List)) return _areListsEqual(lhs, rhs);
  if ((lhs is Map) && (rhs is Map)) return _areMapsEqual(lhs, rhs);
  if ((lhs is ByteData) && (rhs is ByteData)) {
    return _areByteDataEqual(lhs, rhs);
  }
  return lhs == rhs;
}

bool _areListsEqual(List lhs, List rhs) {
  range(i) => new Iterable.generate(i, (i) => i);

  if (lhs.length != rhs.length) return false;
  return range(lhs.length).every((i) => _deepEquals(lhs[i], rhs[i]));
}

bool _areMapsEqual(Map lhs, Map rhs) {
  if (lhs.length != rhs.length) return false;
  return lhs.keys.every((key) => _deepEquals(lhs[key], rhs[key]));
}

bool _areByteDataEqual(ByteData lhs, ByteData rhs) {
  asBytes(d) => new Uint8List.view(d.buffer, d.offsetInBytes, d.lengthInBytes);
  return _areListsEqual(asBytes(lhs), asBytes(rhs));
}

List sorted(Iterable list) => new List.from(list)..sort();

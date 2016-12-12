part of bson;
class BsonBinary extends BsonObject{
  static final bool  UseFixnum = _isIntWorkaroundNeeded();
  static final BUFFER_SIZE = 256;
  static final SUBTYPE_DEFAULT = 0;
  static final SUBTYPE_FUNCTION = 1;
  static final SUBTYPE_BYTE_ARRAY = 2;
  static final SUBTYPE_UUID = 3;
  static final SUBTYPE_MD5 = 4;
  static final SUBTYPE_USER_DEFINED = 128;

  // Use a list as jump-table. It is faster than switch and if.
  static const int CHAR_0 = 48;
  static const int CHAR_1 = 49;
  static const int CHAR_2 = 50;
  static const int CHAR_3 = 51;
  static const int CHAR_4 = 52;
  static const int CHAR_5 = 53;
  static const int CHAR_6 = 54;
  static const int CHAR_7 = 55;
  static const int CHAR_8 = 56;
  static const int CHAR_9 = 57;
  static const int CHAR_a = 97;
  static const int CHAR_b = 98;
  static const int CHAR_c = 99;
  static const int CHAR_d = 100;
  static const int CHAR_e = 101;
  static const int CHAR_f = 102;

  static final tokens = createTokens();
  ByteData byteArray;
  List<int> byteList;
  int offset;
  int subType;
  String _hexString;

  static List<int> createTokens(){
    var result = new List<int>(255);
    result[CHAR_0] = 0;
    result[CHAR_1] = 1;
    result[CHAR_2] = 2;
    result[CHAR_3] = 3;
    result[CHAR_4] = 4;
    result[CHAR_5] = 5;
    result[CHAR_6] = 6;
    result[CHAR_7] = 7;
    result[CHAR_8] = 8;
    result[CHAR_9] = 9;
    result[CHAR_a] = 10;
    result[CHAR_b] = 11;
    result[CHAR_c] = 12;
    result[CHAR_d] = 13;
    result[CHAR_e] = 14;
    result[CHAR_f] = 15;
    return result;
  }
  set hexString(String value) => _hexString = value;
  String get hexString {
    if (_hexString == null) {
      makeHexString();
    }
    return _hexString;
  }
  BsonBinary(int length): byteList = new Uint8List(length), offset=0, subType=0{
    byteArray = _getByteData(byteList);
  }
  BsonBinary.from(List from): byteList = new Uint8List(from.length),offset=0, subType=0 {
    byteList.setRange(0, from.length, from);
    byteArray = _getByteData(byteList);
  }
  BsonBinary.fromHexString(this._hexString);
  int get typeByte => _BSON_DATA_BINARY;
  ByteData _getByteData(from) => new ByteData.view(from.buffer);
  makeHexString(){
    StringBuffer stringBuffer = new StringBuffer();
    for (final byte in byteList)
    {
       if (byte < 16){
        stringBuffer.write("0");
       }
       stringBuffer.write(byte.toRadixString(16));
    }
    _hexString = stringBuffer.toString().toLowerCase();
  }
  makeByteList() {
    if (_hexString.length.remainder(2) != 0) {
      throw 'Not valid hex representation: $_hexString (odd length)';
    }
    byteList = new Uint8List((_hexString.length / 2).round().toInt());
    byteArray = _getByteData(byteList);
    int pos = 0;
    int listPos = 0;
    while (pos < _hexString.length) {
      int char = _hexString.codeUnitAt(pos);
      int n1 = tokens[char];
      if (n1 == null) {
        throw 'Invalid char ${_hexString[pos]} in $_hexString';
      }
      pos++;
      char = _hexString.codeUnitAt(pos);
      int n2 = tokens[char];
      if (n2 == null) {
        throw 'Invalid char ${_hexString[pos]} in $_hexString';
      }
      byteList[listPos++] = (n1 << 4)  + n2;
      pos++;
    }
  }
  setIntExtended(int value, int numOfBytes, Endianness endianness){
    List<int> byteListTmp = new Uint8List(4);
    var byteArrayTmp = _getByteData(byteListTmp);
    if (numOfBytes == 3){
      byteArrayTmp.setInt32(0,value,endianness);
    }
//    else if (numOfBytes > 4 && numOfBytes < 8){
//      byteArrayTmp.setInt64(0,value,Endianness.LITTLE_ENDIAN);
//    }
    else {
        throw new Exception("Unsupported num of bytes: ${numOfBytes}");
    }
    byteList.setRange(offset,offset+numOfBytes,byteListTmp);
  }
  reverse(int numOfBytes){
    swap(int x, int y){
      int t = byteList[x+offset];
      byteList[x+offset] = byteList[y+offset];
      byteList[y+offset] = t;
    }
    for(int i=0;i<=(numOfBytes-1)%2;i++){
      swap(i,numOfBytes-1-i);
    }
  }
  encodeInt(int position,int value, int numOfBytes, Endianness endianness, bool signed) {
    switch(numOfBytes) {
      case 4:
        byteArray.setInt32(position,value,endianness);
        break;
      case 2:
        byteArray.setInt16(position,value,endianness);
        break;
      case 1:
        byteArray.setInt8(position,value);
        break;
      default:
        throw new Exception("Unsupported num of bytes: $numOfBytes");
    }
  }
  writeInt(int value, {int numOfBytes:4, endianness: Endianness.LITTLE_ENDIAN, bool signed:false}){
    encodeInt(offset,value, numOfBytes,endianness,signed);
    offset += numOfBytes;
  }
  writeByte(int value){
    encodeInt(offset,value, 1,Endianness.LITTLE_ENDIAN,false);
    offset += 1;
  }
  int writeDouble(double value){
    byteArray.setFloat64(offset, value,Endianness.LITTLE_ENDIAN);
    offset+=8;
  }
  int writeInt64(int value){
    if (UseFixnum) {
      int64 d64 = new int64.fromInt(value);
      BsonBinary b2 = new BsonBinary(8);
      byteList.setRange(offset,offset+8,d64.toBytes());
    }
    else {
      byteArray.setInt64(offset, value,Endianness.LITTLE_ENDIAN);
    }
    offset+=8;
  }
  int readByte(){
    return byteList[offset++];
  }
  int readInt32(){
    offset+=4;
    return byteArray.getInt32(offset-4,Endianness.LITTLE_ENDIAN);
  }
  int readInt64(){
    offset+=8;
    if (UseFixnum) {
      offset -= 8;
      int i1 = readInt32();
      int i2 = readInt32();
      var i64 = new int64.fromInts(i2, i1);
      return i64.toInt();
    }
    return byteArray.getInt64(offset-8,Endianness.LITTLE_ENDIAN);
  }
  num readDouble(){
    offset+=8;
    return byteArray.getFloat64(offset-8,Endianness.LITTLE_ENDIAN);
  }

  String readCString(){
    List<int> stringBytes = [];
    while (byteList[offset++]!= 0){
       stringBytes.add(byteList[offset-1]);
    }
    return UTF8.decode(stringBytes);
  }
  writeCString(String val){
    final utfData = UTF8.encode(val);
    byteList.setRange(offset,offset+utfData.length,utfData);
    offset += utfData.length;
    writeByte(0);
 }

  int byteLength() => byteList.length+4+1;
  bool atEnd() => offset == byteList.length;
  rewind(){
    offset = 0;
  }
  packValue(BsonBinary buffer){
    if (byteList == null) {
      makeByteList();
    }
    buffer.writeInt(byteList.length);
    buffer.writeByte(subType);
    buffer.byteList.setRange(buffer.offset,buffer.offset+byteList.length,byteList);
    buffer.offset += byteList.length;
  }
  unpackValue(BsonBinary buffer){
    int size = buffer.readInt32();
    subType = buffer.readByte();
    byteList = new Uint8List(size);
    byteArray = _getByteData(byteList);
    byteList.setRange(0,size,buffer.byteList,buffer.offset);
    buffer.offset += size;
  }
  get value => this;
  String toString()=>"BsonBinary($hexString)";
}

bool _isIntWorkaroundNeeded() {
  int n=9007199254740992;
  int newInt = n + 1;   return newInt.toString() == n.toString();
}    


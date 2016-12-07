import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';
import 'dart:io';

void main( List<String > arguments) {
  if( arguments.length != 2){
    print( "Error incorrect params\nUSAGE packageName version\nexample dart downloadFromPub.dart http 0.10.0");
    new Exception();
    exit(1);
  }

  String name = arguments[0];
  String version = arguments[1];

  void processResponse(http.Response response){
      print( "processing file downloaded");
      if( response.statusCode != 200){
        throw new Exception( "invalid response from server, ${response.statusCode}-${response.reasonPhrase}");
      }
    //File downloaded is a gz that contains a Tar (go figure)
      GZipCodec gzip = new GZipCodec();
      List<int> archiveAsTar = gzip.decode(  response.bodyBytes);
      Archive archive = new TarDecoder().decodeBytes( archiveAsTar);
      String cacheLocation = Platform.environment[ "APPDATA"] + "Pub/Cache/hosted/pub.dartlang.org";

      for (ArchiveFile file in archive) {
         String filename = file.name;
         List<int> data = file.content;

         String target = "${cacheLocation}/${name}-${version}/${filename}";
         print( target);
         new File(target)
               ..createSync(recursive: true)
               ..writeAsBytesSync(data);
      }
  }

  void onError( var error){
    print( "Could not process download due to error: ${error}" );
  }

  String url = "https://commondatastorage.googleapis.com/pub.dartlang.org/packages/${name}-${version}.tar.gz";
  print( "download data from pub ${url}");
  http.get( url).then( processResponse).catchError( onError);

}

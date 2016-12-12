import 'dart:html';

void main() {
  new AppCache(window.applicationCache);
}

class AppCache {
  ApplicationCache appCache;

  AppCache(this.appCache) {
    // Set up handlers to log all of the cache events or errors.
//    appCache.onCached.listen(onCacheEvent);
//    appCache.onChecking.listen(onCacheEvent);
//    appCache.onDownloading.listen(onCacheEvent);
//    appCache.onNoUpdate.listen(onCacheEvent);
//    appCache.onObsolete.listen(onCacheEvent);
//    appCache.onProgress.listen(onCacheEvent);
    appCache.onUpdateReady.listen((e) => updateReady());
    appCache.onError.listen(onCacheError);
  }

  void updateReady() {
    if (appCache.status == ApplicationCache.UPDATEREADY) {
      // The browser downloaded a new app cache. Alert the user:
      appCache.swapCache();
      window.alert('A new version of this site is available. Please reload.');
    }
  }

//  void onCacheEvent(Event e) {
//    print('Cache event: ${e}');
//  }

  void onCacheError(Event e) {
      print('Cache error: ${e}');
      // Implement more complete error reporting to developers
  }
}
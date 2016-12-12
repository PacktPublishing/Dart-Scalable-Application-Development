import 'dart:html';
import 'package:chrome/chrome_app.dart' as chrome;

int boundsChange = 100;
var txtp = querySelector("#text_id");
int n = 0;

void main() {
  chrome.runtime.getPlatformInfo().then((Map m) {
    txtp.text = m.toString();
    });
  txtp.onClick.listen(rewriteText);
}

void resizeWindow(MouseEvent e) {
  chrome.Bounds bounds = chrome.app.window.current().getBounds();
  bounds.width += boundsChange;
  bounds.left -= boundsChange ~/ 2;
  chrome.app.window.current().setBounds(bounds);
  boundsChange *= -1;
}

void rewriteText(MouseEvent e) {
  txtp.text = "Hey, you clicked ${n++} times on a Chrome packaged app!";
  resizeWindow(e);
}
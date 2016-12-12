import 'dart:html';
// import 'dart:convert' show HtmlEscape;

final allHtml = const NullTreeSanitizer();

void main() {
  // default sanitization:
  var elem1 = new Element.html('<div class="foo">content</div>');
  document.body.children.add(elem1);
  var elem2 = new Element.html('<script class="foo">evil content</script><p>ok?</p>');
  document.body.children.add(elem2);
  // using HtmlEscape:
//  var unsafe = '<script class="foo">evil    content</script><p>ok?</p>';
//  var sanitizer = const HtmlEscape();
//  print(sanitizer.convert(unsafe));
  // using node validation:
  var html_string = '<p class="note">a note aside</p>';
//  var node1 = new Element.html(
//       html_string,
//       validator: new NodeValidatorBuilder()
//          ..allowElement('a', attributes: ['href'])
//      );
//  document.body.children.add(node1);
  var elem3 = new Element.html('<p>a text</p>');
  elem3.setInnerHtml(html_string, treeSanitizer: allHtml);
}

class NullTreeSanitizer implements NodeTreeSanitizer {
  const NullTreeSanitizer();
  void sanitizeTree(Node node) {}
}


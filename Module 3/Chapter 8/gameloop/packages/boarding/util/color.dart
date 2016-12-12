part of boarding_model;

Map<String, String> colorMap() {
  return {
    'azure':      '#f0ffff',
    'beer':       '#fbb117',
    'beige':      '#f5f5dc',
    'blue':       '#0000ff' ,
    'brown':      '#963939',
    'chocolate':  '#d2691e',
    'coral':      '#ff7f50',
    'cornyellow': '#fff380',
    'cream':      '#ffffcc',
    'crimson':    '#e238ec',
    'cyan':       '#00ffff',
    'darkblue':   '#0000a0',
    'gold':       '#ffd700',
    'grapefruit': '#dc381f',
    'gray':       '#909090',
    'green':      '#009000',
    'ivory':      '#fffff0',
    'khaki':      '#f0e68c',
    'lightblue':  '#add8e6',
    'lightgray':  '#f8f8f8',
    'lime':       '#00ff00',
    'linen':      '#faf0e6',
    'magenta':    '#ff00ff',
    'maroon':     '#800000',
    'olive':      '#808000',
    'orange':     '#ff6f00',
    'peach':      '#ffe5b4',
    'pearl':      '#fdeef4',
    'pink':       '#faafbe',
    'red':        '#ff0000',
    'silver':     '#c0c0c0',
    'sunyellow':  '#ffe87c',
    'teagreen':   '#ccfb5b',
    'turquoise':  '#43c6db',
    'vanilla':    '#f3e5ab',
    'water':      '#ebf4fa',
    'wheat':      '#f5deb3',
    'yellow':     '#ffff00'
  };
}

List<String> colorList() {
  return [
    'azure',
    'beer'
    'beige',
    'blue',
    'brown',
    'chocolate',
    'coral',
    'cornyellow',
    'cream',
    'crimson',
    'cyan',
    'darkblue',
    'gold',
    'grapefruit',
    'gray',
    'green',
    'ivory',
    'khaki',
    'lightblue',
    'lightgray',
    'lime',
    'linen',
    'magenta',
    'maroon',
    'olive',
    'orange',
    'peach',
    'pearl',
    'pink',
    'red',
    'silver',
    'sunyellow',
    'teagreen'
    'turquoise',
    'vanilla',
    'water',
    'wheat',
    'yellow'
  ];
}

List usedColors = [];

String randomColor() => randomListElement(colorList());

String randomColorCode() => colorMap()[randomColor()];

String getFreeRandomColor() {
  var color;
  do {
    color = randomColor();
  } while (usedColors.any((c) => c == color));
  usedColors.add(color);
  return color;
}

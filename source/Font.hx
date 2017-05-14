package;

import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFieldAutoSize;
import openfl.Assets;

class Font {
  public static function getFontName():String {
    return Assets.getFont("assets/font/njnaruto.ttf").fontName;
  }

  public static function getTextField(size:Int = 24, color: Int = 0xfefa65) {
    var textField = new TextField();
    textField.setTextFormat(new TextFormat(getFontName(), size, color));
    textField.selectable = false;
    textField.autoSize = TextFieldAutoSize.LEFT;
    return textField;
  }
}

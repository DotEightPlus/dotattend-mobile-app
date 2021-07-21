final String imageAssetRoot = "assets/images/";

final String a = _getImagePath("a.png");
final String b = _getImagePath("b.png");
final String c = _getImagePath("c.png");
final String login = _getImagePath("login.png");
final String todo = _getImagePath("todo.png");
final String scanning = _getImagePath("scanning.json");



String _getImagePath(String imageName) => imageAssetRoot + imageName;

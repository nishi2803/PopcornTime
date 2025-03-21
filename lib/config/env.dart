import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static final bool IS_PROD = dotenv.env["ENVIRONMENT"].toString() == "production";
  static final String baseUrl = "https://api.themoviedb.org/3";
  static final accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NWEwNDYwMTI3OTkwOWZmNDlhMGNjMTQyMDkwMmJlMiIsIm5iZiI6MTc0MjQ5MTUwOC4xNjk5OTk4LCJzdWIiOiI2N2RjNGY3NGM2MGQ1MTc3YWRlYTIwMWMiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.WxOBdq0ojew33T3oOqF9hnbrNCQo3qZ7SfmgTVWF2XM";
}
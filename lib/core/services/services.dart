import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../config/injectable/injectable_dependency.dart';
import '../../config/env/env.dart';
import '../error/error.dart';
import '../utils/logger.dart';

part 'base_client.dart';

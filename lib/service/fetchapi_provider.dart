import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/model.dart';


final fetchapiProvider = FutureProvider((ref) {

const url = 'https://app.schertech.com/task_visu_dev/php/task_visu_data_service.php?service=get_all_task&user_id=101030&start_date=01.01.2019%2000:00&end_date=01.01.2050%2000:00&status=offen&task_type=my_task&team_id=0&stage_key=';

  return http.get(Uri.parse(url)).then((value) => Schertech.fromJson(json.decode(value.body)));

});
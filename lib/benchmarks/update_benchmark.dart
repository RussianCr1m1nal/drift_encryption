
import 'package:encryption_drift/benchmarks/insert_benchmark.dart';
import 'package:encryption_drift/data/database/database.dart';
import 'package:encryption_drift/domain/di/di.dart';

class UpdateBenchmark {
  UpdateBenchmark();

  static Future<void> run() async {
    final watch = Stopwatch();
    final database = getIt<AppDataBase>();


    final list = generatePersonList();

    watch.start();
    await database.personDao.updateAll(list);  
    print('Update time for 10k row ${watch.elapsedMilliseconds}ms');
    watch.stop();
  }
}

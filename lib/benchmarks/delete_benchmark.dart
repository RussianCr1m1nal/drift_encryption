
import 'package:encryption_drift/data/database/database.dart';
import 'package:encryption_drift/domain/di/di.dart';

class DeleteBenchmark {
  DeleteBenchmark();

  static Future<void> run() async {
    final watch = Stopwatch();
    final database = getIt<AppDataBase>();
    watch.start();
    await database.personDao.deleteAll();  
    print('Delete time for 10k row ${watch.elapsedMilliseconds}ms');
    watch.stop();
  }
}

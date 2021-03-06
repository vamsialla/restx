import utest.ui.Report;
import utest.Runner;

class TestAll {
  static var port = 8888;
  public static function main() {
    var runner = new Runner();
    // run static tests
    runner.addCase(new TestAll());

    // run REST tests
    runner.addCase(new TestManual());
    runner.addCase(new TestAuto());

    // report
    Report.create(runner);
    runner.run();
  }

  public function new() {}
}

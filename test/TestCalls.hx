import utest.Assert;
import restx.App;
import restx.Router;
import js.node.Http;
import js.node.http.*;
import js.node.Querystring;

class TestCalls {
  static var port = 8888;
  public function new() {}

  var app : App;
  var router : Router;
  var server : js.node.http.Server;
  public function setup() {
    app = new App();
    router = app.router;
    server = app.http(port);
  }

  public function teardown() {
    server.close();
  }

  function request(path : String, method : Method, ?payload : {}, callback : String -> Void) {
    var done = Assert.createAsync(2000);
    var r = Http.request({
        host : "localhost",
        port : port,
        method : method,
        path : path
      }, function(msg : IncomingMessage) {
        var data = "";
        msg.on("data", function(chunk) {
          data += chunk;
        });
        msg.on("end", function() {
          callback(data);
          done();
        });
      });

    if (null != payload) {
      var b = Querystring.stringify(payload);
      r.setHeader('Content-Type', 'application/x-www-form-urlencoded');
      r.setHeader('Content-Length', '${b.length}');
      r.write(b);
    }
    r.end();
  }
}
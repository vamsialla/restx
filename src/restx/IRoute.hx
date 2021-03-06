package restx;

import express.Next;
import express.Request;
import express.Response;

@:autoBuild(restx.core.macros.BuildIRoute.complete())
interface IRoute {
  public var request : Request;
  public var response : Response;
  public var next : Next;
}
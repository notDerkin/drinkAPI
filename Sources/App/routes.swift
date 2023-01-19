import Vapor
import Foundation
import SwiftUI
import NIO

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }
    
    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("drinks") { req -> String in
        "Ciao!"
    }
    
    app.get("drinksJson") { req -> EventLoopFuture<Response> in
        guard let file = Bundle.module.url(forResource: "drinks", withExtension: "json")
        else {
            fatalError("Couldn't find the file")
        }
        let jsonData = try Data(contentsOf: file)
        let json = try JSONDecoder().decode([Drink].self, from: jsonData)
        let jsonString = String(data: try JSONEncoder().encode(json), encoding: .utf8)
        var buffer = ByteBuffer.init()
        buffer.writeString(jsonString ?? "")
        let response = Response(headers: HTTPHeaders(), body: .init(buffer: buffer))
        response.headers.contentType = .json
        return req.eventLoop.makeSucceededFuture(response)
    }
   
    
    // http://127.0.0.1:8080/drinksJson

}

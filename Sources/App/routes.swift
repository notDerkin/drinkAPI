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
    
    app.get("mostra-json") { req -> EventLoopFuture<Response> in
        // Add the json in /Users/[USERNAME]/Library/Developer/Xcode/DerivedData/drinkAPI-epmecbgmahbtrndsjzlnjhocxivl/Build/Products/Debug/Public/[JSON HERE]
        
        let filepath = app.directory.publicDirectory + "drinks.json"
        let newPath = FileManager.default.currentDirectoryPath + "/drinks.json"
        print(newPath)
        print("Sono qua: \(newPath)")
        guard FileManager.default.fileExists(atPath: newPath) else {
            throw Abort(.notFound)
        }
        let jsonData = try Data(contentsOf: URL(fileURLWithPath: filepath))
        let json = try JSONDecoder().decode([Drink].self, from: jsonData)
        let jsonString = String(data: try JSONEncoder().encode(json), encoding: .utf8)
        var buffer = ByteBuffer.init()
        buffer.writeString(jsonString ?? "")
        let response = Response(headers: HTTPHeaders(), body: .init(buffer: buffer))
        response.headers.contentType = .json
        return req.eventLoop.makeSucceededFuture(response)
    }
   
    
    // http://127.0.0.1:8080/mostra-json
//    app.get("mostra-json") { req -> EventLoopFuture<Response> in
//        let jsonData = try Data(contentsOf: URL(fileURLWithPath: "drinks.json"))
//        let json = try JSONDecoder().decode([Drink].self, from: jsonData)
//        let jsonString = String(data: try JSONEncoder().encode(json), encoding: .utf8)
//        var buffer = ByteBuffer.init()
//        buffer.writeString(jsonString ?? "")
//        let response = Response(headers: HTTPHeaders(), body: .init(buffer: buffer))
//        response.headers.contentType = .json
//        return req.eventLoop.makeSucceededFuture(response)
//    }
}

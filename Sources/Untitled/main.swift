import Foundation
import Kitura
import LoggerAPI
import HeliumLogger
import Application
import KituraOpenAPI
import Health
import KituraContracts

HeliumLogger.use(LoggerMessageType.info)

let router = Router()

router.post("/hello"){ request, response, _ in
    
}

router.get("/hello"){ request, response, next in
    
    let result = ["status":"ok", "message":"hello world"]
    response.send(json: ["result":result])
    try response.end()
    next()
}

router.get("/health") { (respondWith: (Status?, RequestError?) -> Void) -> Void in
    if health.status.state == .UP {
        respondWith(health.status, nil)
    } else {
        respondWith(nil, RequestError(.serviceUnavailable, body: health.status))
    }
}

KituraOpenAPI.addEndpoints(to: router)

Kitura.addHTTPServer(onPort: 8070, with: router)
Kitura.run()

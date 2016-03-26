//
//  request.swift
//  HotSearch
//
//  Created by tutujiaw on 16/3/26.
//  Copyright © 2016年 tujiaw. All rights reserved.
//

import Foundation

class Request {
    var appId: Int
    
    var timestamp: String {
        return NSDate.currentDate("yyyyMMddHHmmss")
    }
    
    var signMethod = "md5"
    
    var resGzip = 0
    
    var allParams = [(String, String)]()
    
    init(appId: Int) {
        self.appId = appId
    }
    
    func sign(appParams: [(String, String)], secret: String) -> String {
        self.allParams = appParams
        self.allParams.append(("showapi_appid", String(self.appId)))
        self.allParams.append(("showapi_timestamp", self.timestamp))
        
        let sortedParams = allParams.sort{$0.0 < $1.0}
        var str = ""
        for item in sortedParams {
            str += (item.0 + item.1)
        }
        str += secret.lowercaseString
        return str.md5()
    }
    
    func url(mainUrl: String, sign: String) -> String {
        var url = mainUrl + "?"
        for param in self.allParams {
            url += "\(param.0)=\(param.1)&"
        }
        url += "showapi_sign=\(sign)"
        return url
    }
}

class HotWordCategoryRequest: Request {
    init () {
        super.init(appId: 17262)
    }
    
    func url() -> String {
        let sign = self.sign([(String, String)](), secret: "21b693f98bd64e71a9bdbb5f7c76659c")
        return super.url("http://route.showapi.com/313-1", sign: sign)
    }
}

class HotWordRequest: Request {
    var typeId = 1
    
    init(typeId: Int) {
        super.init(appId: 17262)
        self.typeId = typeId
    }
    
    func url() -> String {
        let sign = self.sign([("typeId", "\(self.typeId)")], secret: "21b693f98bd64e71a9bdbb5f7c76659c")
        return super.url("http://route.showapi.com/313-2", sign: sign)
    }
}
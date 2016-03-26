//
//  response.swift
//  HotSearch
//
//  Created by tutujiaw on 16/3/26.
//  Copyright © 2016年 tujiaw. All rights reserved.
//

import Foundation
import SwiftyJSON

class Response {
    var showapi_res_code = -1
    var showapi_res_error = ""
}

struct CategoryChildItem {
    var id = 0
    var name = ""
}

struct CategoryItem {
    var name = ""
    var childList = [CategoryChildItem]()
}

class HotWordCategoryResponse: Response {
    var list = [CategoryItem]()
    
    func setData(data: AnyObject) {
        let json = JSON(data)
        super.showapi_res_code = json["showapi_res_code"].int ?? -1
        super.showapi_res_error = json["showapi_res_error"].string ?? ""
        if let list = json["showapi_res_body"]["list"].array {
            for item in list {
                var categoryItem = CategoryItem()
                guard let name = item["name"].string,
                    let childList = item["childList"].array else {
                        continue
                }
                categoryItem.name = name
                for child in childList {
                    guard let id = child["id"].string,
                        let name = child["name"].string else {
                            continue
                    }
                    categoryItem.childList.append(CategoryChildItem(id: Int(id)!, name: name))
                }
                self.list.append(categoryItem)
            }
        }
    }
}

struct HotWordInfo {
    var level = -1
    var name = ""
    var num = -1
    var trend = ""
}

class HotWordResponse: Response {
    var list = [HotWordInfo]()
    
    func setData(data: AnyObject) {
        let json = JSON(data)
        super.showapi_res_code = json["showapi_res_code"].int ?? -1
        super.showapi_res_error = json["showapi_res_error"].string ?? ""
        if let list = json["showapi_res_body"]["list"].array {
            for item in list {
                guard let name = item["name"].string else {
                    continue
                }
                
                var hotWordInfo = HotWordInfo()
                hotWordInfo.level = Int(item["level"].string ?? "-1") ?? -1
                hotWordInfo.name = name
                hotWordInfo.num = Int(item["num"].string ?? "-1") ?? -1
                hotWordInfo.trend = item["trend"].string ?? ""
                self.list.append(hotWordInfo)
            }
        }
    }
    
    func clear() {
        self.list.removeAll()
    }
}
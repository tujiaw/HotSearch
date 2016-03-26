//
//  dataManage.swift
//  HotSearch
//
//  Created by tutujiaw on 16/3/26.
//  Copyright © 2016年 tujiaw. All rights reserved.
//

import Foundation

class Data {
    static let sharedManage = Data()
    
    var hotWordCategory = HotWordCategoryResponse()
    var hotWord = HotWordResponse()
}
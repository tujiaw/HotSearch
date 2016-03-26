//
//  HotWordTableViewController.swift
//  HotSearch
//
//  Created by tutujiaw on 16/3/26.
//  Copyright © 2016年 tujiaw. All rights reserved.
//

import UIKit
import Alamofire

class HotWordTableViewController: UITableViewController {
    var name = ""
    var typeId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = name
        let request = HotWordRequest(typeId: self.typeId)
        Alamofire.request(.GET, request.url()).responseJSON { (response) -> Void in
            if response.result.isSuccess {
                if let value = response.result.value {
                    Data.sharedManage.hotWord.clear()
                    Data.sharedManage.hotWord.setData(value)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.sharedManage.hotWord.list.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CELL_ID = "HOT_WORD_CELL_ID"
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_ID, forIndexPath: indexPath)
        if indexPath.row < Data.sharedManage.hotWord.list.count {
            let item = Data.sharedManage.hotWord.list[indexPath.row]
            cell.textLabel?.text = item.name
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row < Data.sharedManage.hotWord.list.count {
            let keyword = Data.sharedManage.hotWord.list[indexPath.row].name
            if let newKeyword = keyword.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet()) {
                if let url = NSURL(string: "https://www.baidu.com/s?wd=\(newKeyword)") {
                    UIApplication.sharedApplication().openURL(url)
                }
            }

        }
    }
}
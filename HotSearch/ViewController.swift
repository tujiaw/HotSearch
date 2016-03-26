//
//  ViewController.swift
//  HotSearch
//
//  Created by tutujiaw on 16/3/25.
//  Copyright © 2016年 tujiaw. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "热搜分类"
        let request = HotWordCategoryRequest()
        Alamofire.request(.GET, request.url()).responseJSON { (response) -> Void in
            if response.result.isSuccess {
                if let value = response.result.value {
                    Data.sharedManage.hotWordCategory.setData(value)
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
        if section < Data.sharedManage.hotWordCategory.list.count {
            let item = Data.sharedManage.hotWordCategory.list[section]
            print("child list count:\(item.childList.count)")
            //
            return Data.sharedManage.hotWordCategory.list[section].childList.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CELL_ID = "HOT_WORD_CATEGORY_CELL_ID"
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_ID, forIndexPath: indexPath)
        if indexPath.section < Data.sharedManage.hotWordCategory.list.count {
            var item = Data.sharedManage.hotWordCategory.list[indexPath.section]
            if indexPath.row < item.childList.count {
                cell.textLabel?.text = item.childList[indexPath.row].name
            }
        }
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Data.sharedManage.hotWordCategory.list.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < Data.sharedManage.hotWordCategory.list.count {
            return Data.sharedManage.hotWordCategory.list[section].name
        }
        return ""
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("index:\(indexPath.row)")
        if indexPath.section < Data.sharedManage.hotWordCategory.list.count {
            let item = Data.sharedManage.hotWordCategory.list[indexPath.section]
            if indexPath.row < item.childList.count {
                print("\(item.childList[indexPath.row].name), \(item.childList[indexPath.row].id)")
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "HOT_WORD_SEGUE" {
            let target = segue.destinationViewController as? HotWordTableViewController
            let indexPath = tableView.indexPathForSelectedRow
            if indexPath?.section < Data.sharedManage.hotWordCategory.list.count {
                let item = Data.sharedManage.hotWordCategory.list[(indexPath?.section)!]
                if indexPath?.row < item.childList.count {
                    target?.name = item.childList[(indexPath?.row)!].name
                    target?.typeId = item.childList[(indexPath?.row)!].id
                }
            }
        }
//        if let tableViewController = segue.destinationViewController as? HotWordTableViewController {
//            let indexPath = tableView.indexPathForSelectedRow!
//            if indexPath.section < Data.sharedManage.hotWordCategory.list.count {
//                let item = Data.sharedManage.hotWordCategory.list[indexPath.section]
//                if indexPath.row < item.childList.count {
//                    tableViewController.name = item.childList[indexPath.row].name
//                    tableViewController.typeId = item.childList[indexPath.row].id
//                }
//            }
//        }
    }
    
}


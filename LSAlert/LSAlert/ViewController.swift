//
//  ViewController.swift
//  LSAlert
//
//  Created by John_LS on 2016/12/29.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func alertImg(_ sender: Any) {
        LSAlert().show(title: "这是一个有图片的弹窗", img: "1.jpg", cancelBtn: "", otherBtns: ["知道了"], action: nil)
    }

    @IBAction func alert(_ sender: Any) {
        LSAlert().show(title: "提示", subTitle: "这是一个自定义的alert", cancelBtn: "cancel", otherBtns: ["sure"]) { (btn) in
            print("按钮"+"\(btn.tag)"+"点击了")
        }
//        LSAlert().show(title: "提示", subTitle: "这是一个自定义的alert", cancelBtn: "cancel", otherBtns: ["sure"], action: nil)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


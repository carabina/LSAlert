//
//  LSAlertView.swift
//  LSAlert
//
//  Created by John_LS on 2016/12/31.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit
let screen_width:CGFloat = UIScreen.main.bounds.size.width  //屏幕宽度
let screen_height:CGFloat = UIScreen.main.bounds.size.height
class LSAlertView: UIView {
    let h_btn : CGFloat = 35.0//btn高度
    var h_text: CGFloat = screen_width/3.0//textviw默认高度
    var w_contentView: CGFloat = screen_width*2.0/3.0//主view宽度
    let h_title:CGFloat = 30.0//标题高度
    let top: CGFloat = 20.0 //距上端间距
    let left: CGFloat = 15.0 //距左边距
    let spacing : CGFloat = 10.0 //间距
    
    var lab_title: UILabel = UILabel()//标题
    var text_subTitle = UITextView()//副标题
    var buttons: [UIButton] = []
    
    /// 色值
    let color_cancel = UIColor(red: 52/255.0, green: 197/255.0, blue:
        170/255.0, alpha: 1.0)///取现按钮颜色
    let color_btn = UIColor(red: 170/255.0, green: 52/255.0, blue:
        52/255.0, alpha: 1.0)///其他按钮颜色
    let color_content = UIColor.colorFromRGB(0xFFFFFF)///主视图背景颜色
    let color_title = UIColor.colorFromRGB(0x575757)///主标题字体颜色
    let color_subTitle = UIColor.colorFromRGB(0x797979)///主标题字体颜色

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    /// Mark: - 初始化
    fileprivate func setupContentView() {
        backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
        layer.borderWidth = 0.5
        backgroundColor = color_content
        layer.borderColor = UIColor.colorFromRGB(0xCCCCCC).cgColor
        setupTitleLabel()
        setupSubtitleTextView()
    }
    fileprivate func setupTitleLabel() {
        lab_title.text = ""
        lab_title.numberOfLines = 1
        lab_title.textAlignment = .center
        lab_title.font = UIFont(name: "Helvetica", size:22)
        lab_title.textColor = color_title
    }
    
    fileprivate func setupSubtitleTextView() {
        text_subTitle.text = ""
        text_subTitle.textAlignment = .center
        text_subTitle.font = UIFont(name: "Helvetica", size:16)
        text_subTitle.textColor = color_subTitle
        text_subTitle.isEditable = false
    }
    
    
    //MARK: -布局
    func setLayout(title : String? , subTitle : String? , cancelBtn: String , otherBtns : [String] , target : Any? , action : Selector ) {
        setupContentView()
        self.lab_title.text = title
        if subTitle != nil  {
            self.text_subTitle.text = subTitle
        }
        buttons = []
        if cancelBtn.isEmpty == false {
            let button: UIButton = UIButton.init(type: .custom)
            button.setTitle(cancelBtn, for: UIControlState())
            button.backgroundColor = color_cancel
            button.isUserInteractionEnabled = true
            button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
            button.tag = 0
            button.layer.cornerRadius = 5.0
            buttons.append(button)
        }
        
        if otherBtns != nil && (otherBtns.count) > 0 {
            for i in 0..<otherBtns.count {
                let button: UIButton = UIButton.init(type: .custom)
                button.setTitle(otherBtns[i], for: UIControlState())
                button.backgroundColor = color_btn
                button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
                button.tag = i + 1
                button.layer.cornerRadius = 5.0
                buttons.append(button)
            }
        }

        
        
        
        let x: CGFloat = left
        var y: CGFloat = top
        let width: CGFloat = w_contentView - (left*2)
        
        // Title
        if self.lab_title.text?.isEmpty == false {
            lab_title.frame = CGRect(x: x, y: y, width: width, height: h_title)
            addSubview(lab_title)
            y += h_title + spacing
        }
        
        if self.text_subTitle.text.isEmpty == false {
            let subtitleString = self.text_subTitle.text! as NSString
            let rect = subtitleString.boundingRect(with: CGSize(width: width, height: 0.0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:self.text_subTitle.font!], context: nil)
            h_text = ceil(rect.size.height) + 10.0 > h_text ? h_text : ceil(rect.size.height) + 10.0
            text_subTitle.frame = CGRect(x: x, y: y, width: width, height: h_text)
            addSubview(text_subTitle)
            y += h_text + spacing
        }
        
        
        
        
        /// 根据btn的个数计算总宽度
        var h_totalBtn : CGFloat = 0.0 ///实际的按钮总高度
        
        if buttons.count > 2 {
            //两个btn以上
            for i in 1 ..< buttons.count {
                
                buttons[i].frame = CGRect(x: x, y: y, width: w_contentView - x*2, height: h_btn)
                addSubview(buttons[i])
                y += h_btn + spacing
                h_totalBtn += h_btn + spacing
            }
            
            buttons[0].frame = CGRect(x: x, y: y, width: w_contentView - x*2, height: h_btn)
            addSubview(buttons[0])
            y += h_btn + spacing
            h_totalBtn += h_btn + spacing
        }
        else if buttons.count == 1 || buttons.count == 2{
            //一个或者两个btn
            let count = buttons.count
            var buttonX = x
            let w_btn : CGFloat = (w_contentView - x*(CGFloat(count+1)))/(CGFloat(count)) //btn的宽度
            for i in 0 ..< buttons.count {
                
                buttons[i].frame = CGRect(x: buttonX, y: y, width:w_btn , height: h_btn)
                buttonX += x + w_btn
                addSubview(buttons[i])
                
            }
            h_totalBtn += spacing + h_btn
            y += h_btn + spacing
        }
        
        let h : CGFloat = y
        frame = CGRect(x: (screen_width - w_contentView) / 2.0, y: (screen_height - h) / 2.0, width: w_contentView, height: h)
        clipsToBounds = true
        
        
    }
}

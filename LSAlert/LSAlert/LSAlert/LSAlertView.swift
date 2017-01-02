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
    var h_btn : CGFloat = 35.0//btn高度
    var h_text: CGFloat = screen_width/3.0//textviw默认高度
    var w_contentView: CGFloat = screen_width*2.0/3.0//主view宽度
    var h_title:CGFloat = 30.0//标题高度
    var top: CGFloat = 20.0 //距上端间距
    var left: CGFloat = 15.0 //距左边距
    var spacing : CGFloat = 10.0 //间距
    
    
    
    
    var lab_title: UILabel = UILabel()//标题
    var text_subTitle = UITextView()//副标题
    var iv = UIImageView()//图片alert
    var buttons: [UIButton] = []
    
    /// 色值
    var color_cancel = UIColor(red: 52/255.0, green: 197/255.0, blue:
        170/255.0, alpha: 1.0)///取现按钮颜色
    var color_btn = UIColor(red: 170/255.0, green: 52/255.0, blue:
        52/255.0, alpha: 1.0)///其他按钮颜色
    var color_content = UIColor.colorFromRGB(0xFFFFFF)///主视图背景颜色
    var color_title = UIColor.colorFromRGB(0x575757)///主标题字体颜色
    var color_subTitle = UIColor.colorFromRGB(0x797979)///主标题字体颜色

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
        
    }
    fileprivate func setupTitleLabel() {
        lab_title.numberOfLines = 1
        lab_title.textAlignment = .center
        lab_title.font = UIFont(name: "Helvetica", size:22)
        lab_title.textColor = color_title
    }
    
    fileprivate func setupSubtitleTextView() {
        text_subTitle.textAlignment = .center
        text_subTitle.font = UIFont(name: "Helvetica", size:16)
        text_subTitle.textColor = color_subTitle
        text_subTitle.isEditable = false
    }
    
    
    
    /// 添加标题
    ///
    /// - Parameters:
    ///   - x: x
    ///   - y: y
    ///   - width: width
    /// - Returns: 更新y坐标
    fileprivate func setlayoutTitle(x:CGFloat , y: CGFloat , width : CGFloat) -> CGFloat{
        // Title
        if self.lab_title.text?.isEmpty == false {
            setupTitleLabel()
            lab_title.frame = CGRect(x: x, y: y, width: width, height: h_title)
            self.addSubview(lab_title)
            
            return y + h_title + spacing
        }
        return y
    }
    /// 添加副标题
    fileprivate func setlayoutSubtitle(x:CGFloat , y: CGFloat , width : CGFloat) -> CGFloat{
        if self.text_subTitle.text.isEmpty == false {
            setupSubtitleTextView()
            let subtitleString = self.text_subTitle.text! as NSString
            let rect = subtitleString.boundingRect(with: CGSize(width: width, height: 0.0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:self.text_subTitle.font!], context: nil)
            h_text = ceil(rect.size.height) + 10.0 > h_text ? h_text : ceil(rect.size.height) + 10.0
            text_subTitle.frame = CGRect(x: x, y: y, width: width, height: h_text)
            addSubview(text_subTitle)
            return y + h_text + spacing
            
        }
        return y
    }
    /// 添加图片
    fileprivate func setlayoutImg(x:CGFloat , y: CGFloat , width : CGFloat ) -> CGFloat{
        if iv.image != nil {
            iv.backgroundColor = UIColor.clear
            iv.contentMode = .scaleAspectFit
            let w_img : CGFloat = ((iv.image?.size.width)!>width ? width : (iv.image?.size.width)!)
            iv.frame = CGRect(x: x+(width-w_img)/2, y: y, width: w_img , height : w_img)
            addSubview(iv)
            return y + w_img + spacing
        }
        return y
    }
    /// 添加按钮
    fileprivate func setlayoutBtns(x:CGFloat , y: CGFloat , width : CGFloat , cancelBtn: String? , otherBtns : [String]? , target : Any? , action : Selector? , cancel : Selector?) -> CGFloat{
        buttons = []
        
        
        if otherBtns != nil && (otherBtns?.count)! > 0 {
            for i in 0..<(otherBtns?.count)! {
                let button: UIButton = UIButton.init(type: .custom)
                button.setTitle(otherBtns?[i], for: .normal)
                button.backgroundColor = color_btn
                button.addTarget(target, action: action!, for: .touchUpInside)
                button.tag = i + 1
                button.layer.cornerRadius = 5.0
                buttons.append(button)
            }
        }
        if cancelBtn?.isEmpty == false {
            let button: UIButton = UIButton.init(type: .custom)
            button.setTitle(cancelBtn, for: .normal)
            button.backgroundColor = color_cancel
            button.addTarget(target, action: cancel!, for: .touchUpInside)
            button.tag = 0
            button.layer.cornerRadius = 5.0
            buttons.append(button)
        }
        var yy = y
        if buttons.count > 2 {
            //两个btn以上
            for i in 0 ..< buttons.count {
                
                buttons[i].frame = CGRect(x: x, y: yy, width: width, height: h_btn)
                addSubview(buttons[i])
                yy += h_btn + spacing
            }
        }
        else if buttons.count == 1 || buttons.count == 2{
            //一个或者两个btn
            let count = buttons.count
            var buttonX = x
            let w_btn : CGFloat = (width + x*2 - x*(CGFloat(count+1)))/(CGFloat(count)) //btn的宽度
            for i in 0 ..< buttons.count {
                buttons[i].frame = CGRect(x: buttonX, y: yy, width:w_btn , height: h_btn)
                buttonX += x + w_btn
                addSubview(buttons[i])
                
            }
            yy += h_btn + spacing
        }
        return yy

    }
    
    //MARK: -布局
    func setLayout(title : String? , subTitle : String? , cancelBtn: String? , otherBtns : [String]? , target : Any? , action : Selector? , cancel : Selector?) {
        setupContentView()
        
        
        self.lab_title.text = title
        if subTitle != nil  {
            self.text_subTitle.text = subTitle
        }
        
        
        
        
        let x: CGFloat = left
        var y: CGFloat = top
        let width: CGFloat = w_contentView - (left*2)
        
        y = setlayoutTitle(x: x, y: y, width: width)
        y = setlayoutSubtitle(x: x, y: y, width: width)
        
        y = setlayoutBtns(x: x, y: y, width: width, cancelBtn: cancelBtn, otherBtns: otherBtns, target: target, action: action , cancel : cancel)
        
        
        frame = CGRect(x: (screen_width - w_contentView) / 2.0, y: (screen_height - y) / 2.0, width: w_contentView, height: y)
        clipsToBounds = true
        
        
    }
    /// 带有图片
    func setLayout(title : String? , img : String? , cancelBtn: String? , otherBtns : [String]? , target : Any? , action : Selector? , cancel : Selector?) {
        setupContentView()
        if title != nil  {
            self.text_subTitle.text = title
        }
        if img != nil {
            iv.image = UIImage.init(named: img!)
        }
        let x: CGFloat = left
        var y: CGFloat = top
        let width: CGFloat = w_contentView - (left*2)
        
        y = setlayoutImg(x: x, y: y, width: width)
        
        y = setlayoutSubtitle(x: x, y: y, width: width)
        
        y = setlayoutBtns(x: x, y: y, width: width, cancelBtn: cancelBtn, otherBtns: otherBtns, target: target, action: action , cancel : cancel)
        
        
        frame = CGRect(x: (screen_width - w_contentView) / 2.0, y: (screen_height - y) / 2.0, width: w_contentView, height: y )
        clipsToBounds = true
        
    }
    /// 带有图片没有按钮
    func setLayout(title : String? , img : String? ) {
        setupContentView()
        if title != nil  {
            self.text_subTitle.text = title
        }
        if img != nil {
            iv.image = UIImage.init(named: img!)
        }
        let x: CGFloat = left
        var y: CGFloat = top
        let width: CGFloat = w_contentView - (left*2)
        
        y = setlayoutImg(x: x, y: y, width: width)
        
        y = setlayoutSubtitle(x: x, y: y, width: width)
        
        frame = CGRect(x: (screen_width - w_contentView) / 2.0, y: (screen_height - y) / 2.0, width: w_contentView, height: y )
        clipsToBounds = true
        
    }

}

//
//  LSAlert.swift
//  LSAlert
//
//  Created by John_LS on 2016/12/29.
//  Copyright © 2016年 John_LS. All rights reserved.
//

import UIKit


// MARK: - 根据十六进制获取颜色
extension UIColor {
    class func colorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

let screen_width:CGFloat = UIScreen.main.bounds.size.width  //屏幕宽度
let screen_height:CGFloat = UIScreen.main.bounds.size.height

class LSAlert: UIViewController {
    
    let h_btn : CGFloat = 35.0//btn高度
    var h_text: CGFloat = screen_width/3.0//textviw默认高度
    var w_contentView: CGFloat = screen_width*2.0/3.0//主view宽度
    let h_title:CGFloat = 30.0//标题高度
    let top: CGFloat = 20.0 //距上端间距
    let left: CGFloat = 15.0 //距左边距
    let spacing : CGFloat = 10.0 //间距
    
    
    var v_content = UIView()//主view
    var lab_title: UILabel = UILabel()//标题
    var text_subTitle = UITextView()//副标题
    var buttons: [UIButton] = []
    var strongSelf:LSAlert?
    var userAction:((_ button: UIButton) -> Void)? = nil
    var btn_hidden : UIButton = UIButton.init(type: UIButtonType.custom)/// 隐藏按钮
    
    /// 色值
    let color_cancel = UIColor(red: 52/255.0, green: 197/255.0, blue:
        170/255.0, alpha: 1.0)///取现按钮颜色
    let color_btn = UIColor(red: 170/255.0, green: 52/255.0, blue:
        52/255.0, alpha: 1.0)///其他按钮颜色
    let color_content = UIColor.colorFromRGB(0xFFFFFF)///主视图背景颜色
    let color_title = UIColor.colorFromRGB(0x575757)///主标题字体颜色
    let color_subTitle = UIColor.colorFromRGB(0x797979)///主标题字体颜色
  
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.frame = UIScreen.main.bounds
        self.view.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        self.view.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0.7)
        
        //强引用 不然按钮点击不能执行
        strongSelf = self
        
        /// 隐藏按钮
        btn_hidden.frame = CGRect(x:0,y:0,width:screen_width,height:screen_height)
        btn_hidden.addTarget(self, action: #selector(doCancel(_:)), for: .touchUpInside)
        btn_hidden.backgroundColor = UIColor.clear
        self.view.addSubview(btn_hidden)
        self.view.addSubview(v_content)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
     */

    /// Mark: - 初始化
    fileprivate func setupContentView() {
        v_content.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        v_content.layer.cornerRadius = 5.0
        v_content.layer.masksToBounds = true
        v_content.layer.borderWidth = 0.5
        v_content.addSubview(lab_title)
        v_content.addSubview(text_subTitle)
        v_content.backgroundColor = color_content
        v_content.layer.borderColor = UIColor.colorFromRGB(0xCCCCCC).cgColor
        view.addSubview(v_content)
    }
    fileprivate func setupTitleLabel() {
        lab_title.text = ""
        lab_title.numberOfLines = 1
        lab_title.textAlignment = .center
        lab_title.font = UIFont(name: "Helvetica", size:25)
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
    fileprivate func setLayout() {
        let mainScreenBounds = UIScreen.main.bounds
        self.view.frame.size = mainScreenBounds.size
        let x: CGFloat = left
        var y: CGFloat = top
        let width: CGFloat = w_contentView - (left*2)
        
        // Title
        if self.lab_title.text != nil {
            lab_title.frame = CGRect(x: x, y: y, width: width, height: h_title)
            v_content.addSubview(lab_title)
            y += h_title + spacing
        }
        
        if self.text_subTitle.text.isEmpty == false {
            let subtitleString = self.text_subTitle.text! as NSString
            let rect = subtitleString.boundingRect(with: CGSize(width: width, height: 0.0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:self.text_subTitle.font!], context: nil)
            h_text = ceil(rect.size.height) + 10.0 > h_text ? h_text : ceil(rect.size.height) + 10.0
            text_subTitle.frame = CGRect(x: x, y: y, width: width, height: h_text)
            y += h_text + spacing
        }
        
        
        
        
        /// 根据btn的个数计算总宽度
        var h_totalBtn : CGFloat = 0.0 ///实际的按钮总高度
        
        if buttons.count > 2 {
            //两个btn以上
            for i in 1 ..< buttons.count {
                
                buttons[i].frame = CGRect(x: x, y: y, width: w_contentView - x*2, height: h_btn)
                self.v_content.addSubview(buttons[i])
                y += h_btn + spacing
                h_totalBtn += h_btn + spacing
            }
            
            buttons[0].frame = CGRect(x: x, y: y, width: w_contentView - x*2, height: h_btn)
            self.v_content.addSubview(buttons[0])
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
                self.v_content.addSubview(buttons[i])
                
            }
            h_totalBtn += spacing + h_btn
            y += h_btn + spacing
        }
        
        let h : CGFloat = y
        v_content.frame = CGRect(x: (screen_width - w_contentView) / 2.0, y: (screen_height - h) / 2.0, width: w_contentView, height: h)
        v_content.clipsToBounds = true
        
        //进入时的动画
        self.v_content.transform = CGAffineTransform(translationX: 0, y:-screen_height/2)
        v_content.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        let destTransform = CGAffineTransform(scaleX: 1, y: 1)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            self.v_content.transform = destTransform
        }, completion: nil)
    }
}
extension LSAlert{
    
    
    //MARK: -alert 方法主体
    func show(title : String? , subTitle : String? , cancelBtn: String , otherBtns : [String] , action : @escaping((_ otherBtn: UIButton) -> Void)) {
        userAction = action
        let window: UIWindow = UIApplication.shared.keyWindow!
        window.addSubview(view)
        window.bringSubview(toFront: view)
        view.frame = window.bounds
        setupContentView()
        setupTitleLabel()
        setupSubtitleTextView()
    
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
            button.addTarget(self, action: #selector(LSAlert.doCancel(_:)), for: UIControlEvents.touchUpInside)
            button.tag = 0
            button.layer.cornerRadius = 5.0
            buttons.append(button)
        }
    
        if otherBtns != nil && (otherBtns.count) > 0 {
            for i in 0..<otherBtns.count {
                let button: UIButton = UIButton.init(type: .custom)
                button.setTitle(otherBtns[i], for: UIControlState())
                button.backgroundColor = color_btn
                button.addTarget(self, action: #selector(clicked(_:)), for: UIControlEvents.touchUpInside)
                button.tag = i + 1
                button.layer.cornerRadius = 5.0
                buttons.append(button)
            }
        }
        setLayout()
    }
    
    
    //MARK: -取消
    func doCancel(_ sender:UIButton){
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            self.view.alpha = 0.0
            self.v_content.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (Bool) -> Void in
            self.view.removeFromSuperview()
            self.cleanUpAlert()
            self.strongSelf = nil
        }
    }
    
    fileprivate func cleanUpAlert() {
        self.v_content.removeFromSuperview()
        self.v_content = UIView()
    }
    
    
    
    /// 取消按钮外的按钮点击事件
    ///
    /// - Parameter sender: 点击的按钮
    func clicked(_ sender: UIButton!) {
        if userAction !=  nil {
            userAction!(sender)
        }
        doCancel(buttons[0])
    }
    
    
}

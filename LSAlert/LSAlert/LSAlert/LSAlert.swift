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



class LSAlert: UIViewController {
    
    
    
    
    var v_content : LSAlertView?//主view
    
    var strongSelf:LSAlert?
    var userAction:((_ button: UIButton) -> Void)? = nil
    var btn_hidden : UIButton = UIButton.init(type: UIButtonType.custom)/// 隐藏按钮
    
        
    
    
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
    
    
}
/// 按钮点击回调
typealias btnClickBlock = (_ otherBtn: UIButton) -> Void
extension LSAlert{
    
    
    //MARK: -alert 方法主体
    func show(title : String? , subTitle : String? , cancelBtn: String , otherBtns : [String] , action : btnClickBlock?) {
        userAction = action
        setupUI()
        v_content = LSAlertView()
        view.addSubview(v_content!)
        v_content?.setLayout(title: title, subTitle: subTitle, cancelBtn: cancelBtn, otherBtns: otherBtns, target: self, action: #selector(clicked(_:)))
        apper()
    }
    fileprivate func setupUI(){
        let window: UIWindow = UIApplication.shared.keyWindow!
        window.addSubview(view)
        window.bringSubview(toFront: view)
        view.frame = window.bounds
        
    }
    fileprivate func apper(){
        //进入时的动画
        self.v_content?.transform = CGAffineTransform(translationX: 0, y:-screen_height/2)
        v_content?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        let destTransform = CGAffineTransform(scaleX: 1, y: 1)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            self.v_content?.transform = destTransform
        }, completion: nil)
    }
    
    
    //MARK: -取消
    func doCancel(_ sender:UIButton){
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            self.view.alpha = 0.0
            self.v_content?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (Bool) -> Void in
            self.view.removeFromSuperview()
            self.cleanUpAlert()
            self.strongSelf = nil
        }
    }
    
    fileprivate func cleanUpAlert() {
        self.v_content?.removeFromSuperview()
        self.v_content = nil
    }
    
    
    
    /// 取消按钮外的按钮点击事件
    ///
    /// - Parameter sender: 点击的按钮
    func clicked(_ sender: UIButton!) {
        if userAction !=  nil {
            userAction!(sender)
        }
        doCancel(btn_hidden)
    }
    
    
}

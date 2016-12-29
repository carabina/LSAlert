# LSAlert
一个自定义的基于swift 3.0的alertview

用法很简单
只需要将 LSAlert.swift文件导入到自己的项目中，然后调用方法即可
```
LSAlert().show(title: "提示", subTitle: "这是一个自定义的alert", cancelBtn: "cancel", otherBtns: ["sure"]) { (btn) in
            print("按钮"+"\(btn.tag)"+"点击了")
        }
```
支持多按钮，需要注意的是，otherBtns如果为空时，需要传入参数空数组[]
eg:
```
LSAlert().show(title: "提示", subTitle: "这是一个自定义的alert", cancelBtn: "cancel", otherBtns: []) { (btn) in
            
        }
```
可以设置坐标尺寸等
```
let h_btn : CGFloat = 35.0//btn高度
    var h_text: CGFloat = screen_width/3.0//textviw默认高度
    var w_contentView: CGFloat = screen_width*2.0/3.0//主view宽度
    let h_title:CGFloat = 30.0//标题高度
    let top: CGFloat = 20.0 //距上端间距
    let left: CGFloat = 15.0 //距左边距
    let spacing : CGFloat = 10.0 //间距
```
可以设置色值
```
/// 色值
    let color_cancel = UIColor(red: 52/255.0, green: 197/255.0, blue:
        170/255.0, alpha: 1.0)///取现按钮颜色
    let color_btn = UIColor(red: 170/255.0, green: 52/255.0, blue:
        52/255.0, alpha: 1.0)///其他按钮颜色
    let color_content = UIColor.colorFromRGB(0xFFFFFF)///主视图背景颜色
    let color_title = UIColor.colorFromRGB(0x575757)///主标题字体颜色
    let color_subTitle = UIColor.colorFromRGB(0x797979)///主标题字体颜色
```

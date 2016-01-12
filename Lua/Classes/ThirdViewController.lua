waxClass{"ThirdViewController", UIViewController, protocols = {"UIAlertViewDelegate"}}

function viewDidLoad (self)
self:view():setBackgroundColor(UIColor:greenColor())
local path = NSBundle:mainBundle():pathForResource_ofType("Info","plist")
local dict = NSMutableDictionary:dictionaryWithContentsOfFile(path)
local CFBundleShortVersionString = dict["CFBundleShortVersionString"]
if CFBundleShortVersionString=="1.0" then
local alertView = UIAlertView:init()
alertView:setTitle("温馨提示")
alertView:setMessage("有新版本可用！")
alertView:addButtonWithTitle("确定")
alertView:setDelegate(self)
alertView:show()
end
end

function alertView_clickedButtonAtIndex(alertView,buttonAtIndex)
UIApplication:sharedApplication():openURL(NSURL:URLWithString("http://www.baidu.com"))
end


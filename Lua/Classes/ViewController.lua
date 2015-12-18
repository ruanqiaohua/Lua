waxClass{"ViewController", UIViewController, protocols = {"UITableViewDataSource", "UITableViewDelegate"}}

function viewDidLoad(self)

local button = UIButton:buttonWithType(1)
button:setFrame(CGRect(0,0,200,200))
button:setCenter(self:view():center())
button:setTitle_forState("按钮",UIControlStateNormal)
button:setTitleColor_forState(UIColor:blackColor(),UIControlStateNormal)
--button:addTarget_action_forControlEvents(self,"buttonDidClick",UIControlEventTouchUpInside)
self:view():addSubview(button)

end
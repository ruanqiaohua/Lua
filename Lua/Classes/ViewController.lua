waxClass{"ViewController", UIViewController, protocols = {"UITableViewDataSource", "UITableViewDelegate"}}

function viewDidLoad(self)
local background = UIImageView:initWithFrame(self:view():bounds())
background:setImage(UIImage:imageNamed("tiegui.jpg"))
self:view():addSubview(background)
end
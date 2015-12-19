require "DetailViewController"
waxClass{"ViewController", UIViewController}

function viewDidAppear(self)
print("viewDidAppear_animated")
local vc = DetailViewController:init()
vc:setTitle("Lua")
local nav = UINavigationController:initWithRootViewController(vc)
local tab = UITabBarController:init()
tab:setViewControllers({nav,nav,nav,nav})
self:presentViewController_animated_completion(tab, true, nil)
end
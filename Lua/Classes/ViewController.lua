require "FirstViewController"
require "SecondViewController"
require "ThirdViewController"
waxClass{"ViewController", UIViewController}

function viewDidAppear(self)
--firstVC
local firstVC = FirstViewController:init()
firstVC:setTitle("Lua")
local firstNav = UINavigationController:initWithRootViewController(firstVC)
--secondVC
local secondVC = SecondViewController:init()
secondVC:setTitle("Lua")
local secondNav = UINavigationController:initWithRootViewController(secondVC)
--thirdVC
local thirdVC = ThirdViewController:init()
thirdVC:setTitle("Lua")
local thirdNav = UINavigationController:initWithRootViewController(thirdVC)
--tab
local tab = UITabBarController:init()
tab:setViewControllers({firstNav,secondNav,thirdNav})
self:presentViewController_animated_completion(tab, true, nil)
end
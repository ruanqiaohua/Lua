require "FirstViewController"
require "SecondViewController"
require "ThirdViewController"
waxClass{"ViewController", UIViewController}

function viewDidAppear(self)
--firstVC
local firstVC = FirstViewController:init()
firstVC:setTitle("首页")
local firstNav = UINavigationController:initWithRootViewController(firstVC)
--secondVC
local secondVC = SecondViewController:init()
secondVC:setTitle("动态")
local secondNav = UINavigationController:initWithRootViewController(secondVC)
--thirdVC
local thirdVC = ThirdViewController:init()
thirdVC:setTitle("我")
local thirdNav = UINavigationController:initWithRootViewController(thirdVC)
--tab
local tab = UITabBarController:init()
tab:setViewControllers({firstNav,secondNav,thirdNav})
self:presentViewController_animated_completion(tab, true, nil)
end
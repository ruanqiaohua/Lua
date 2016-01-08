require "LiveRequestSongViewController"
waxClass{"LiveMainViewController", UIViewController}

function viewWillAppear(self)
    self.super:viewWillAppear(self)
    self:tabBarController():hidesBottomBarWhenPushed(true)
end

function viewDidAppear(self)
    self.super:viewDidAppear(self)
--btn
	local button = UIButton:buttonWithType(1)
    button:setFrame(CGRect(0,0,100,100))
    button:setBackgroundColor(UIColor:yellowColor())
	button:setTitle_forState("按钮",UIControlStateNormal)
	button:setTitleColor_forState(UIColor:blackColor(),UIControlStateNormal)
	button:addTarget_action_forControlEvents(self,"buttonDidClick",UIControlEventTouchUpInside)
	self:view():addSubview(button)
    print(button)
end

function buttonDidClick(self)
if self.liveRequestSongVC == nil then
self.liveRequestSongVC = LiveRequestSongViewController:init()
local songView = self.liveRequestSongVC:view()
local bounds = self:view():bounds()
local origin_Y = bounds.width * 3 / 4
songView:setFrame(CGRect(0,origin_Y,bounds.width,bounds.height-origin_Y-44))
self:view():addSubview(songView)
end
end
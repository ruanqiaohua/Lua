waxClass{"LiveRequestSongTabelViewCell", UITableViewCell}

function initWithStyle_reuseIdentifier(self,style,reuseIdentifier)
self.super:initWithStyle_reuseIdentifier(style,reuseIdentifier)
print(self)
if self then
    self:setSelectionStyle(UITableViewCellSelectionStyleNone)

    local bounds = UIScreen:mainScreen():bounds()

    self.songName = UILabel:init()
    self.songName:setFrame(CGRect(10,0,bounds.width-70-50-25-20,44))
    self.songName:setTextColor(UIColor:lightGrayColor())
    self:contentView():addSubview(self.songName)

    self.coinImg = UIImageView:init()
    self.coinImg:setFrame(CGRect(bounds.width-70-50-25,12,20,20))
    self.coinImg:setBackgroundColor(UIColor:greenColor())
    self:contentView():addSubview(self.coinImg)

	self.coin = UILabel:init()
    self.coin:setFrame(CGRect(bounds.width-70-50,0,50,44))
    self.coin:setTextColor(UIColor:lightGrayColor())
    self:contentView():addSubview(self.coin)

    self.chooseSong = UIButton:buttonWithType(1)
    self.chooseSong:setFrame(CGRect(bounds.width-60,7,50,30))
    self.chooseSong:layer():setCornerRadius(3)
    self.chooseSong:layer():setMasksToBounds(true)
    self.chooseSong:setBackgroundColor(UIColor:colorWithRed_green_blue_alpha(93.0/255,187.0/255.0,227.0/255.0,1))
	self.chooseSong:setTitle_forState("点节目",UIControlStateNormal)
	self.chooseSong:setTitleColor_forState(UIColor:whiteColor(),UIControlStateNormal)
	self.chooseSong:addTarget_action_forControlEvents(self,"chooseSongButtonDidClick",UIControlEventTouchUpInside)
	self:contentView():addSubview(self.chooseSong)
end

return self
end

function chooseSongButtonDidClick(self)
print("chooseSongButtonDidClick")
end
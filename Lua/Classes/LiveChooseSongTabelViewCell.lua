waxClass{"LiveChooseSongTabelViewCell", UITableViewCell}

function initWithStyle_reuseIdentifier(self,style,reuseIdentifier)
self.super:initWithStyle_reuseIdentifier(style,reuseIdentifier)
print(self)
if self then
    self:setSelectionStyle(UITableViewCellSelectionStyleNone)

    local bounds = UIScreen:mainScreen():bounds()

    self.songName = UILabel:init()
    self.songName:setFrame(CGRect(10,0,bounds.width-70-50-25-20,30))
    self.songName:setFont(UIFont:systemFontOfSize(15))
    self.songName:setTextColor(UIColor:lightGrayColor())
    self:contentView():addSubview(self.songName)

    self.nickname = UILabel:init()
    self.nickname:setFrame(CGRect(10,30,bounds.width-70-50-25-20,14))
    self.nickname:setFont(UIFont:systemFontOfSize(11))
    self.nickname:setTextColor(UIColor:lightGrayColor())
    self:contentView():addSubview(self.nickname)

	self.time = UILabel:init()
    self.time:setFrame(CGRect(self.nickname:bounds().width+20,30,50,14))
    self.time:setFont(UIFont:systemFontOfSize(11))
    self.time:setTextColor(UIColor:lightGrayColor())
    self:contentView():addSubview(self.time)

    self.songState = UILabel:init()
    self.songState:setFrame(CGRect(bounds.width-60,7,50,30))
    self.songState:setFont(UIFont:systemFontOfSize(15))
    self.songState:setTextColor(UIColor:lightGrayColor())
	self:contentView():addSubview(self.songState)
end

return self
end

function buttonDidClick(self)
print("buttonDidClick")
end
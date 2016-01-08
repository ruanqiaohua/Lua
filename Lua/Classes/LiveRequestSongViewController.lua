require "LiveRequestSongTabelViewCell"
require "LiveChooseSongTabelViewCell"
waxClass{"LiveRequestSongViewController", UIViewController, protocols = {"UITableViewDataSource", "UITableViewDelegate"}}

function viewDidLoad(self)

	self:view():setBackgroundColor(UIColor:clearColor())

	local bounds = self:view():bounds()
	local origin_Y = bounds.width * 3 / 4

	--选择节目单
	self.chooseView = UIView:init()
	self.chooseView:setFrame(CGRect(0,0,bounds.width,50))
	self.chooseView:setBackgroundColor(UIColor:whiteColor())
	self:view():addSubview(self.chooseView)

	self.programmeSegment = UISegmentedControl:initWithItems({"节目单","已点节目"})
	self.programmeSegment:setFrame(CGRect(10,5,200,40))
	self.programmeSegment:setCenter(self.chooseView:center())
	self.programmeSegment:setSelectedSegmentIndex(0)
	self.programmeSegment:setTintColor(UIColor:colorWithRed_green_blue_alpha(246.0/255,77.0/255.0,159.0/255.0,1))
	self.programmeSegment:addTarget_action_forControlEvents(self,"programmeSegmentValueChange",UIControlEventValueChanged)
	self.chooseView:addSubview(self.programmeSegment)

 	self.closeBtn = UIButton:buttonWithType(1)
    self.closeBtn:setFrame(CGRect(bounds.width-30,5,30,30))
	self.closeBtn:setTitle_forState("✖️",UIControlStateNormal)
	self.closeBtn:setTintColor(UIColor:blackColor())
	self.closeBtn:setTitleColor_forState(UIColor:blackColor(),UIControlStateNormal)
--	self.closeBtn:addTarget_action_forControlEvents(self,"closeBtnDidClick",UIControlEventTouchUpInside)
	self.chooseView:addSubview(self.closeBtn)

	self.chooseSongsTabeleView = UITableView:initWithFrame_style(CGRect(0,50,bounds.width,bounds.height-origin_Y-50-44), UITableViewStylePlain)
	self.chooseSongsTabeleView:setDelegate(self)
	self.chooseSongsTabeleView:setDataSource(self)
	self:view():addSubview(self.chooseSongsTabeleView)

	self.songsTabeleView = UITableView:initWithFrame_style(CGRect(0,50,bounds.width,bounds.height-origin_Y-50-44), UITableViewStylePlain)
	self.songsTabeleView:setDelegate(self)
	self.songsTabeleView:setDataSource(self)
	self:view():addSubview(self.songsTabeleView)

	self.inPutView = UIView:init()
	self.inPutView:setFrame(CGRect(0,self.songsTabeleView:bounds().height+50,bounds.width,44))
	self.inPutView:setBackgroundColor(UIColor:lightGrayColor())
	self:view():addSubview(self.inPutView)

	self.textField = UITextField:init()
	self.textField:setBackgroundColor(UIColor:whiteColor())
	self.textField:setFrame(CGRect(10,5,bounds.width-50-30,34))
	self.textField:setPlaceholder("自选节目5000聊币")
	self.inPutView:addSubview(self.textField)

  	self.chooseSongBtn = UIButton:buttonWithType(1)
    self.chooseSongBtn:setFrame(CGRect(bounds.width-60,7,50,30))
    self.chooseSongBtn:layer():setCornerRadius(6)
    self.chooseSongBtn:layer():setMasksToBounds(true)
    self.chooseSongBtn:setBackgroundColor(UIColor:colorWithRed_green_blue_alpha(246.0/255,77.0/255.0,159.0/255.0,1))
	self.chooseSongBtn:setTitle_forState("点节目",UIControlStateNormal)
	self.chooseSongBtn:setTitleColor_forState(UIColor:whiteColor(),UIControlStateNormal)
	self.chooseSongBtn:addTarget_action_forControlEvents(self,"chooseSongBtnDidClick",UIControlEventTouchUpInside)
	self.inPutView:addSubview(self.chooseSongBtn)

end

function programmeSegmentValueChange(self)
local index = self.programmeSegment:selectedSegmentIndex()
if index == 0 then
self:view():bringSubviewToFront(self.songsTabeleView)
else
self:view():bringSubviewToFront(self.chooseSongsTabeleView)
end
end

function chooseSongBtnDidClick(self)
	print("chooseSongBtnDidClick")
end

-- UITabelViewDatasource

function tableView_numberOfRowsInSection(self, tableView, section)
	if tableView == self.chooseSongsTabeleView then
		return 3
	end
	return 100
end

function tableView_cellForRowAtIndexPath(self, tableView, indexPath)
	if tableView == self.chooseSongsTabeleView then
		local identifier = "cellIdentifierAboutChooseSong"
		local cell = tableView:dequeueReusableCellWithIdentifier(identifier)
		if cell == nil then
	    cell = LiveChooseSongTabelViewCell:initWithStyle_reuseIdentifier(UITableViewCellStyleDefault, identifier)
		end
		cell.songName:setText("已选歌单")
		cell.nickname:setText("啦啦啦")
		cell.time:setText("刚刚")
		cell.songState:setText("已同意")
		return cell
	end
	local identifier = "cellIdentifierAboutSong"
	local cell = tableView:dequeueReusableCellWithIdentifier(identifier)
	if cell == nil then
	    cell = LiveRequestSongTabelViewCell:initWithStyle_reuseIdentifier(UITableViewCellStyleDefault, identifier)
	end
	cell.songName:setText("name")
	cell.coin:setText("5000")
	return cell
end

-- UITableViewDelegate

function tableView_didSelectRowAtIndexPath(self, tableView, indexPath)

end
require "LiveRequestSongTabelViewCell"
require "LiveChooseSongTabelViewCell"

waxClass{"LiveRequestSongViewController", UIViewController, protocols = {"UITableViewDataSource", "UITableViewDelegate","UITextFieldDelegate"}}

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
    self.chooseSongsTabeleView:setSeparatorStyle(UITableViewCellSeparatorStyleNone)
	self:view():addSubview(self.chooseSongsTabeleView)

	self.songsTabeleView = UITableView:initWithFrame_style(CGRect(0,50,bounds.width,bounds.height-origin_Y-50-44), UITableViewStylePlain)
	self.songsTabeleView:setDelegate(self)
	self.songsTabeleView:setDataSource(self)
    self.songsTabeleView:setSeparatorStyle(UITableViewCellSeparatorStyleNone)
	self:view():addSubview(self.songsTabeleView)

	self.inPutView = UIView:init()
	self.inPutView:setFrame(CGRect(0,self.songsTabeleView:bounds().height+50,bounds.width,44))
	self.inPutView:setBackgroundColor(UIColor:lightGrayColor())
	self:view():addSubview(self.inPutView)

	self.textField = UITextField:init()
	self.textField:setBackgroundColor(UIColor:whiteColor())
	self.textField:setFrame(CGRect(10,5,bounds.width-50-30,34))
    self.textField:setDelegate(self)
    self.textField:layer():setCornerRadius(3)
    self.textField:layer():setMasksToBounds(true)
    self.textField:setReturnKeyType(UIReturnKeyDone)
	self.textField:setPlaceholder("自选节目5000聊币")
	self.inPutView:addSubview(self.textField)

  	self.chooseSongBtn = UIButton:buttonWithType(1)
    self.chooseSongBtn:setFrame(CGRect(bounds.width-60,7,50,30))
    self.chooseSongBtn:layer():setCornerRadius(3)
    self.chooseSongBtn:layer():setMasksToBounds(true)
    self.chooseSongBtn:setBackgroundColor(UIColor:colorWithRed_green_blue_alpha(246.0/255,77.0/255.0,159.0/255.0,1))
	self.chooseSongBtn:setTitle_forState("点节目",UIControlStateNormal)
	self.chooseSongBtn:setTitleColor_forState(UIColor:whiteColor(),UIControlStateNormal)
	self.chooseSongBtn:addTarget_action_forControlEvents(self,"chooseSongBtnDidClick",UIControlEventTouchUpInside)
	self.inPutView:addSubview(self.chooseSongBtn)

    notificationCenter(self)
    requestSongsData(self)
    requestChooseSongsData(self)

end

--键盘的监听和处理

function notificationCenter(self)
    NSNotificationCenter:defaultCenter():addObserver_selector_name_object(self,"keyboardWillShow:","UIKeyboardWillShowNotification",nil)
    NSNotificationCenter:defaultCenter():addObserver_selector_name_object(self,"keyboardWillHide:","UIKeyboardWillHideNotification",nil)
end

function keyboardWillShow(self, note)
local userInfo = toobjc(note):userInfo()
local keyboardRect = userInfo["UIKeyboardFrameEndUserInfoKey"]
moveInputBarWithKeyboardHeight(self,keyboardRect["height"])
end

function keyboardWillHide(self, note)
moveInputBarWithKeyboardHeight(self,0)
end

function touchesBegan_withEvent(self,touches,event)
self:view():endEditing(true)
end

function moveInputBarWithKeyboardHeight(self,height)
    local bounds = self:view():bounds()
    if height == 0 then
        self.inPutView:setFrame(CGRect(0,bounds.height-88,bounds.width,44))
    else
        self.inPutView:setFrame(CGRect(0,bounds.height-88-height,bounds.width,44))
    end
end

function textFieldShouldReturn(self,textField)
    self:view():endEditing(true)
end

--请求歌曲列表

function requestSongsData(self)
url = "http://192.168.1.48/show/getShowList?PHPSESSID=d1dgbfbv07nvtcr27u6i57qf71"
local body = "uid=456"
wax.http.request{url,method = "post",callback = function(body, response)
    if response and response:statusCode()==200 then
        puts(body)
        self.songs = body["data"]
        puts(self.songs)
--模拟数据
        self.songs = {{id="61",showName="下雨天",showPrice="500"}}
        puts(self.songs)
        self.songsTabeleView:reloadData()
    end
end,body = body}
end

--请求已点歌曲列表

function requestChooseSongsData(self)
url = "http://192.168.1.48/show/getBuyShowList?PHPSESSID=d1dgbfbv07nvtcr27u6i57qf71"
local body = "uid=456"
wax.http.request{url,method = "post",callback = function(body, response)
if response and response:statusCode()==200 then
puts("requestChooseSongsData="..body)
self.chooseSongs = body["data"]
puts(self.chooseSongs)
--模拟数据
self.chooseSongs = {{id="10",buyUid="390",showName="1234",showPrice="5000",status="1",nickName="yh0021",createTime="7天前"}}
puts(self.chooseSongs)
self.chooseSongsTabeleView:reloadData()
end
end,body = body}
end

--点歌

function buyShow(self, showType, showName, showPrice)
url = "http://192.168.1.48/show/getBuyShowList?PHPSESSID=d1dgbfbv07nvtcr27u6i57qf71"
local body = string.format("uid=456&showType=%s&showName=%s&showPrice=%s",showType,showName,showPrice)
wax.http.request{url,method = "post",callback = function(body, response)
    if response and response:statusCode()==200 then
    puts(body)
    end
end,body = body}
end

function programmeSegmentValueChange(self)
local index = self.programmeSegment:selectedSegmentIndex()
if index == 0 then
self:view():sendSubviewToBack(self.chooseSongsTabeleView)
else
self:view():sendSubviewToBack(self.songsTabeleView)
end
end

function chooseSongBtnDidClick(self)
	print("chooseSongBtnDidClick")
end

-- UITabelViewDatasource

function tableView_numberOfRowsInSection(self, tableView, section)
	if tableView == self.chooseSongsTabeleView then
        if self.chooseSongs ~= nil then
            return #self.chooseSongs
        end
		return 0
	end
    if self.songs ~= nil then
        return #self.songs
    end
    return 0
end

function tableView_cellForRowAtIndexPath(self, tableView, indexPath)
	if tableView == self.chooseSongsTabeleView then
		local identifier = "cellIdentifierAboutChooseSong"
		local cell = tableView:dequeueReusableCellWithIdentifier(identifier)
		if cell == nil then
	    cell = LiveChooseSongTabelViewCell:initWithStyle_reuseIdentifier(UITableViewCellStyleDefault, identifier)
		end

        local object = self.chooseSongs[indexPath:row() + 1]
		cell.songName:setText(object["showName"])
		cell.nickname:setText(object["nickName"])
		cell.time:setText(object["createTime"])
        local status = object["status"]
        local stateText = backStatusString(status)
		cell.songState:setText(stateText)
        local stateTextColor = backStatusColor(status)
        cell.songState:setTextColor(stateTextColor)
		return cell
	end
	local identifier = "cellIdentifierAboutSong"
	local cell = tableView:dequeueReusableCellWithIdentifier(identifier)
	if cell == nil then
	    cell = LiveRequestSongTabelViewCell:initWithStyle_reuseIdentifier(UITableViewCellStyleDefault, identifier)
        cell.coinImg:setImage(UIImage:imageNamed("liaobi.png"))
	end

    local object = self.songs[indexPath:row() + 1]
	cell.songName:setText(object["showName"])
	cell.coin:setText(object["showPrice"])
	return cell
end

-- UITableViewDelegate

function tableView_didSelectRowAtIndexPath(self, tableView, indexPath)
self:view():endEditing(true)
end

function backStatusColor(status)
    if status == "0" then
    return UIColor:lightGrayColor()
    end
    if status == "1" then
    return UIColor:redColor()
    end
    if status == "2" then
    return UIColor:greenColor()
    end
    return UIColor:lightGrayColor()
end

function backStatusString(status)
    if status == "0" then
    return "已拒绝"
    end
    if status == "1" then
    return "未处理"
    end
    if status == "2" then
    return "已同意"
    end
    return ""
end
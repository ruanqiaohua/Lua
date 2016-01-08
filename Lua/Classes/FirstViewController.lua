require "LiveMainViewController"
waxClass{"FirstViewController", UIViewController, protocols = {"UITableViewDataSource", "UITableViewDelegate"}}

function viewDidLoad(self)

self.tableView = UITableView:initWithFrame_style(self:view():bounds(), UITableViewStylePlain)
self.tableView:setDelegate(self)
self.tableView:setDataSource(self)
self.tableView:registerClass_forCellReuseIdentifier(UITableViewCell:class(), "cellIdentifier")
self:view():addSubview(self.tableView)

end

-- UITabelViewDatasource

function tableView_numberOfRowsInSection(self, tableView, section)
return 100
end

function tableView_cellForRowAtIndexPath(self, tableView, indexPath)
local cell = tableView:dequeueReusableCellWithIdentifier("cellIdentifier")
cell:textLabel():setText(string.format("%d",indexPath:row()))
return cell
end

-- UITableViewDelegate

function tableView_didSelectRowAtIndexPath(self, tableView, indexPath)
--liveMainVC
local liveMainVC = LiveMainViewController:init()
liveMainVC:setHidesBottomBarWhenPushed(true)
self:navigationController():pushViewController_animated(liveMainVC, true)
end
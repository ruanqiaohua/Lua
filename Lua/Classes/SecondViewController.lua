waxClass{"SecondViewController", UIViewController, protocols = {"UICollectionViewDataSource","UICollectionViewDelegate","UICollectionViewDelegateFlowLayout"}}

function viewDidLoad(self)
self.collectionView = UICollectionView:initWithFrame_collectionViewLayout(self:view():bounds(),UICollectionViewFlowLayout:init())
self.collectionView:setDelegate(self)
self.collectionView:setDataSource(self)
self.collectionView:registerClass_forCellWithReuseIdentifier(UICollectionViewCell:class(),"cellIdentifier")
self:view():addSubview(self.collectionView)

end

function collectionView_numberOfItemsInSection(self, collectionView, section)
return 100
end

function collectionView_cellForItemAtIndexPath(self, collectionView, indexPath)
local cell = collectionView:dequeueReusableCellWithReuseIdentifier_forIndexPath("cellIdentifier", indexPath)
cell:setBackgroundColor(UIColor:yellowColor())

return cell
end
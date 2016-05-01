bucketlist = FactoryGirl.create(:bucketlist)

FactoryGirl.create_list(:item, 5, bucketlist_id: bucketlist.id)

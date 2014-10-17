import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    var tweets:[Tweet]?
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelScreenname: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelFollowing: UILabel!
    @IBOutlet weak var labelFollowers: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let id = User.currentUser!.id!  as NSNumber
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        println ("table count is \(tweets?.count ??  0)")
        return tweets?.count ??  0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ListTweetTableViewCell") as ListTweetTableViewCell
        var tweet = tweets![indexPath.row]
        cell.tweet = tweet
        return cell
    }
    @IBAction func onCancel(sender: AnyObject) {
        self.popoverPresentationController  
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.TwitterColors()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(UINib(nibName: "ListTweetTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "ListTweetTableViewCell")
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        var params: NSDictionary = ["user_id": id]
        TwitterClient.sharedInstance.getUserTimeLineCompletionWithParams(params) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }
    }
      override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.labelName.text = User.currentUser?.name!
        self.labelScreenname.text = "@\(User.currentUser!.screenName!)"
        self.labelFollowers.text = "\(User.currentUser!.followers_count!)"
        self.labelFollowing.text = "\(User.currentUser!.friends_count!)"
        self.labelLocation.text = User.currentUser!.location!
        self.imgProfile.setImageWithURL(NSURL(string:User.currentUser!.profileImageURL!))
        var params: NSDictionary = ["user_id": id]
        TwitterClient.sharedInstance.getUserTimeLineCompletionWithParams(params) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }
    }
    func refresh( refreshControl : UIRefreshControl)
    {
        var params: NSDictionary = ["user_id": id]
        refreshControl.beginRefreshing()
        TwitterClient.sharedInstance.getUserTimeLineCompletionWithParams(params) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }
        refreshControl.endRefreshing()
    }
}

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tweets:[Tweet]?
    var timeLine:Int?;
    var params = ["count":20 ]
      //0: home timeline , 1: mentions
    @IBOutlet weak var tableView: UITableView!
    @IBAction func onLogout(sender: UIBarButtonItem) {
        User.currentUser?.logout()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // println ("count is \(self.tweets?.count ?? 0)")
        return self.tweets?.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //println ("cell is row number at \(indexPath.row)")
        var cell = tableView.dequeueReusableCellWithIdentifier("tweetListCell") as TweetsListTableViewCell
        var tweet = tweets?[indexPath.row]
        cell.tweet = tweet
        if indexPath.row == tweets!.count - 2  {
            //println("load more tweets")
            loadMore(tweet!.id!)
        }
        return cell
    }
    func loadMore(id: NSNumber){
        params = ["max_id":id]
        if timeLine != nil{
            self.title = "Mentions"
            TwitterClient.sharedInstance.getMentionsCompletionWithParams(params, completion: { (tweets, error) -> () in
                self.tweets = tweets
                self.tableView.reloadData()
            })
        } else {
            self.title = "Home"
            TwitterClient.sharedInstance.homeTimelineCompletionWithParams(params, completion: { (tweets, error) -> () in
                self.tweets = tweets
                self.tableView.reloadData()
            })
        }    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let controller = storyboard.instantiateViewControllerWithIdentifier("singleTweetVC") as SingleTweetViewController
        controller.tweet = self.tweets![indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true )
        if timeLine != nil {
            TwitterClient.sharedInstance.getMentionsCompletionWithParams(params, completion: { (tweets, error) -> () in
                self.tweets = tweets
                self.tableView.reloadData()
            })
            
        } else {
            TwitterClient.sharedInstance.homeTimelineCompletionWithParams(params, completion: { (tweets, error) -> () in
                self.tweets = tweets
                self.tableView.reloadData()
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.TwitterColors()
        println ("which time line here: \(timeLine)")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        if timeLine != nil{
            self.title = "Mentions"
            TwitterClient.sharedInstance.getMentionsCompletionWithParams(params, completion: { (tweets, error) -> () in
                self.tweets = tweets
                 self.tableView.reloadData()
            })
        } else {
            self.title = "Home"
            TwitterClient.sharedInstance.homeTimelineCompletionWithParams(params, completion: { (tweets, error) -> () in
                    self.tweets = tweets
                  self.tableView.reloadData()
                })
        }
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }
    func refresh( refreshControl : UIRefreshControl)
    {
        refreshControl.beginRefreshing()
        if timeLine != nil{
            self.title = "Mentions"
            TwitterClient.sharedInstance.getMentionsCompletionWithParams(params, completion: { (tweets, error) -> () in
                self.tweets = tweets
                self.tableView.reloadData()
            })
        } else {
            self.title = "Home"
            TwitterClient.sharedInstance.homeTimelineCompletionWithParams(params, completion: { (tweets, error) -> () in
                self.tweets = tweets
                self.tableView.reloadData()
            })
        }
        refreshControl.endRefreshing()
    }
}

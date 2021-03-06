import UIKit

class NewTweetViewController: UIViewController, UITextViewDelegate {
    var tweet:Tweet?
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelScreenName: UILabel!
    @IBOutlet weak var labelText: UITextView!
    @IBOutlet weak var labelNumberOfText: UILabel!
    var isReply:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.TwitterColors()
        labelText.delegate = self
        labelName.backgroundColor = UIColor.whiteColor()
        labelScreenName.backgroundColor = UIColor.whiteColor()
        labelText.textAlignment = NSTextAlignment.Justified
        let url = User.currentUser?.profileImageURL
        self.imageProfile.setImageWithURL(NSURL(string: url!))
        labelName.text = User.currentUser?.name
        labelScreenName.text = User.currentUser?.screenName
        if isReply == true {
            labelText.text = "@\(User.currentUser!.name!)"
        } else {
        }
    }
    @IBAction func onTweet(sender: UIButton) {
       var params  = ["status": labelText.text]
        if isReply == true {
            params["in_reply_to_status_id"] = tweet?.idStr!
        }
        TwitterClient.sharedInstance.postNewTweetCompletionWithParams(params) { (tweet, error) -> () in
            if error != nil {
                println("error on post new tweet")
            } else {
                println("new tweet posted")
                self.dismissViewControllerAnimated(true , completion: nil)
            }
        }
    }
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true , completion: nil)
    }
//    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
//        return true
//    }
    func textViewDidChange(textView: UITextView){
        var count = textView.text as NSString
        //println("trigged here, count is \(count.length)")
        self.labelNumberOfText.text = "\(140 - count.length )"
    }
    func textViewDidEndEditing(textView: UITextView) {
        self.labelText.resignFirstResponder()
    }
}

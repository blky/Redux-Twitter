import UIKit

class ListTweetTableViewCell: UITableViewCell {

    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelScreenName: UILabel!
    @IBOutlet weak var labelTimeAgo: UILabel!
    @IBOutlet weak var buttonReply: UIImageView!
    @IBOutlet weak var buttonRetweet: UIImageView!
    @IBOutlet weak var buttonFavorite: UIImageView!
    
    var user:User?
    var tweet:Tweet? {
        willSet (newValue){
            self.labelName.text = newValue?.user?.name
            self.labelScreenName.text = "@\(newValue!.user!.screenName!)"
            self.labelText.text = newValue?.text
           // println(self.labelText.text)
            
            let imgURL = newValue?.user?.profileImageURL
            //self.imgProfile.setImageWithURL( NSURL(string:imgURL!) )
            self.labelTimeAgo.text = newValue?.createAt!.timeAgo()!
            if newValue?.favorited == 1 {
                self.buttonFavorite.image = UIImage(named: "favorite_on.png")
            } else {
                self.buttonFavorite.image = UIImage(named: "favorite.png")
            }
            if newValue?.retweeted == 1 {
                self.buttonRetweet.image = UIImage(named: "retweet_on.png")
            } else {
                self.buttonRetweet.image = UIImage(named: "retweet.png")
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

import UIKit

class SigninViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.TwitterColors()
    }
    @IBAction func onSignIn(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion { (user, error) -> () in
            if user != nil {
                //perform tasks
                self.performSegueWithIdentifier("toLogin", sender: self)
            } else {
                //handle error
                println("logoin error")
            }
        }
    }
}

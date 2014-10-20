import UIKit

class ContrainerViewController: UIViewController, TimeLineVCDelegate {
    
    var NVC: UINavigationController!
    var centeredVC:UIViewController!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    @IBAction func goProfile(sender: UIButton) {
        menuProfile ()
    }
    @IBAction func goTimeline(sender: UIButton) {
        menuTimeLine()
    }
    @IBAction func menuMentions(sender: AnyObject) {
        if centeredVC != nil {
            removeViewControllerFromScrollView(centeredVC)
        }
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
         NVC = storyboard.instantiateViewControllerWithIdentifier("TweetsNavigationViewController1") as UINavigationController
        if  NVC.childViewControllers[0].isKindOfClass(TweetsViewController){
            let VC = NVC.childViewControllers[0] as TweetsViewController
            VC.timeLine = 1 //1: mentions timeline, nil for home timeline
        }
        addViewControllertoScrollView(NVC, scrollView: scrollView)
    }
    func menuTimeLine (){
        if centeredVC != nil {
            removeViewControllerFromScrollView(centeredVC)
        }
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        //show default view controller timeline
        NVC = storyboard.instantiateViewControllerWithIdentifier("TweetsNavigationViewController1") as UINavigationController
        addViewControllertoScrollView(NVC, scrollView: scrollView)
        
        //add delegate for sidemenu bar if hometimeline
        if centeredVC.isKindOfClass(TimelineNavigationController) {
            if centeredVC.childViewControllers[0].isKindOfClass(TweetsViewController ) {
                let vc = centeredVC.childViewControllers[0] as TweetsViewController
                vc.delegate = self
            }
        }
    }
    func menuProfile (){
        if centeredVC != nil {
            removeViewControllerFromScrollView(centeredVC)
        }
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        //show default view controller timeline
        NVC = storyboard.instantiateViewControllerWithIdentifier("ProfileNavigationController") as UINavigationController
        addViewControllertoScrollView(NVC, scrollView: scrollView)
    }
    // managing view controller's events
    func addViewControllertoScrollView (centerViewController:UIViewController, scrollView:UIView) {
         addChildViewController(centerViewController)
        centerViewController.view.frame = scrollView.frame
        centerViewController.view.frame.origin = CGPoint(x:self.view.frame.width / 2 , y: 30)
        scrollView.addSubview(centerViewController.view)
        centerViewController.didMoveToParentViewController(self)
        centeredVC = centerViewController
        //reveal menu
         self.scrollView.setContentOffset(CGPoint(x: NVC.view.frame.origin.x, y: -10.0), animated: true )
//        self.scrollView.setContentOffset(CGPoint(x: NVC.view.frame.origin.x, y: NVC.view.frame.origin.y - 30), animated: true )

    }
    func removeViewControllerFromScrollView (centerViewController: UIViewController){
        centerViewController.willMoveToParentViewController(nil)
        centerViewController.view.removeFromSuperview()
        centerViewController.removeFromParentViewController()
    }
    var sideMenuVC:TweetsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.autoresizesSubviews = true
    }
    // MARK : delegate from tweetsviewcontroller
    func willRevealMenu (){
        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: -5.0), animated: true )
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //default load home timelin
        menuTimeLine()
        scrollView.contentSize = CGSize(width:view.frame.width * 1.5 , height:  view.frame.size.height - 10)
    }
    
    override func viewWillLayoutSubviews() {
        println("\n[ ]>>>>>> \(__FILE__.pathComponents.last!) >> \(__FUNCTION__) < \(__LINE__) >")
        var viewFrame = self.view.frame
        viewFrame.origin.y += 20
        self.view.frame = viewFrame
    }
}

import UIKit
class TimelineNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        println("\n[ ]>>>>>> \(__FILE__.pathComponents.last!) >> \(__FUNCTION__) < \(__LINE__) >")
        //self.navigationBar.translucent = false ;
//        
//        self.navigationBar.frame = CGRectMake(self.navigationBar.frame.origin.x, 100, self.navigationBar.frame.size.width, 64);
        
     }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

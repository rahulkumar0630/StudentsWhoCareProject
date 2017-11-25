import UIKit

extension UIViewController {
    func hideNavigationBar(){
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func hideToolBar(){
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    func showToolBar()
    {
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    func showNavigationBar() {
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}

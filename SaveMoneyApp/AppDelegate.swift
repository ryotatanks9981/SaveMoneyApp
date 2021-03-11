import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        UINavigationBar.appearance().barTintColor = .themeColor
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = false
        
        let pageVC = PageViewController()
        let navVC = UINavigationController(rootViewController: pageVC)
        window?.rootViewController = navVC
        
        window?.makeKeyAndVisible()
        
        return true
    }

}


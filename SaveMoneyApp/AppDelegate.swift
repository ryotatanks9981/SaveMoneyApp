import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupNavigationBar()
        
        requestLocalPushNotification()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = generateNavVC()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func requestLocalPushNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, _) in
            if granted {
                UNUserNotificationCenter.current().delegate = self
            }
        }
    }
    
    private func setupNavigationBar() {
        UINavigationBar.appearance().barTintColor = .themeColor
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = false
    }
    
    private func generateNavVC() -> UINavigationController {
        let pageVC = PageViewController()
        let navVC = UINavigationController(rootViewController: pageVC)
        return navVC
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        let content = UNMutableNotificationContent()
        content.title = "今日の貯金をしましょう"
        content.body = "財布に小銭はありますか？"
        content.sound = UNNotificationSound.default
        
        var notificationTime = DateComponents()
        notificationTime.hour = 13
        notificationTime.minute = 11
        let trigger: UNNotificationTrigger
        trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: false)
        
        let req = UNNotificationRequest(identifier: "immediately", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound, .alert])
    }
}

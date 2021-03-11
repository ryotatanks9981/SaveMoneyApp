import UIKit

extension UIColor {
    static let themeColor = rgb(200, 255, 200)
    
    static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ alpha: CGFloat = 1) -> UIColor{
        .init(red: r/255, green: g/255, blue: b/255, alpha: alpha)
    }
}

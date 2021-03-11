import UIKit

extension UILabel {
    static func generateLabel(title: String = "", fontSize: CGFloat, alignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: fontSize)
        label.textAlignment = alignment
        return label
    }
}

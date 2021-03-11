import UIKit

class FloatingButton: UIButton {
    
    init(title: String, backColor: UIColor) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 40)
        backgroundColor = backColor
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

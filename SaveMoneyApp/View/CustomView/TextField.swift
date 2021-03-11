import UIKit

class TextField: UITextField {
    
    init(placeholder: String, keyboardType: UIKeyboardType = .numberPad) {
        super.init(frame: .zero)
        
        self.text = text
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        
        textAlignment = .right
        
        font = .systemFont(ofSize: 25)
        
        leftView = UIView(frame: .init(x: 0, y: 0, width: 5, height: 0))
        leftViewMode = .always
        
        rightView = UIView(frame: .init(x: 0, y: 0, width: 5, height: 0))
        rightViewMode = .always
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


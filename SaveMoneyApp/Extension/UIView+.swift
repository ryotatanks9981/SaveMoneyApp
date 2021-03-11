import UIKit

extension UIView {
    func addSubViews(views: [UIView]) {
        views.forEach({ addSubview($0) })
    }
    
    static func borderView() -> UIView {
        let view = UIView(frame: .init(x: 0, y: 0, width: 0, height: 0.4))
        view.backgroundColor = .black
        return view
    }
}

extension UIView {
    public var top: CGFloat {
        frame.origin.y
    }
    public var bottom: CGFloat {
        frame.origin.y + frame.size.height
    }
    public var left: CGFloat {
        frame.origin.x
    }
    public var right: CGFloat {
        frame.origin.x + frame.size.width
    }
    public var width: CGFloat {
        frame.size.width
    }
    public var height: CGFloat {
        frame.size.height
    }
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                leading: NSLayoutXAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                centerY: NSLayoutYAxisAnchor? = nil,
                centerX: NSLayoutXAxisAnchor? = nil,
                width: CGFloat? = nil,
                height: CGFloat? = nil,
                topPadding: CGFloat = 0,
                bottomPadding: CGFloat = 0,
                leadingPadding: CGFloat = 0,
                trailingPadding: CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomPadding).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: leadingPadding).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -trailingPadding).isActive = true
        }
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}


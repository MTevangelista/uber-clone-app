import UIKit

extension UIStackView {
    
    func addArrangedSubviews(children: [UIView]) {
        children.forEach { item in
            self.addArrangedSubview(item)
        }
    }
}

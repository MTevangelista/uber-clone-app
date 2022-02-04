import UIKit

extension UITextField {
    
    func setRightImageViewButton(_ button: UIButton) {
        self.rightViewMode = .always
        self.rightView = button
    }
    
    func setPasswordToggleImage(_ button: UIButton) {
        let visiblePasswordImage = UIImage(named: R.image.eye.name)
        let invisiblePasswordImage = UIImage(named: R.image.eyeSlash.name)
        
        isSecureTextEntry
            ? button.setImage(visiblePasswordImage, for: .normal)
            : button.setImage(invisiblePasswordImage, for: .normal)
    }
}

import UIKit

protocol SignUpViewModelProtocol {
    func handleSignUp()
    func navigateTo(navigationController: UINavigationController)
    func handleSelectSegmentControl()
}

final class SignUpViewModel {
    
    init() {}
}

extension SignUpViewModel: SignUpViewModelProtocol {
    func handleSignUp() {
        
    }
    
    func navigateTo(navigationController: UINavigationController) {
        navigationController.popViewController(animated: true)
    }
    
    func handleSelectSegmentControl() {
        
    }
}

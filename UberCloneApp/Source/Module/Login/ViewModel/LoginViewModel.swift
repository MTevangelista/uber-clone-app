import UIKit

protocol LoginViewModelProtocol {
    func handleSignIn()
    func navigateTo(navigationController: UINavigationController)
}

final class LoginViewModel {
    
    init() {}
}

extension LoginViewModel: LoginViewModelProtocol {
    func handleSignIn() {
        
    }
    
    func navigateTo(navigationController: UINavigationController) {
        let controller = SignUpViewController(viewModel: SignUpViewModel())
        navigationController.pushViewController(controller, animated: true)
    }
    
}

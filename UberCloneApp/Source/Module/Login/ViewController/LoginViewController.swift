import UIKit

class LoginViewController: UIViewController {
    
    private lazy var loginVew = LoginView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func loadView() {
        view = loginVew
        self.loginVew.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension LoginViewController: LoginViewDelegate {
    
    func didSelectLoginButton() {
        print("the action  was called")
    }
}

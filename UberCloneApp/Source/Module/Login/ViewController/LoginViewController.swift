import UIKit

final class LoginViewController: UIViewController {
    
    private lazy var loginVew = LoginView()
    
    private var viewModel: LoginViewModel
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = loginVew
        self.loginVew.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
}

extension LoginViewController: AuthenticationViewDelegate {
    
    func didSelectSignUpButton() {
        let controller = SignUpViewController(viewModel: SignUpViewModel())
        navigationController?.pushViewController(controller, animated: true)
    }

    func didSelectLoginButton() {
        viewModel.handleSignIn()
    }
    
    func didSelectSegmentControl() {
        //
    }
    
}

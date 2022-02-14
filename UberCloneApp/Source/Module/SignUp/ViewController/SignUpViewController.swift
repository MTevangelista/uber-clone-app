import UIKit

final class SignUpViewController: UIViewController {
    
    private lazy var signUpView = SignUpView()
    
    private let viewModel: SignUpViewModelProtocol
    
    init(viewModel: SignUpViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = signUpView
        signUpView.delegate = self
    }
}

extension SignUpViewController: AuthenticationViewDelegate {
    func didSelectSignUpButton() {
        viewModel.handleSignUp()
    }
    
    func didSelectLoginButton() {
        guard let navigationController = navigationController else { return }
        viewModel.navigateTo(navigationController: navigationController)
    }
    
    func didSelectSegmentControl() {
        viewModel.handleSelectSegmentControl()
    }
}

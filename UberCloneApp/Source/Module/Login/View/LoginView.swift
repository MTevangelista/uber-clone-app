import SnapKit

final class LoginView: UIView {
    
    weak var delegate: AuthenticationViewDelegate?
    
    private lazy var formStateView: FormStateView = {
        let primaryAction: CallToAction = .init(title: R.string.localizable.signIn(), action: didSelectLoginButton)
        let secondaryLeftActionTitle = R.string.localizable.dontHaveAccount()
        let secondaryAction: CallToAction = .init(title: R.string.localizable.signUp(), action: didSelectSignUpButton)
        let viewData = FormStateViewData(type: .signIn,
                                         primaryAction: primaryAction,
                                         secondaryLeftActionTitle: secondaryLeftActionTitle,
                                         secondaryAction: secondaryAction)
        let view = FormStateView(viewData: viewData)
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func didSelectLoginButton() {
        delegate?.didSelectLoginButton()
    }
    
    private func didSelectSignUpButton() {
        delegate?.didSelectSignUpButton()
    }
}

extension LoginView: CodeViewProtocol {
    
    func buildHierarchy() {
        addSubview(formStateView)
    }
    
    func setupConstraints() {
        formStateView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

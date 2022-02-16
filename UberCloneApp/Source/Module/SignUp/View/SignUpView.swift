import SnapKit

final class SignUpView: UIView {
    
    weak var delegate: AuthenticationViewDelegate?
    
    private lazy var formStateView: FormStateView = {
        let primaryAction: CallToAction = .init(title: R.string.localizable.signUp(), action: didSelectSignUpButton)
        let segmentedControlAction: CallToAction = .init(action: didSelectSegmentControl)
        let secondaryLeftActionTitle: String = R.string.localizable.alreadyHaveAccount()
        let secondaryAction: CallToAction = .init(title: R.string.localizable.signIn(), action: didSelectLoginButton)
        let viewData: FormStateViewData = .init(type: .signUp,
                                                primaryAction: primaryAction,
                                                segmentedControlAction: segmentedControlAction,
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
    
    func didSelectSegmentControl() {
        delegate?.didSelectSegmentControl()
    }
}

extension SignUpView: CodeViewProtocol {
    
    func buildHierarchy() {
        addSubview(formStateView)
    }
    
    func setupConstraints() {
        formStateView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

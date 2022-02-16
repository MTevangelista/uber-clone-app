import SnapKit

final class FormStateView: UIView {
    
    private let viewData: FormStateViewData
    private let iconSize: CGFloat = 24
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.loginLogoTitle()
        label.textColor = UIColor(white: 1, alpha: 0.8)
        label.font = UIFont(name: R.string.localizable.loginLogoFontName(), size: 36)
        return label
    }()
    
    private lazy var formStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 21
        return stackView
    }()
    
    private lazy var emailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var envelopeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: R.image.envelope.name)
        imageView.contentMode = .left
        imageView.tintColor = .white
        imageView.alpha = 0.87
        return imageView
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = R.string.localizable.email()
        textField.textContentType = .emailAddress
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.keyboardAppearance = .dark
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var fullNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.isHidden = verifyIfViewTypeIsEqualToSignUp()
        return stackView
    }()
    
    private lazy var personImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: R.image.person.name)
        imageView.contentMode = .left
        imageView.tintColor = .white
        imageView.alpha = 0.87
        imageView.isHidden = verifyIfViewTypeIsEqualToSignUp()
        return imageView
    }()
    
    private lazy var fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = R.string.localizable.fullName()
        textField.textContentType = .name
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.keyboardAppearance = .dark
        textField.autocorrectionType = .no
        textField.isHidden = verifyIfViewTypeIsEqualToSignUp()
        return textField
    }()
    
    private lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var passwordToggleButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(UIImage(named: R.image.eye.name), for: .normal)
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        return button
    }()
    
    private lazy var lockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .left
        imageView.tintColor = .white
        imageView.alpha = 0.87
        imageView.image = UIImage(named: R.image.lock.name)
        return imageView
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = R.string.localizable.password()
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.keyboardAppearance = .dark
        textField.isSecureTextEntry = true
        textField.textContentType = .password
        textField.setRightImageViewButton(passwordToggleButton)
        return textField
    }()
    
    private lazy var accountTypeSegmentedControl: UISegmentedControl = {
        let segmentItems = [R.string.localizable.rider(), R.string.localizable.driver()]
        let control = UISegmentedControl(items: segmentItems)
        control.tintColor = UIColor(white: 1, alpha: 0.87)
        control.selectedSegmentIndex = 0
        control.isHidden = verifyIfViewTypeIsEqualToSignUp()
        control.addTarget(self, action: #selector(didSelectSegmentControl), for: .valueChanged)
        return control
    }()
    
    private lazy var primaryButton: ButtonView = {
        let button = ButtonView(callToAction: viewData.primaryAction)
        return button
    }()
    
    private lazy var secondaryButton: UIButton = {
        let button = UIButton(type: .system)
        let leftTextAttributes = setAttributesForSecondaryButton(font: .systemFont(ofSize: 16), color: .lightGray)
        let rightTextAttributes = setAttributesForSecondaryButton(font: .boldSystemFont(ofSize: 16), color: .systemBlue)
        let leftText = setTextForSecondaryButton()
        let attributedTitle = NSMutableAttributedString(string: viewData.secondaryLeftActionTitle, attributes: leftTextAttributes)
        
        attributedTitle.append(NSAttributedString(string: viewData.secondaryAction.title, attributes: rightTextAttributes))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(didSelectSecondaryButton), for: .touchUpInside)
        return button
    }()
    
    init(viewData: FormStateViewData) {
        self.viewData = viewData
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func verifyIfViewTypeIsEqualToSignUp() -> Bool {
        viewData.type == .signUp ? false : true
    }
    
    private func setAttributesForSecondaryButton(font: UIFont, color: UIColor) -> [NSAttributedString.Key : NSObject] {
        [.font: font, .foregroundColor: color]
    }
    
    private func setTextForSecondaryButton() -> String {
        let viewType = viewData.type
        var response: String = ""
        
        switch viewType {
        case .signIn:
            response = R.string.localizable.dontHaveAccount()
        case .signUp:
            response = R.string.localizable.alreadyHaveAccount()
        }
        return response
    }
}

@objc
extension FormStateView {
    
    private func togglePasswordView() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        passwordTextField.setPasswordToggleImage(passwordToggleButton)
    }
    
    private func didSelectSecondaryButton() {
        viewData.secondaryAction.action()
    }
    
    private func didSelectSegmentControl(_ segmentedControl: UISegmentedControl) {
        guard let segmentedControlAction = viewData.segmentedControlAction else { return }
        segmentedControlAction.action()
    }
}

extension FormStateView: CodeViewProtocol {
    
    func buildHierarchy() {
        addSubview(titleLabel)
        addSubview(formStackView)
        addSubview(secondaryButton)
        
        emailStackView.addArrangedSubviews(children: [envelopeImageView, emailTextField])
        fullNameStackView.addArrangedSubviews(children: [personImageView, fullNameTextField])
        passwordStackView.addArrangedSubviews(children: [lockImageView, passwordTextField])
        formStackView.addArrangedSubviews(children: [emailStackView, fullNameStackView, passwordStackView, accountTypeSegmentedControl, primaryButton])
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
        
        formStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.leading.equalTo(envelopeImageView).offset(iconSize + 8)
        }
        
        fullNameTextField.snp.makeConstraints { make in
            make.leading.equalTo(personImageView).offset(iconSize + 8)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.equalTo(lockImageView).offset(iconSize + 8)
        }
        
        primaryButton.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        secondaryButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func applyAdditionalChanges() {
        backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        emailTextField.addOutline(anchorView: formStackView, position: .below)
        fullNameTextField.addOutline(anchorView: formStackView, position: .below)
        passwordTextField.addOutline(anchorView: formStackView, position: .below)
    }
}

private extension UITextField {
    
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

private extension UIView {
    
    func addOutline(anchorView: UIView, position: SperatorPosition) {
        let separatorView = UIView()
        
        self.addSubview(separatorView)
        separatorView.backgroundColor = .lightGray
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(0.75)
            switch position {
            case .above:
                make.bottom.equalTo(self.snp.top).inset(8)
            case .below:
                make.top.equalTo(self.snp.bottom).offset(8)
            }
            make.leading.trailing.equalTo(anchorView)
        }
    }
}

import SnapKit

final class SignUpView: UIView {
    
    private let iconSize: CGFloat = 24
    
    weak var delegate: AuthenticationViewDelegate?
    
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
        return stackView
    }()
    
    private lazy var personImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: R.image.person.name)
        imageView.contentMode = .left
        imageView.tintColor = .white
        imageView.alpha = 0.87
        return imageView
    }()
    
    private lazy var fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = R.string.localizable.fullName()
        textField.textContentType = .name
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.keyboardAppearance = .dark
        textField.autocorrectionType = .no
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
        let segmentItems = ["Rider", "Driver"]
        let control = UISegmentedControl(items: segmentItems)
        control.tintColor = UIColor(white: 1, alpha: 0.87)
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(didSelectSegmentControl), for: .valueChanged)
        return control
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.signUp(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didSelectSignUpButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let alreadyHaveAccountTextAttributes: [NSAttributedString.Key : NSObject] = setAttributes(font: .systemFont(ofSize: 16),
                                                                                               color: .lightGray)
        
        let attributedTitle = NSMutableAttributedString(string: R.string.localizable.alreadyHaveAccount(),
                                                        attributes: alreadyHaveAccountTextAttributes)
        
        let signUpTextAttributes: [NSAttributedString.Key : NSObject] = setAttributes(font: .boldSystemFont(ofSize: 16),
                                                                                      color: .systemBlue)
        
        attributedTitle.append(NSAttributedString(string: R.string.localizable.signIn(), attributes: signUpTextAttributes))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(didSelectLoginButton), for: .touchUpInside)
        return button
    }()
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAttributes(
        font: UIFont,
        color: UIColor
    ) -> [NSAttributedString.Key : NSObject] {
        [.font: font, .foregroundColor: color]
    }
    
    @objc
    private func togglePasswordView() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        passwordTextField.setPasswordToggleImage(passwordToggleButton)
    }
    
    @objc
    private func didSelectLoginButton() {
        delegate?.didSelectLoginButton()
    }
    
    @objc
    private func didSelectSignUpButton() {
        delegate?.didSelectSignUpButton()
    }
    
    @objc
    func didSelectSegmentControl(_ segmentedControl: UISegmentedControl) {
        delegate?.didSelectSegmentControl()
    }
}

extension SignUpView: CodeViewProtocol {
    
    func buildHierarchy() {
        addSubview(titleLabel)
        addSubview(formStackView)
        addSubview(alreadyHaveAccountButton)
        
        emailStackView.addArrangedSubviews(children: [envelopeImageView, emailTextField])
        fullNameStackView.addArrangedSubviews(children: [personImageView, fullNameTextField])
        passwordStackView.addArrangedSubviews(children: [lockImageView, passwordTextField])
        formStackView.addArrangedSubviews(children: [emailStackView, fullNameStackView, passwordStackView,
                                                     accountTypeSegmentedControl ,signUpButton])
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
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(35)
        }
        
        alreadyHaveAccountButton.snp.makeConstraints { make in
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

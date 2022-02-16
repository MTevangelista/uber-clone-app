import UIKit

public final class ButtonView: UIView {
    
    var callToAction: CallToAction
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(callToAction.title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(touchUpInsideSelector), for: .touchUpInside)
        return button
    }()
    
    init(callToAction: CallToAction) {
        self.callToAction = callToAction
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func touchUpInsideSelector(_ sender: UIButton) {
        callToAction.action()
    }
}

extension ButtonView: CodeViewProtocol {
    func buildHierarchy() {
        addSubview(button)
    }
    
    func setupConstraints() {
        button.snp.makeConstraints { make in
            make.height.equalTo(35)
            make.width.equalToSuperview()
        }
    }
}

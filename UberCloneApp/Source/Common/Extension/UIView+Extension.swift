import SnapKit

extension UIView {
    
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

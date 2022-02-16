protocol AuthenticationViewDelegate: AnyObject {
    func didSelectSignUpButton()
    func didSelectLoginButton()
    func didSelectSegmentControl()
}

extension AuthenticationViewDelegate {
    
    func didSelectSegmentControl() {}
}

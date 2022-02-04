protocol CodeViewProtocol {
    func buildHierarchy()
    func setupConstraints()
    func applyAdditionalChanges()
}

extension CodeViewProtocol {

    func setupView() {
        buildHierarchy()
        setupConstraints()
        applyAdditionalChanges()
    }

    func applyAdditionalChanges() {}
}

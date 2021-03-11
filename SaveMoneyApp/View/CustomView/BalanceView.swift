import UIKit
import RxSwift

class BalanceView: UIView {
    
    private let reloadButton: UIButton = {
        let button = UIButton()
        return button
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "総額"
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 40)
        label.textAlignment = .right
        return label
    }()
    private let yenLabel: UILabel = {
        let label = UILabel()
        label.text = "円"
        label.font = .systemFont(ofSize: 40)
        return label
    }()
    
    private var viewModel: BalanceViewPresen
    private var realmManager: RealmProtocol
    
    private let disposeBag = DisposeBag()
    
    init(realmManager: RealmProtocol) {
        self.realmManager = realmManager
        viewModel = BalanceViewModel(input: (), realmMNG: self.realmManager)
        
        super.init(frame: .zero)
        
        setupViews()
        binding()
    }
    
    func reload() {
        viewModel.output.balanceValue
            .drive(totalLabel.rx.text)
            .disposed(by: disposeBag)
        
        totalLabel.layoutIfNeeded()
    }
    
    private func binding() {
        viewModel.output.balanceValue
            .drive(totalLabel.rx.text)
            .disposed(by: disposeBag)
        
        totalLabel.layoutIfNeeded()
    }
    
    private func setupViews() {
        let horizontalStackView = UIStackView(arrangedSubviews: [totalLabel, yenLabel])
        horizontalStackView.axis = .horizontal
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, horizontalStackView])
        stackView.axis = .vertical
        addSubview(stackView)
        
        stackView.anchor(top: topAnchor,bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        yenLabel.anchor(width: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

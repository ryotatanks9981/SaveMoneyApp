import UIKit
import RxSwift

class BalanceView: UIView {
    
    private let reloadButton: UIButton = {
        let button = UIButton()
        return button
    }()
    private let titleLabel: UILabel = .generateLabel(title: "総額", fontSize: 30)
    private let totalLabel: UILabel = .generateLabel(title: "0", fontSize: 40, alignment: .right)
    private let yenLabel: UILabel = .generateLabel(title: "円", fontSize: 40)
    
    private var viewModel: BalanceViewPresen
    private var realmManager: RealmProtocol
    
    private let disposeBag = DisposeBag()
    
    init(realmManager: RealmProtocol) {
        self.realmManager = realmManager
        viewModel = BalanceViewModel(input: (), realmMNG: self.realmManager)
        
        super.init(frame: .zero)
        
        setupViews()
        reload()
    }
    
    func reload() {
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

import UIKit
import RxSwift
import RxCocoa

class AddLogViewController: UIViewController {
    
    private var stackView: UIStackView!
    private var segmentControl: UISegmentedControl!
    private let valueField = TextField(placeholder: "金額を入力")
    private let borderView = UIView.borderView()
    private let floatingButton = FloatingButton(title: "$", backColor: .systemRed)
    private let dismissButton = UIBarButtonItem(title: "×", style: .plain, target: nil, action: nil)
    
    private var viewModel: AddLogViewModel!
    private let bag = DisposeBag()
    private var realmManager: RealmProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        
        let segmentControlIndex = segmentControl.rx.value
        
        realmManager = RealmManger()
        viewModel = AddLogViewModel(input: (logType: segmentControlIndex.asDriver(),
                                            valueText: valueField.rx.text.orEmpty.asDriver(),
                                            insertButton: floatingButton.rx.tap.asDriver()),
                                    realmManager: realmManager)
        
        bind(viewModel: viewModel)
    }
    
    private func bind(viewModel: AddLogViewModel) {
        viewModel.output.isValid
            .drive(floatingButton.rx.isEnabled)
            .disposed(by: bag)
        
        viewModel.output.isValid.drive(onNext: { [floatingButton] isValid in
            floatingButton.backgroundColor = isValid ? .systemPink : .init(white: 0.3, alpha: 0.5)
        }).disposed(by: bag)
        
        viewModel.tapEventSubject.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: bag)
        
        dismissButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: bag)
    }
    
    private func setupViews() {
        segmentControl = UISegmentedControl(items: ["貯金する", "貯金を崩す"])
        let fieldStack = UIStackView(arrangedSubviews: [valueField, borderView])
        fieldStack.axis = .vertical
        fieldStack.distribution = .fill
        stackView = UIStackView(arrangedSubviews: [segmentControl, fieldStack])
        stackView.axis = .vertical
        stackView.spacing = 30
        
        dismissButton.tintColor = .black
        dismissButton.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 30)], for: .normal)
        navigationItem.leftBarButtonItem = dismissButton
        
        segmentControl.selectedSegmentIndex = 0
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Optima-Italic", size: 18)!], for: .normal)
        
        let size = view.width / 12
        floatingButton.layer.cornerRadius = size
        
        view.backgroundColor = .themeColor
        view.addSubViews(views: [stackView, floatingButton])

    }
    private func setupLayout() {
        let size = view.width / 6

        stackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor,
                         topPadding: 80, leadingPadding: 40, trailingPadding: 40)
        segmentControl.anchor(height: 35)
        valueField.anchor(height: 45)
        borderView.anchor(height: 1)
        floatingButton.anchor(top: stackView.bottomAnchor, trailing: stackView.trailingAnchor, width: size, height: size, topPadding: 30)
    }
}

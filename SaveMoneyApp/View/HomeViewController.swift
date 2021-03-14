import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import RealmSwift

class HomeViewController: UIViewController {
    
    private let realmManager = RealmManger.shared
    
    private lazy var balanceView = BalanceView(realmManager: realmManager)
    private let logView = UITableView()
    private let floatingButton = FloatingButton(title: "+", backColor: .systemPink)
    
    private let dataSources = RxTableViewSectionedReloadDataSource<LogItemsSection> { (_, tableView, indexPath, item) -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(withIdentifier: LogCell.id, for: indexPath) as! LogCell
        cell.configure(usingViewModel: item)
        return cell
    }
    
    private var viewModel: LogsViewPresent!
    
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel = LogsViewModel(input: (), realmManager: realmManager)
        setupViews()
        setupLayout()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        balanceView.reload()
        logView.reloadData()
    }
    
    private func binding() {
        viewModel.output.logs
            .drive(logView.rx.items(dataSource: self.dataSources))
            .disposed(by: disposeBag)
      
        floatingButton.rx.tap.subscribe(onNext: { [weak self] in
            let addLogVC = AddLogViewController()
            let navVC = UINavigationController(rootViewController: addLogVC)
            navVC.modalPresentationStyle = .fullScreen
            self?.present(navVC, animated: true)
        }).disposed(by: disposeBag)
    }
    
    private func setupViews() {
        view.backgroundColor = .themeColor
        logView.backgroundColor = .clear
        logView.separatorStyle = .none
        logView.register(LogCell.self, forCellReuseIdentifier: LogCell.id)
        floatingButton.layer.cornerRadius = view.width / 12
        floatingButton.layer.masksToBounds = true
        
        view.addSubViews(views: [balanceView, logView, floatingButton])
    }
    
    private func setupLayout() {
        let size = view.width / 6
        
        balanceView.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor,
                           topPadding: 30, leadingPadding: 30, trailingPadding: 30)
        logView.anchor(top: balanceView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor
                       , topPadding: 30, bottomPadding: 150, leadingPadding: 30, trailingPadding: 30)
        floatingButton.anchor(bottom: logView.bottomAnchor, trailing: logView.trailingAnchor,
                              width: size, height: size, bottomPadding: 10)
        
    }
}

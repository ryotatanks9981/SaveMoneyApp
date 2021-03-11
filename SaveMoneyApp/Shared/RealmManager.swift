import Foundation
import RealmSwift
import RxSwift

protocol RealmProtocol {
    func fetchLogs() -> Single<[LogModel]>
    func insertLog(value: Int, logType: Int, completion: @escaping () -> Void)
    func fetchBalance() -> Single<Int>
}

class RealmManger {
    static let shared = RealmManger()
    
    private let realm = try! Realm()
}

extension RealmManger: RealmProtocol {
    func fetchLogs() -> Single<[LogModel]> {
        Single.create { [weak self] (single) -> Disposable in
            guard let logs = self?.realm.objects(LogModel.self) else {
                single(.failure(CustomError.error(massage: "")))
                return Disposables.create()
            }
            let mappedLogs = logs.map({ LogModel(value: $0) }).sorted(by: { $0.date > $1.date }) as [LogModel]
            single(.success(mappedLogs))
            return Disposables.create()
        }
    }
    
    func insertLog(value: Int, logType: Int, completion: @escaping () -> Void) {
        let logModel = LogModel()
        logModel.money = value
        logModel.logType = logType
        logModel.date = Date()
        
        try! realm.write {
            realm.add(logModel)
            completion()
        }
    }
    
    func fetchBalance() -> Single<Int> {
        Single.create { [weak self] (single) -> Disposable in
            guard let logs = self?.realm.objects(LogModel.self) else {
                single(.failure(CustomError.error(massage: "")))
                return Disposables.create()
            }
            let deposit = logs.filter({ $0.logType == 0 }).reduce(0) { $0 + $1.money  }
            let payment = logs.filter({ $0.logType == 1 }).reduce(0) { $0 + $1.money  }
            
            let totalMoney = deposit - payment
            single(.success(totalMoney))
            return Disposables.create()
        }
    }
    
    
}
//$0 + $1.logType == 0 ? $1.money : -$1.money

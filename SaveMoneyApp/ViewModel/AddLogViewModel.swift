import Foundation
import RxSwift
import RxCocoa

protocol AddLogViewPresent {
    typealias Input = (
        logType: Driver<Int>,
        valueText: Driver<String>,
        insertButton: Driver<()>
    )
    typealias Output = (
        isValid: Driver<Bool>, ()
    )
    
    var input: AddLogViewPresent.Input { get }
    var output: AddLogViewPresent.Output { get }
}

class AddLogViewModel: AddLogViewPresent {
    var input: AddLogViewPresent.Input
    var output: AddLogViewPresent.Output
    
    private let bag = DisposeBag()
    
    private let logTypeRely = BehaviorRelay<Int>(value: 0)
    private let valueRelay = BehaviorRelay<Int>(value: 0)
    
    public var tapEventSubject = PublishSubject<()>()
    
    private var realmManager: RealmProtocol
    
    init(input: AddLogViewPresent.Input, realmManager: RealmProtocol) {
        self.input = input
        self.output = AddLogViewModel.output(input: self.input)
        self.realmManager = realmManager
        
        process()
    }
}

private extension AddLogViewModel {
    static func output(input: AddLogViewPresent.Input) -> AddLogViewPresent.Output {
        let isValid = input.valueText.map({ !$0.isEmpty })
        return (
            isValid: isValid, ()
        )
    }
    
    func process() {
        
        input.valueText.map({ Int($0) ?? 0 }).drive(valueRelay).disposed(by: bag)
        input.logType.drive(logTypeRely).disposed(by: bag)
        
        input.insertButton.drive(onNext: { [unowned self] in
            let value = self.valueRelay.value
            let logType = self.logTypeRely.value
            self.realmManager.insertLog(value: value, logType: logType) { [tapEventSubject] in
                
                print(self.realmManager.fetchLogs())
                tapEventSubject.onNext(())
            }
        }).disposed(by: bag)
    }
}

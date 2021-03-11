import RxSwift
import RxCocoa
import RxDataSources

typealias LogItemsSection = SectionModel<Int, LogViewPresent>


protocol LogsViewPresent {
    typealias Input = ()
    typealias Output = (
        logs: Driver<[LogItemsSection]>, ()
    )
    
    var input: LogsViewPresent.Input { get }
    var output: LogsViewPresent.Output { get }
}

class LogsViewModel: LogsViewPresent {
    var input: LogsViewPresent.Input
    var output: LogsViewPresent.Output
    
    private var realmManager: RealmProtocol
    
    init(input: LogsViewPresent.Input, realmManager: RealmProtocol) {
        self.input = input
        self.realmManager = realmManager
        self.output = LogsViewModel.output(realmManager: realmManager)
    }
}

private extension LogsViewModel {
    static func output(realmManager: RealmProtocol) -> LogsViewPresent.Output{
        let logs = realmManager.fetchLogs()
            .map({ $0.compactMap({ LogViewModel(usingModel: $0)}) })
            .map({ [LogItemsSection(model: 0, items: $0)] })
            .asDriver(onErrorJustReturn: [])
        
        return (
            logs: logs, ()
        )
    }
}

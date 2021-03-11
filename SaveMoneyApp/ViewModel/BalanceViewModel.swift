import RxSwift
import RxCocoa

protocol BalanceViewPresen {
    typealias Input = ()
    typealias Output = (
        balanceValue: Driver<String>, ()
    )
    
    var input: BalanceViewPresen.Input { get }
    var output: BalanceViewPresen.Output { get }
}

class BalanceViewModel: BalanceViewPresen {
    var input: BalanceViewPresen.Input
    var output: BalanceViewPresen.Output
    
    private var realmMNG: RealmProtocol
    
    init(input: BalanceViewPresen.Input, realmMNG: RealmProtocol) {
        self.input = input
        self.realmMNG = realmMNG
        self.output = BalanceViewModel.output(realmMNG: realmMNG)
    }
}

extension BalanceViewModel {
    static func output(realmMNG: RealmProtocol) -> BalanceViewPresen.Output{
        let balanceValue = realmMNG.fetchBalance().map({ String($0) }).asDriver(onErrorJustReturn: "0")
        return (
            balanceValue: balanceValue, ()
        )
    }
}

import Foundation

protocol LogViewPresent {
    var logType: Int { get }
    var money: Int { get }
    var date: String { get }
}

class LogViewModel: LogViewPresent {
    var logType: Int
    var money: Int
    var date: String
    
    init(usingModel model: LogModel) {
        logType = model.logType
        money = model.money
        date = LogViewModel.formatter(date: model.date)
    }
}

extension LogViewModel {
    static func formatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ja_JP")
        return dateFormatter.string(from: date)
    }
}

import RealmSwift

class LogModel: Object {
    @objc dynamic var money: Int = 0
    @objc dynamic var logType: Int = 0
    @objc dynamic var date: Date = Date()
}

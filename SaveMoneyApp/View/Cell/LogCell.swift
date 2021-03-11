import UIKit

class LogCell: UITableViewCell {
    
    static let id = "LogCell"
    
    private let logTypeLabel: UILabel = .generateLabel(fontSize: 25)
    private let logLabel: UILabel = .generateLabel(fontSize: 25, alignment: .right)
    private let yenLabel: UILabel = .generateLabel(title: "円", fontSize: 25)
    private let dateLabel: UILabel = .generateLabel(fontSize: 20, alignment: .right)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        let horizontalStackView = UIStackView(arrangedSubviews: [logTypeLabel, logLabel, yenLabel])
        horizontalStackView.axis = .horizontal
        
        let stackView = UIStackView(arrangedSubviews: [horizontalStackView, dateLabel])
        stackView.axis = .vertical
        
        addSubview(stackView)
        
        stackView.anchor(top: topAnchor,bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, topPadding: 5, bottomPadding: 5, leadingPadding: 5, trailingPadding: 5)
        stackView.backgroundColor = .init(white: 1, alpha: 0.7)
        stackView.layer.cornerRadius = 10
        
        logTypeLabel.anchor(leading: stackView.leadingAnchor, width: 50, leadingPadding: 10)
        yenLabel.anchor(trailing: stackView.trailingAnchor, width: 25, trailingPadding: 10)
        dateLabel.anchor(trailing: stackView.trailingAnchor, width: 25, trailingPadding: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(usingViewModel viewModel: LogViewPresent) {
        if viewModel.logType == 0 { logTypeLabel.text = "貯金" }
        else { logTypeLabel.text = "出金" }
        logLabel.text = String(viewModel.money)
        dateLabel.text = viewModel.date
    }
}

import UIKit

struct ShareConsentItem {
    let title: String
}

class ShareConsentCell: UIView {
    let titleLabel = UILabel()
    let divider = UIView()
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        
        addSubview(titleLabel)
        addSubview(divider)
        
        titleLabel.font = UIFont(name: "Manrope-Bold", size: 14)
        titleLabel.textColor = UIColor(fromHex: "#252525")
        
        titleLabel.makeConstraint { make in
            make.after(self, 12)
            make.trailing(self, 16)
            make.top(self, 16)
        }
        
        divider.makeConstraint { make in
            make.leading(self, 16)
            make.trailing(self, -16)
            make.bottom(self)
            make.height(0.5)
        }
        
        divider.backgroundColor = UIColor(fromHex: "#CECECE")
    }
    
    func configure(with item: String, isLast: Bool) {
        titleLabel.text = item
        divider.isHidden = isLast
    }
}

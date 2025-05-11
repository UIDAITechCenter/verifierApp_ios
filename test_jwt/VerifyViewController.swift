import UIKit
import Foundation


class VerifyViewController: UIViewController {
    
    var binaryString: String?
    
    private let sendRequestButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if let binaryString = binaryString {
            print("Binary String Received: \(binaryString)")
        }
        
        setupUI()
    }
    
    private func setupUI() {
        // Configure the button
        sendRequestButton.setTitle("Verify from Pehchaan", for: .normal)
        sendRequestButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        sendRequestButton.backgroundColor = .brown
        sendRequestButton.tintColor = .white
        sendRequestButton.layer.cornerRadius = 12
        sendRequestButton.translatesAutoresizingMaskIntoConstraints = false
        sendRequestButton.addTarget(self, action: #selector(sendRequestTapped), for: .touchUpInside)
        view.addSubview(sendRequestButton)
        
        // Create a scroll view
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Create a card view
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 12
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 6
        cardView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(cardView)
        
        // Create a stack view inside the card for dynamic labels
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(stackView)
        
        for _ in 0..<41 {
            let label = createLabel(withText: "")
            stackView.addArrangedSubview(label)
        }
        
        // Constraints for the button
        NSLayoutConstraint.activate([
            sendRequestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendRequestButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            sendRequestButton.widthAnchor.constraint(equalToConstant: 200),
            sendRequestButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Constraints for the scroll view
            scrollView.topAnchor.constraint(equalTo: sendRequestButton.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            // Constraints for the card view inside the scroll view
            cardView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            cardView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            cardView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            
            // Constraints for the stack view
            stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16)
        ])
    }

    private func createLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }


    @objc private func sendRequestTapped() {
        print("Button pressed")
        guard let req = binaryString else {
            return
        }
        let customurl = "pehchan://in.gov.uidai.pehchan?req=\(req)"
        guard let encodedurl = customurl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        if let url = URL(string: encodedurl) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                print("Schema not found")
            }
        }
    }
}

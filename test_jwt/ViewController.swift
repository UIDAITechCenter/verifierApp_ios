import Foundation
import UIKit
import zlib
import BigInt
import Compression
import Gzip



class ViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let scrollView = UIScrollView()
    private let cardView = UIView()
    private let stackView = UIStackView()
    private let submitButton = UIButton(type: .system)
    private let converter = BigIntConverter()
    
    private let labels = [
        "credentialIssuingDate", "enrolmentDate", "enrolmentNumber", "isNRI", "residentImage",
        "residentName", "localResidentName", "ageAbove18", "ageAbove50", "ageAbove60",
        "ageAbove75", "dob", "gender", "careOf", "localCareOf", "building",
        "localBuilding", "locality", "localLocality", "street", "localStreet",
        "landmark", "localLandmark", "vtc", "localVtc", "subDistrict", "localSubDistrict",
        "district", "localDistrict", "state", "localState", "poName", "pincode",
        "address", "regionalAddress", "mobile", "maskedMobile", "email", "maskedEmail", "uid"
    ]
    
    private var checkboxStates: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        checkboxStates = Array(repeating: false, count: labels.count)
        setupUI()
        let str = "2772575833794649776881232808380220713514966711802191642676970572412727771800750285311450941050580295381065394876138773171251465020777741675560573845733554273352645828864234709709141056954640609233927168667572784190510501737763551584461058077104627495130817565220103704546395520087870304159898594666829394036777375446989326549600827258184545468125237509340895248570172537604884483861992380168569801999240830092362127698824207767652041343302564548600178434123714181132955960825026366201666444374305550194297099093785991404123653092488530131190496980323838455280097224383662861720428600320638865590067307817872147509050493109975547692050858799206315593633393745132005003902742859255030756643763884512248000231251100838373666327634145360184082267647822911385233625818137033652753348351229836751261719105961390744221853404599185533853901287145379499035472588865316302108931181052767704581875277290680709577912902183130024858393434783823064609436938796047660930292061282245526590324860878166684201434352686737301969824514718984873255984108378278894798577683441102526146295428709416236441403916452752394166350790185325744686334950284901008171483281439232608205002047307541613044487185936654294109158785140966968020694251705201145886278392808915508344420927111734011644135096455574817259508698292109219341468203759711606913011128770667148586292525532095492933580030319765014245358749200440750295719802726865661656716409331324085753590250205666707129892864"

        guard let xml = converter.bigIntToXMLString(base10String: str) else{
            return
        }
        
        guard let base10 = converter.xmlStringToBigIntBase10(xmlString: xml) else{
            return
        }
        
        print("xml: \(xml)")
        print("base10: \(base10)")
    }
    
    private func setupUI() {
        // Add a title label at the top
        titleLabel.text = "Hello! Please select the fields you want to verify."
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .darkGray
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Create a UIScrollView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Create a CardView for stack content
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 12
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 6
        cardView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(cardView)
        
        // Create a UIStackView for checkboxes
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(stackView)
        
        // Add checkboxes to stackView
        for (index, label) in labels.enumerated() {
            let checkboxRow = createCheckboxWithLabel(text: label, index: index)
            stackView.addArrangedSubview(checkboxRow)
        }
        
        // Add a button at the bottom of the screen
        submitButton.setTitle("Submit", for: .normal)
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        submitButton.backgroundColor = .brown
        submitButton.tintColor = .white
        submitButton.layer.cornerRadius = 12
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        view.addSubview(submitButton)
        
        // Auto Layout Constraints
        NSLayoutConstraint.activate([
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // ScrollView constraints
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -16),
            
            // CardView constraints
            cardView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            cardView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            cardView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // StackView constraints
            stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
            
            // Bottom button constraints
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func createCheckboxWithLabel(text: String, index: Int) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        // Create the checkbox
        let checkbox = UIButton(type: .custom)
        checkbox.setImage(UIImage(systemName: "square")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 26, weight: .regular)), for: .normal)
        checkbox.setImage(UIImage(systemName: "checkmark.square")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 26, weight: .regular)), for: .selected)
        checkbox.addTarget(self, action: #selector(checkboxTapped(_:)), for: .touchUpInside)
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        checkbox.tintColor = .brown
        checkbox.tag = index // Set the unique tag
        container.addSubview(checkbox)

        // Create the label
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(label)

        // Constraints
        NSLayoutConstraint.activate([
            checkbox.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            checkbox.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            checkbox.widthAnchor.constraint(equalToConstant: 32),
            checkbox.heightAnchor.constraint(equalToConstant: 32),
            
            label.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            label.topAnchor.constraint(equalTo: container.topAnchor),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])

        return container
    }
    
    @objc private func checkboxTapped(_ sender: UIButton) {
        let index = sender.tag
        sender.isSelected.toggle()
        checkboxStates[index] = sender.isSelected
    }
    
    @objc private func submitButtonTapped() {
        let binaryString = checkboxStates.map { $0 ? "1" : "0" }.joined()
        let newController = VerifyViewController()
        newController.binaryString = binaryString
        navigationController?.pushViewController(newController, animated: true)
    }
    
}

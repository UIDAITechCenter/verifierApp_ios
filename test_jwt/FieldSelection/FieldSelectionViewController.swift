import UIKit

final class FieldSelectionViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = "Your Company".attributed(by: .manropeSemibold20(color: .CustomColors.darkCyan))
        return label
    }()

    private let separatorLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.lightGray
        return line
    }()

//    private let subtitleLabel: UILabel = {
//        let label = UILabel()
//        label.attributedText = "BY UIDAI".attributed(by: .manropeMedium12(color: .CustomColors.darkCyan))
//        label.textAlignment = .right
//        return label
//    }()

    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.attributedText = "Select all the fields required for KYC".attributed(by: .manropeBold18(color: .CustomColors.darkCyan))
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    }()

    private let checkboxGroupStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .leading
        return stackView
    }()

    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Manrope-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor(fromHex: "#4D3611").withAlphaComponent(0.8)
        ]
        let attributedTitle = NSAttributedString(string: "Select fields to continue", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.backgroundColor = UIColor(fromHex: "#CDDCE4")
        button.layer.cornerRadius = 25
        button.isEnabled = false
        return button
    }()

    private let bgGradient2: GradientView = {
        let view = GradientView()
        let gradientStartEndPoint = UIHelper.getGradientStartAndEndPoints(direction: GradientDirection.topToBottom.rawValue)
        view.gradientLayer.startPoint = gradientStartEndPoint.start
        view.gradientLayer.endPoint = gradientStartEndPoint.end
        view.gradientLayer.colors = UIColor.CustomColors.homeBgGradient2
        return view
    }()

    private var fields = ["Resident Image", "Resident Name", "DOB", "Gender", "Address", "Age Above 18", "Age Above 50", "Age Above 60", "Age Above 75","Masked Mobile Number"]
    private let fieldIndices = [5, 6, 12, 13, 35, 8, 9, 10, 11, 38]
    private var binaryString = String(repeating: "0", count: 41)
    private var selectedFields: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCheckboxes()
    }

    private func setupUI() {
        view.addSubviews(bgGradient2, titleLabel, separatorLine, /*subtitleLabel,*/ instructionLabel, checkboxGroupStackView, continueButton)

        bgGradient2.makeConstraint { make in
            make.fill(self.view)
        }

        titleLabel.makeConstraint { make in
            make.top(view.safeAreaLayoutGuide, 16)
            make.leading(view, 16)
        }

//        subtitleLabel.makeConstraint { make in
//            make.top(view.safeAreaLayoutGuide, 24)
//            make.trailing(view, 20)
//        }

        separatorLine.makeConstraint { make in
            make.top(titleLabel, 40)
            make.leading(view, 16)
            make.trailing(view, 16)
            make.height(0.2)
        }

        instructionLabel.makeConstraint { make in
            make.top(separatorLine, 16)
            make.leading(view, 16)
        }

        checkboxGroupStackView.makeConstraint { make in
            make.top(instructionLabel, 60)
            make.leading(view, 25)
            make.trailing(view, -40)
        }

        continueButton.makeConstraint { make in
            make.bottom(view.safeAreaLayoutGuide, 20)
            make.centerX(view)
            make.width(353)
            make.height(50)
        }

        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }

    private func setupCheckboxes() {
        fields.enumerated().forEach { index, field in
            let checkboxRow = createCheckboxRow(text: field, tag: index)
            checkboxGroupStackView.addArrangedSubview(checkboxRow)
        }
    }

    private func createCheckboxRow(text: String, tag: Int) -> UIStackView {
        let checkboxButton = createCheckboxButton()
        checkboxButton.tag = tag
        
        // Create the label
        let label = UILabel()
        label.attributedText = text.attributed(by: .manropeSemibold15(color: .black))
        label.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [checkboxButton, label])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Handle checkbox tap
        checkboxButton.addTarget(self, action: #selector(checkboxTapped(_:)), for: .touchUpInside)
        
        return stackView
    }

    private func createCheckboxButton() -> UIButton {
        let button = UIButton(type: .custom)
        
        // Configure checkbox images
        let uncheckedImage = UIImage(systemName: "square")?.withConfiguration(
            UIImage.SymbolConfiguration(pointSize: 26, weight: .regular)
        ).withTintColor(UIColor(fromHex: "#86A3BD").withAlphaComponent(0.8), renderingMode: .alwaysOriginal)
        
        let checkedImage = UIImage(systemName: "checkmark.square")?.withConfiguration(
            UIImage.SymbolConfiguration(pointSize: 26, weight: .regular)
        ).withTintColor(UIColor(fromHex: "#004F74"), renderingMode: .alwaysOriginal)
        
        button.setImage(uncheckedImage, for: .normal)
        button.setImage(checkedImage, for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true 
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }

    @objc private func checkboxTapped(_ sender: UIButton) {
        let field = fields[sender.tag]
        let fieldIndex = fieldIndices[sender.tag] - 1
        
        if selectedFields.contains(field) {
            selectedFields.removeAll { $0 == field }
            sender.isSelected = false
            updateBinaryString(at: fieldIndex, with: "0")
        } else {
            selectedFields.append(field)
            sender.isSelected = true
            updateBinaryString(at: fieldIndex, with: "1")
        }
        
        let selectedFieldsString = selectedFields.joined(separator: ", ")
        
        print("Selected Fields: \(selectedFieldsString)")
        print("Binary String: \(binaryString)")
        
        updateContinueButtonState()
    }
    private func updateBinaryString(at index: Int, with value: String) {
        var binaryArray = Array(binaryString)
        binaryArray[index] = Character(value)
        binaryString = String(binaryArray)
    }
    

    @objc private func continueButtonTapped() {
        let nextViewController = VerificationScreenViewController()
        nextViewController.binaryString = binaryString
        nextViewController.selectedFieldsForVerification = selectedFields
        navigationController?.pushViewController(nextViewController, animated: true)
    }

    private func updateContinueButtonState() {
        let isEnabled = !selectedFields.isEmpty
        continueButton.isEnabled = isEnabled
        continueButton.backgroundColor = isEnabled ? .CustomColors.darkCyan : UIColor(fromHex: "#CDDCE4").withAlphaComponent(0.8)

        let title = isEnabled ? "Continue" : "Select fields to continue"
        let textColor: UIColor = isEnabled ? .white : .CustomColors.bakerChocolate.withAlphaComponent(0.8)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Manrope-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14),
            .foregroundColor: textColor
        ]
        
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        continueButton.setAttributedTitle(attributedTitle, for: .normal)
    }
}

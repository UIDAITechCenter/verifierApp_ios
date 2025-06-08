

import UIKit

class VerificationScreenViewController: UIViewController {
    var binaryString: String = ""
    var selectedFieldsForVerification: [String] = []
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = "AAI".attributed(by: .manropeSemibold20(color: .CustomColors.darkCyan))
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
    
    private let descriptionLabel: UITextView = {
        let fullText = """
    I hereby provide my voluntary consent to register for the One Card App using my Aadhaar demographic information. This information shall be utilized solely for the purpose of identification during the registration process to demonstrate the app’s capabilities.

    I understand that my information will not be shared with any third party without my explicit consent. By providing this consent, I confirm that I have been duly informed about the intended use of my information.

    Furthermore, I acknowledge that the purpose of data collection is in accordance with the Aadhaar Act, 2016 and all applicable regulations.
    """

        // Apply your custom styling
        let baseAttrText = fullText.attributed(by: .manropeBold15(color: .CustomColors.midnight))
        let attributedText = NSMutableAttributedString(attributedString: baseAttrText)

        // Add link styling
        let linkText = "www.pehchaanstage.uidai.gov.in"
        let linkRange = (fullText as NSString).range(of: linkText)
        attributedText.addAttributes([
            .link: URL(string: "https://www.pehchaanstage.uidai.gov.in")!,
            .foregroundColor: UIColor.systemBlue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ], range: linkRange)

        let textView = UITextView()
        textView.attributedText = attributedText
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.dataDetectorTypes = []
        textView.backgroundColor = .clear
        textView.textAlignment = .left
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.linkTextAttributes = [
            .foregroundColor: UIColor.systemBlue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]

        return textView
    }()


    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    
    private let approveButton: UIButton = {
        let button = UIButton(type: .system)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Manrope-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.white
        ]
        button.setAttributedTitle(NSAttributedString(string: "Approve", attributes: attributes), for: .normal)
        button.backgroundColor = UIColor(fromHex: "#004F74")
        button.layer.cornerRadius = 25
        return button
    }()

    private let rejectButton: UIButton = {
        let button = UIButton(type: .system)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Manrope-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.black
        ]
        button.setAttributedTitle(NSAttributedString(string: "Reject", attributes: attributes), for: .normal)
        button.backgroundColor = UIColor(fromHex: "#CDDCE4")
        button.layer.cornerRadius = 25
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
    
    private lazy var actionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rejectButton , approveButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubviews(bgGradient2, titleLabel, separatorLine, /*subtitleLabel,*/ actionStackView, descriptionLabel , scrollView)
        scrollView.addSubviews(stackView)

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
        
        descriptionLabel.makeConstraint { make in
            make.top(separatorLine, 30)
            make.leading(view, 16)
            make.trailing(view, 16)
        }
        
        scrollView.makeConstraint { make in
            make.top(descriptionLabel, 15)
            make.leading(view, 25)
            make.trailing(view, -25)
            make.bottom(view.safeAreaLayoutGuide, 80)
        }

        stackView.makeConstraint { make in
            make.top(scrollView)
            make.leading(scrollView)
            make.trailing(scrollView)
            make.bottom(scrollView)
            make.width(340)
        }

//        verifyButton.makeConstraint { make in
//            make.bottom(view.safeAreaLayoutGuide, 20)
//            make.centerX(view)
//            make.width(353)
//            make.height(50)
//        }
        
        actionStackView.makeConstraint { make in
            make.bottom(view.safeAreaLayoutGuide, 20)
            make.centerX(view)
            make.width(353)
            make.height(50)
        }
        
        approveButton.addTarget(self, action: #selector(approveButtonTapped), for: .touchUpInside)
        rejectButton.addTarget(self, action: #selector(rejectButtonTapped), for: .touchUpInside)

    }
    
    @objc private func rejectButtonTapped() {
        print("Reject tapped")
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func approveButtonTapped() {
//        descriptionLabel.attributedText = "VERIFYING...".attributed(by: .manropeBold14(color: .black))
//        descriptionLabel.textAlignment = .center
        let binaryString = self.binaryString
        let activityIndicator = UIActivityIndicatorView(style: .large)
        if let window = UIApplication.shared.windows.first(where: \.isKeyWindow) {
            activityIndicator.center = window.center
            activityIndicator.startAnimating()
            window.addSubview(activityIndicator)
        }
        
        NetworkManager.shared.getJWT(binaryString: binaryString) { result in
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
            
            let callback = "verifierApp"
            switch result {
            case .success(let response):
                let customUrl = "pehchaan://in.gov.uidai.pehchan?request=\(response.token)&callback=\(callback)"
                guard let encodedUrl = customUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                      let url = URL(string: encodedUrl) else {
                    print("Invalid URL")
                    return
                }
                
                DispatchQueue.main.async {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        print("URL scheme not found")
                        let alert = UIAlertController(title: "Error", message: "Unable to open the URL.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
                    }
                }
            case .failure(let error):
                print("error: \(error)")
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: "Failed to send data: \(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
                }
            }
        }
    }

    func handleURL(_ url: URL) {
        approveButton.isHidden = true
        rejectButton.isHidden = true
        descriptionLabel.isHidden = true
        
        guard let selectiveJwt = url.queryParameters["response"] else { return }
        let (jwt, disclosures) = splitSDJWT(sdJWT: selectiveJwt)
        
        //MARK: Verify jwt signature here before decoding disclosures
        
        let decodedDisclosures = decodeDisclosures(disclosures: disclosures)
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for disclosure in decodedDisclosures {
            guard disclosure.count >= 3 else { continue }

            let middleValue = disclosure[1] as? String ?? "Unknown"
            let lastValue = disclosure[2] as? String ?? "Unknown"

            if middleValue == "ResidentImage", let imageView = decodeBase64ToImage(lastValue) {
                stackView.addArrangedSubview(createRowViewWithSpacing(title: middleValue, value: nil, imageView: imageView))
            } else {
                stackView.addArrangedSubview(createRowViewWithSpacing(title: middleValue, value: lastValue, imageView: nil))
            }
        }
    }

    private func createRowViewWithSpacing(title: String, value: String?, imageView: UIImageView?) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.attributedText = title.attributed(by: .robotoMonoCapsBold15(color: .CustomColors.darkNight))
        titleLabel.numberOfLines = 1

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false

        stack.addArrangedSubview(titleLabel)

        if let imageView = imageView {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 60
            imageView.layer.masksToBounds = true
            imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
            stack.addArrangedSubview(imageView)
            
        }

        if let value = value {
            let valueLabel = UILabel()
            valueLabel.attributedText = value.attributed(by: .robotoMonoCapsBold15(color: .CustomColors.midnight))
            valueLabel.numberOfLines = 0
            stack.addArrangedSubview(valueLabel)
        }

        containerView.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            stack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            stack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])

        return containerView
    }

    private func decodeBase64ToImage(_ base64String: String) -> UIImageView? {
        guard let imageData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters),
              let image = UIImage(data: imageData) else {
            return nil
        }

        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    
    private func splitSDJWT(sdJWT: String) -> (jwt: String, disclosures: [String]) {
        let parts = sdJWT.components(separatedBy: "~")
        guard let jwt = parts.first else { return ("", []) }
        let disclosures = Array(parts.dropFirst())
        return (jwt, disclosures)
    }
    private func decodeDisclosures(disclosures: [String]) -> [[Any]] {
        return disclosures.compactMap { disclosure in
            guard let disclosureData = decodeBase64URL(disclosure),
                  let disclosureJson = try? JSONSerialization.jsonObject(with: disclosureData, options: []) as? [Any] else {
                print("Failed to decode disclosure: \(disclosure)")
                return nil
            }
            return disclosureJson
        }
    }
    private func decodeBase64URL(_ input: String) -> Data? {
        var base64 = input.replacingOccurrences(of: "-", with: "+").replacingOccurrences(of: "_", with: "/")
        let padding = base64.count % 4
        if padding > 0 {
            base64 += String(repeating: "=", count: 4 - padding)
        }
        return Data(base64Encoded: base64)
        
    }
}

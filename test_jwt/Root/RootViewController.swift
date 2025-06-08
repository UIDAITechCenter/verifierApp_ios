//
//  RootViewController.swift
//  Pehchan
//
//  Created by farees.syed on 06/03/25.
//

import Foundation
import UIKit

protocol RootViewProtocol where Self: UIViewController {
}

final class RootViewController: UIViewController, RootViewProtocol {

    private let viewModel: RootViewModelProtocol
    
    private let appIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "AAI"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let samvadText: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.attributedText = "Airports Authority of India".attributed(by: .manropeBold22(color: .CustomColors.darkCyan))
        return label
    }()
    
    private let bgGradientView: GradientView = {
        let view = GradientView()
        let gradientStartEndPoint = UIHelper.getGradientStartAndEndPoints(direction: GradientDirection.topLeftToBottomRight.rawValue)
        view.gradientLayer.startPoint = gradientStartEndPoint.start
        view.gradientLayer.endPoint = gradientStartEndPoint.end
        view.gradientLayer.colors = UIColor.CustomColors.homeBgGradientColors
        return view
    }()
    
    private let bgGradient2: GradientView = {
        let view = GradientView()
        let gradientStartEndPoint = UIHelper.getGradientStartAndEndPoints(direction: GradientDirection.topToBottom.rawValue)
        view.gradientLayer.startPoint = gradientStartEndPoint.start
        view.gradientLayer.endPoint = gradientStartEndPoint.end
        view.gradientLayer.colors = UIColor.CustomColors.homeBgGradient2
        return view
    }()
    

    
    private let blackOverlay: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.alpha = 0
        return view
    }()
    
    private let topLabel = UILabel()
    private let loadingContainer = UIView()
    private let loadingLabel = UILabel()
    // TODO: (Farees) add a loader.
    private let loader = CircularSpinnerView()

    init(viewModel: RootViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        viewModel.viewLoaded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.navigateToFieldSelectionCOntroller()
        }
    }
    
    

    private func navigateToFieldSelectionCOntroller() {
        let fieldSelectionViewController = FieldSelectionViewController()
        navigationController?.pushViewController(fieldSelectionViewController, animated: true)
    }
    
    private func addViews() {
        view.backgroundColor = .white
        view.addSubviews(bgGradientView,bgGradient2 ,appIcon, samvadText ,topLabel, loadingContainer)
        loadingContainer.addSubviews(loader, loadingLabel)
        blackOverlay.fillSuperview()
        
        bgGradientView.makeConstraint { make in
            make.fill(self.view)
        }
        bgGradient2.makeConstraint { make in
            make.fill(self.view)
        }

        appIcon.makeConstraint { make in
            make.centerView(view)
            make.size(CGSize(width: 130, height: 130))
        }
        
        samvadText.makeConstraint{ make in
            make.top(appIcon, 130)
            make.centerX(view)
        }
        
        topLabel.makeConstraint { make in
            make.top(view, 73)
            make.centerX(view)
        }
        
        loader.makeConstraint { make in
            make.size(CGSize(width: 12.0, height: 12.0))
            make.leading(loadingContainer, 25.0)
            make.centerY(loadingContainer)
        }
        
        loadingLabel.makeConstraint { make in
            make.after(loader, 10.0)
            make.centerY(loadingContainer, -1.0)
            make.trailing(loadingContainer, 25.0)
        }
        
        loadingContainer.makeConstraint { make in
            make.bottom(view, 60)
            make.centerX(view)
            make.height(37.0)
        }

        topLabel.hideOrSetNonEmpty(attributedText: "AAI".attributed(by: .manropeMedium12(color: .black.withAlphaComponent(0.5))))
        loadingContainer.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        loadingContainer.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        loadingContainer.layer.borderWidth = 1.0
        loadingContainer.layer.cornerRadius = 37/2
        loadingLabel.hideOrSetNonEmpty(attributedText: StringConstants.Root.loadingYourAadhar.attributed(by: .robotoMonoCapsRegular11(color: .black)))
        loader.startAnimating()
    }
}


// MARK: - String Extension for AttributedString
extension String {
    func attributed(by style: AttributedStringStyle) -> NSAttributedString {
        NSAttributedString(string: self, attributes: style.attributes())
    }
}

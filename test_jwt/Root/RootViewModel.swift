//
//  RootViewModel.swift
//  Pehchan
//
//  Created by farees.syed on 06/03/25.
//  Copyright (c) 2025 Dreamplug. All rights reserved.
//

import Foundation
import UIKit

protocol RootViewModelProtocol {
    func viewLoaded()
}

final class RootViewModel: RootViewModelProtocol {
    private let router: RootRouterProtocol

    init(router: RootRouterProtocol) {
        self.router = router
    }

    func viewLoaded() {
//        self.router.showHomeScreen()
    }
    
    private func startLoginFlow() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
        }
    }
    
    private func startOnboardingFlow() {
        
    }
}

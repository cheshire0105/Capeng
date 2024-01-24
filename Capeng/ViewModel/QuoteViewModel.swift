//
//  QuoteViewModel.swift
//  Capeng
//
//  Created by cheshire on 1/24/24.
//

import Foundation

class QuoteViewModel: ObservableObject {
    @Published var advice: String = ""
    private var adviceService = AdviceService()

    func loadAdvice() {
        adviceService.fetchRandomAdvice { [weak self] adviceSlip in
            DispatchQueue.main.async {
                self?.advice = adviceSlip?.slip.advice ?? "No advice found"
            }
        }
    }

}

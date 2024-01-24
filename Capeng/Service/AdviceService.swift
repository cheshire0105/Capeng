//
//  File.swift
//  Capeng
//
//  Created by cheshire on 1/24/24.
//

import Foundation

class AdviceService {
    func fetchRandomAdvice(completion: @escaping (AdviceSlip?) -> Void) {

        guard let url = URL(string: "https://api.adviceslip.com/advice") else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }

            do {
                let adviceSlip = try JSONDecoder().decode(AdviceSlip.self, from: data)
                completion(adviceSlip)
            } catch {
                print("JSON decoding error: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}

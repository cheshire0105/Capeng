//
//  WeatherView.swift
//  Capeng
//
//  Created by cheshire on 1/20/24.
//

import Foundation
import SwiftUI
import CoreLocation

struct WeatherView: View {
    // 현재 날짜를 저장하는 프로퍼티
    @State private var currentDate = Date()
    @ObservedObject private var weatherViewModel = WeatherViewModel()


    init(weatherViewModel: WeatherViewModel = WeatherViewModel()) {
        self.weatherViewModel = weatherViewModel
    }
    var body: some View {
        ZStack {
            Color("BackGroundColor").edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading) {
                Text(currentFormattedDate()) // 고정된 날짜 표시
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("TextColorSet"))
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.leading)

                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            WeatherCardView(viewModel: weatherViewModel)
                            CoffeeRecommendationCardView(viewModel: weatherViewModel)
                        }

                        CoffeeBeanRecommendation(viewModel: weatherViewModel)

                        // QuoteView 추가
                        QuoteView(viewModel: weatherViewModel.quoteViewModel)
                            .onAppear {
                                weatherViewModel.loadQuote()
                            }
                    }
                    .padding()
                }
            }
        }
    }

    private func currentFormattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        return formatter.string(from: currentDate)
    }
}



struct WeatherCardView: View {
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(viewModel.cardBackgroundGradient) // 커스텀 그라디언트 사용
            .frame(width: 150, height: 200)
            .shadow(color: Color.black.opacity(0.3), radius: 10)
            .overlay(
                VStack(alignment: .leading) {
                    if let cityName = viewModel.weatherData?.cityName {
                        Text(cityName)
                            .font(.title2)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom)
                    }

                    Text("\(Int(viewModel.weatherData?.temperature ?? 0))°C")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("\(Int(viewModel.weatherData?.humidity ?? 0))%")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                    .foregroundColor(.white)
                    .padding()
            )
            .padding([.horizontal, .bottom])
    }
}



struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weatherViewModel: WeatherViewModel(isPreview: true))
    }
}








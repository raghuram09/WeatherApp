//
//  AppCoordinatorView.swift
//  WeatherApp
//
//  Created by Raghu on 1/19/26.
//

import SwiftUI

struct AppCordinatorView: View {
    @StateObject var router = Router(root: Route.WeatherView)

    var body: some View {
        RouterView(router: router) { route in
            switch route{
            case .WeatherView:
                WeatherReportView()
            }
        }
    }
}

#Preview {
    AppCordinatorView()
}

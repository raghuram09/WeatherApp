//
//  RouterView.swift
//  WeatherApp
//
//  Created by Raghu on 1/19/26.
//

import SwiftUI

 struct RouterView<T: Hashable, Content: View>: View {
    
    @ObservedObject var router: Router<T>
    
    @ViewBuilder var buildView: (T) -> Content
    
     init(router: Router<T>, @ViewBuilder buildView: @escaping (T) -> Content) {
        self.router = router
        self.buildView = buildView
    }
    
     var body: some View {
        NavigationStack(path: $router.paths) {
            buildView(router.root)
                .navigationDestination(for: T.self) { path in
                    buildView(path).navigationBarBackButtonHidden(true)
                }
        }
        .environmentObject(router)
    }
}

 class Router<T: Hashable>: ObservableObject {
    
    @Published var root: T
    @Published var paths: [T] = []
    
     init(root: T) {
        self.root = root
    }
    
     func push(_ path: T) {
        paths.append(path)
    }
    
     func pop() {
        paths.removeLast()
    }
    
     func updateRoot(root: T) {
        self.root = root
    }
    
     func popToRoot() {
        paths = []
    }
    
     func popTo(_ path: T, inclusive: Bool = false) {
        if let index = paths.lastIndex(of: path) {
            let endIndex = inclusive ? index + 1 : index
            paths.removeSubrange(endIndex..<paths.endIndex)
        } else {
            print("Router: path not found.")
        }
    }
}

enum Route:Hashable{
    case WeatherView
}

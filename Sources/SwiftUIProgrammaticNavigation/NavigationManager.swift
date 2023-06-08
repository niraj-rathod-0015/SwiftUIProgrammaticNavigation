//
//  NavigationManager.swift
//
//
//  Created by Niraj Rathod on 6/8/23.
//

import SwiftUI

@available(iOS 16.0, *)
public class NavigationManager<Screen: NavigationDestination>: ObservableObject {
    
    @Published public var mainNavigationPath: [Screen] = []
    @Published public var currentSheet: Screen? = nil
    @Published public var sheetNavigationPath: [Screen] = []
    
    public init() {}
    
    public func push(_ screen: Screen) {
        if currentSheet == nil {
            mainNavigationPath.append(screen)
        } else {
            sheetNavigationPath.append(screen)
        }
    }
    
    public func pop() {
        if currentSheet == nil {
            _ = mainNavigationPath.popLast()
        } else {
            _ = sheetNavigationPath.popLast()
        }
    }
    
    public func pop(to screen : Screen) {
        if currentSheet == nil {
            if let index = mainNavigationPath.firstIndex(of: screen) {
                mainNavigationPath.removeSubrange(index+1..<mainNavigationPath.count)
            }
        } else {
            if let index = sheetNavigationPath.firstIndex(of: screen) {
                sheetNavigationPath.removeSubrange(index+1..<sheetNavigationPath.count)
            }
        }
    }
    
    public func popToRoot() {
        if currentSheet == nil {
            mainNavigationPath.removeAll()
        } else {
            sheetNavigationPath.removeAll()
            debugPrint(sheetNavigationPath.count)
        }
    }
    
    public func present(_ screen: Screen) {
        sheetNavigationPath.removeAll()
        currentSheet = screen
    }
    
    public func dismiss() {
        currentSheet = nil
    }
    
    public func dismissAndPop(to screen: Screen) {
        currentSheet = nil
        pop(to: screen)
    }
    
    public func dismissAndPopToRoot() {
        currentSheet = nil
        popToRoot()
    }
    
}

@available(iOS 16.0, *)
public extension SwiftUI.View {
    
    func setupNavigationDestinations<Screen>(for type: Screen.Type) -> some View where Screen: NavigationDestination {
        self.navigationDestination(for: Screen.self) { screen in
            screen.destinationView
        }
    }
    
    func presentationManager<Screen>(@ObservedObject _ navManager: NavigationManager<Screen>) -> some View where Screen: NavigationDestination {
        self.sheet(
            item: $navManager.currentSheet,
            onDismiss: {
                navManager.sheetNavigationPath.removeAll()
            },
            content: { screen in
                NavigationStack(path: $navManager.sheetNavigationPath, root: {
                    screen.destinationView
                        .setupNavigationDestinations(for: Screen.self)
                })
                .environmentObject(navManager)
            }
        )
    }
    
}

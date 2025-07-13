//
//  MainTabControllerView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//

import SwiftUI

enum TabType: Int, CaseIterable {
    case home = 0
    case promotion = 1
    case empty = 2
    case account = 3
    
    static let allTabs: [TabType] = [.home, .promotion, .empty, .account]

    var title: String {
        switch self {
        case .home: return "Home"
        case .promotion: return "Promotion"
        case .empty: return "Empty"
        case .account: return "Account"
        }
    }
    
    var icon: Image {
        switch self {
        case .home: return Image(systemName: "house")
        case .promotion: return Image(systemName: "pedal.accelerator")
        case .empty: return Image(systemName: "text.rectangle.page")
        case .account: return Image(systemName: "person.crop.circle")
        }
    }
    
    var iconSelected: Image {
        switch self {
        case .home: return Image(systemName: "house.fill")
        case .promotion: return Image(systemName: "pedal.accelerator.fill")
        case .empty: return Image(systemName: "text.rectangle.page.fill")
        case .account: return Image(systemName: "person.crop.circle.fill")
        }
    }
}

extension Router {
    enum MainTab: Hashable {
        case profile
        case settings
        case subview1
        case subview2
    }
}

struct MainTabControllerView: View {
    var navRouter: any NavRouterProtocol
    @EnvironmentObject var theme: ThemeManager
    @State var selectedTab = TabType.home.rawValue
    
    init(navRouter: any NavRouterProtocol) {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .clear
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.clear
        ]
        
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.clear)
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(Color.clear)
        ]
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.clear
        ]
        navBarAppearance.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.clear
        ]
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        
        self.navRouter = navRouter
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeViewCoordinator(navRouter: navRouter).tag(0)
                PlaceholderViewCoordinator(navRouter: navRouter, title: "Promotion").tag(1)
                PlaceholderViewCoordinator(navRouter: navRouter, title: "This feature").tag(2)
                PlaceholderViewCoordinator(navRouter: navRouter, title: "Account").tag(3)
            }
            tabBar()
        }
        .navigationDestination(for: Router.MainTab.self) { route in
            viewForRoute(route: route)
        }
        .onReceive(NotificationCenter.default.publisher(for: .showSettingsScreen)) { _ in
            navRouter.push(Router.MainTab.settings, animate: true)
        }
        .onReceive(NotificationCenter.default.publisher(for: .showProfileScreen)) { _ in
            navRouter.push(Router.MainTab.profile, animate: true)
        }
        .onReceive(NotificationCenter.default.publisher(for: .showPromotionScreen)) { _ in
            selectedTab = 1
        }

        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .bottomBar)
        .toolbar(.hidden, for: .tabBar)
    }
    
    @ViewBuilder
    private func tabBar() -> some View {
        HStack {
            ForEach(TabType.allTabs, id: \.self) { tab in
                tabItem(tab: tab, isSelected: selectedTab == tab.rawValue)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 24)
        .frame(width: 333, height: 72)
        .background(
            theme.color.subviewBgColor
                .clipShape(RoundedRectangle(cornerRadius: 36))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
        )
    }
    
    @ViewBuilder
    private func tabItem(tab: TabType, isSelected: Bool) -> some View {
        Button {
            selectedTab = tab.rawValue
        } label: {
            HStack(spacing: 24) {
                VStack {
                    tabIcon(tab: tab, isSelected: isSelected)
                    if tab != .home {
                        Text(tab.title)
                            .font(mainFont.regular(10))
                            .foregroundStyle(
                                isSelected ? theme.color.mainTabSelectedTextColor : theme.color.mainTabUnselectedTextColor)
                    }
                }
                if tab == .home {
                    Rectangle()
                        .frame(width: 1, height: 40)
                        .foregroundStyle(Color(hex: "#E5E5EA"))
                }
            }
        }
    }
    
    @ViewBuilder
    private func tabIcon(tab: TabType, isSelected: Bool) -> some View {
        if isSelected {
            tab.iconSelected
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(theme.color.mainTabSelectedTextColor)
        } else {
            tab.icon
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(theme.color.mainTabUnselectedTextColor)
        }
    }
    
    @ViewBuilder
    func viewForRoute(route: Router.MainTab) -> some View {
        switch route {
        case .profile:
//            ProfileViewCoordinator(navRouter: navRouter)
            PlaceholderViewCoordinator(navRouter: navRouter, title: "Profile")
        case .settings:
//            SettingsCoordinator(navRouter: navRouter)
            PlaceholderViewCoordinator(navRouter: navRouter, title: "Settings")
        case .subview1:
            PlaceholderViewCoordinator(navRouter: navRouter, title: "Subview 1")
            case .subview2:
            PlaceholderViewCoordinator(navRouter: navRouter, title: "Subview 2")
        }
    }
}

#Preview {
    MainTabControllerView(navRouter: NavRouter())
        .environmentObject(ThemeManager())
}

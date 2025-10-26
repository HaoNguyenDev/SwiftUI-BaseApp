//
//  MainTabControllerView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//

import SwiftUI

enum TabType: Int, CaseIterable {
    case home = 0
    case users = 1
    case empty2 = 2
    case account = 3
    
    static let allTabs: [TabType] = [.home, .users, .empty2, .account]
    
    var title: String {
        switch self {
        case .home: return "home".localized()
        case .users: return "Users".localized()
        case .empty2: return "empty".localized()
        case .account: return "account".localized()
        }
    }
    
    var icon: Image {
        switch self {
        case .home: return Image(systemName: "house")
        case .users: return Image(systemName: "pedal.accelerator")
        case .empty2: return Image(systemName: "text.rectangle.page")
        case .account: return Image(systemName: "person.crop.circle")
        }
    }
    
    var iconSelected: Image {
        switch self {
        case .home: return Image(systemName: "house.fill")
        case .users: return Image(systemName: "pedal.accelerator.fill")
        case .empty2: return Image(systemName: "text.rectangle.page.fill")
        case .account: return Image(systemName: "person.crop.circle.fill")
        }
    }
}

extension Router {
    enum MainTab: Routable {
        case profile
        case settings
        case subview1(info: String?)
        case subview2(info: String?)
        case userDetail(user: GithubUserDetail)
        var id: String {
            switch self {
            case .profile: return "profile"
            case .settings: return "settings"
            case .subview1: return "subview1"
            case .subview2: return "subview2"
            case .userDetail: return "userDetail"
            }
        }
    }
}

struct MainTabControllerView: View {
    var navRouter: any NavRouterProtocol
    @Environment(\.theme) var theme: any ThemeProtocol
    @Environment(UserSettings.self) private var userSettings
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
                UserListCoordinator(navRouter: navRouter).tag(1)
                PlaceholderViewCoordinator(navRouter: navRouter, title: nil).tag(2)
                AccountViewCoordinator(viewModel: AccountViewModel(), navRouter: navRouter).tag(3)
            }
            tabBar()
                .padding(.horizontal, 25)
                .padding(.bottom, -10)
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
        .onReceive(NotificationCenter.default.publisher(for: .showHomeScreen)) { _ in
            selectedTab = 0
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
        .frame(maxWidth: .infinity, maxHeight: HeightSize.mainTab)
        .background(
            theme.color.primaryBg
                .clipShape(RoundedRectangle(cornerRadius: RadiusSize.tab))
//                .shadow(color: theme.color.primaryShadow, radius: RadiusSize.shadow, x: 0, y: 0)
        )
    }
    
    @ViewBuilder
    private func tabItem(tab: TabType, isSelected: Bool) -> some View {
        Button {
            selectedTab = tab.rawValue
        } label: {
            HStack(spacing: PaddingSize.standard) {
                VStack {
                    tabIcon(tab: tab, isSelected: isSelected)
                    Text(tab.title)
                        .font(isSelected ? theme.font.bold(ofSize: TextSize.caption2) : theme.font.regular(ofSize: TextSize.caption2))
                        .foregroundStyle(isSelected ? theme.color.primaryText : theme.color.secondaryText)
                }
            }
        }
    }
    
    @ViewBuilder
    private func tabIcon(tab: TabType, isSelected: Bool) -> some View {
        if isSelected {
            tab.iconSelected
                .font(theme.font.regular(ofSize: TextSize.title1))
                .symbolRenderingMode(.monochrome)
            //                .symbolEffect(.wiggle, options: .repeat(.bitWidth))
                .symbolEffect(.bounce.up.wholeSymbol, options: .nonRepeating)
                .foregroundColor(theme.color.primaryText)
        } else {
            tab.icon
                .font(theme.font.regular(ofSize: TextSize.title2))
                .foregroundColor(theme.color.secondaryText)
        }
    }
    
    @ViewBuilder
    func viewForRoute(route: Router.MainTab) -> some View {
        switch route {
        case .profile:
            ProfileViewCoordinator(navRouter: navRouter)
        case .settings:
            SettingsCoordinator(navRouter: navRouter)
        case .subview1(let info):
            PlaceholderViewCoordinator(navRouter: navRouter, title: "Subview 1 \(info.orEmpty)")
        case .subview2(let info):
            PlaceholderViewCoordinator(navRouter: navRouter, title: "Subview 2 \(info.orEmpty)")
        case .userDetail(let user):
            UserDetailCoordinator(navRouter: navRouter, user: user)
        }
    }
}

#Preview {
    MainTabControllerView(navRouter: NavRouter())
        .environmentTheme(manager: ThemeManager.shared)
        .environment(UserSettings())
}

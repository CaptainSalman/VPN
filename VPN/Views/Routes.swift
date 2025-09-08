

import Foundation
import SwiftUI

// MARK: - Simple Route Enum for Source
enum SourceRoute: String, CaseIterable, Hashable {
    case intro = "intro"
    case getStarted = "getStarted"
    case signUp = "signUp"
    case login = "login"
    case forgotPassword = "forgotPassword"
    case otpVerification = "otpVerification"
    case emailVerification = "emailVerification"
}

// MARK: - Navigation Data
struct NavigationData: Hashable {
    let sourceRoute: SourceRoute?
    let additionalData: [String: String]
    
    init(sourceRoute: SourceRoute? = nil, additionalData: [String: String] = [:]) {
        self.sourceRoute = sourceRoute
        self.additionalData = additionalData
    }
    
    static func == (lhs: NavigationData, rhs: NavigationData) -> Bool {
        return lhs.sourceRoute == rhs.sourceRoute && lhs.additionalData == rhs.additionalData
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(sourceRoute)
        hasher.combine(additionalData)
    }
}

// MARK: - App Routes
indirect enum AppRoute: Hashable {
    // Onboarding Flow
    case intro
    case getStarted
    
    // Authentication Flow
    case signUp
    case login
    case forgotPassword
    case otpVerification(data: NavigationData? = nil)
    case underVerification(data: NavigationData? = nil)
    case resetPassword(data: NavigationData? = nil)
    case passwordChangeSuccess(data: NavigationData? = nil)
    case emailVerification(data: NavigationData? = nil)
    
    // Main App Flow
    case mainTabView
    case home(data: NavigationData? = nil)
    case dashboard
    case profile
    case settings
    case loanApplication
    case loanDetails
    case documents
    case notifications
    case wallet
    
    // Additional Flows
    case help
    case aboutUs
    case termsAndConditions
    case privacyPolicy
}

// MARK: - Route Extensions
extension AppRoute {
    /// Human readable title for the route
    var title: String {
        switch self {
        case .intro: return "Introduction"
        case .getStarted: return "Get Started"
        case .signUp: return "Sign Up"
        case .login: return "Login"
        case .forgotPassword: return "Forgot Password"
        case .otpVerification: return "OTP Verification"
        case .resetPassword: return "Reset Password"
        case .emailVerification: return "Email Verification"
        case .dashboard: return "Dashboard"
        case .profile: return "Profile"
        case .settings: return "Settings"
        case .loanApplication: return "Loan Application"
        case .loanDetails: return "Loan Details"
        case .documents: return "Documents"
        case .notifications: return "Notifications"
        case .help: return "Help"
        case .aboutUs: return "About Us"
        case .termsAndConditions: return "Terms & Conditions"
        case .privacyPolicy: return "Privacy Policy"
        case .underVerification: return "Under Verification"
        case .passwordChangeSuccess: return "Password Change Success"
        case .mainTabView: return "Main Tab View"
        case .home: return "Home"
        case .wallet: return "My Wallet"
        }
    }
    
    /// Icon name for the route (if needed for tab bars, etc.)
    var iconName: String {
        switch self {
        case .intro: return "book.fill"
        case .getStarted: return "play.circle.fill"
        case .signUp: return "person.badge.plus"
        case .login: return "person.circle.fill"
        case .forgotPassword: return "key.fill"
        case .otpVerification: return "number.square.fill"
        case .resetPassword: return "lock.rotation"
        case .emailVerification: return "envelope.badge.fill"
        case .dashboard: return "house.fill"
        case .profile: return "person.fill"
        case .settings: return "gearshape.fill"
        case .loanApplication: return "doc.text.fill"
        case .loanDetails: return "doc.plaintext.fill"
        case .documents: return "folder.fill"
        case .notifications: return "bell.fill"
        case .help: return "questionmark.circle.fill"
        case .aboutUs: return "info.circle.fill"
        case .termsAndConditions: return "doc.text"
        case .privacyPolicy: return "hand.raised.fill"
        case .underVerification: return "doc.text.fill"
        case .passwordChangeSuccess: return "doc.text.fill"
        case .mainTabView: return "house.fill"
        case .home: return "doc.text.fill"
        case .wallet: return "doc.text.fill"
        }
    }
    
    /// Whether this route requires authentication
    var requiresAuth: Bool {
        switch self {
        case .intro, .getStarted, .signUp, .login, .forgotPassword, .resetPassword:
            return false
        default:
            return true
        }
    }
}

// MARK: - Navigation Helper (iOS 14 Compatible)
class NavigationManager: ObservableObject {
    @Published var routeStack: [AppRoute] = []
    @Published var shouldShowMainTabView = false
    
    /// Navigate to a route (simple)
    func navigate(to route: AppRoute) {
        if route == .mainTabView {
            shouldShowMainTabView = true
        } else {
            routeStack.append(route)
        }
    }
    
    /// Navigate with data (for any route that needs it)
    func navigate(to route: AppRoute, from sourceRoute: SourceRoute, with data: [String: String] = [:]) {
        let navigationData = NavigationData(
            sourceRoute: sourceRoute,
            additionalData: data
        )
        
        let finalRoute: AppRoute
        switch route {
        case .otpVerification:
            finalRoute = .otpVerification(data: navigationData)
        case .resetPassword:
            finalRoute = .resetPassword(data: navigationData)
        case .underVerification:
            finalRoute = .underVerification(data: navigationData)
        default:
            finalRoute = route
        }
        
        routeStack.append(finalRoute)
    }
    
    /// Go back one step
    func goBack() {
        if !routeStack.isEmpty {
            routeStack.removeLast()
        }
    }
    
    /// Go back to root
    func goToRoot() {
        routeStack.removeAll()
    }
    
    /// Go back until a specific route is found
    func goBackTo(_ target: AppRoute) {
        guard let index = routeStack.firstIndex(of: target) else { return }
        
        // remove everything above that index
        let newStack = Array(routeStack.prefix(through: index))
        routeStack = newStack
    }
    
    /// Replace current route with new one
    func replace(with route: AppRoute) {
        if !routeStack.isEmpty {
            routeStack.removeLast()
        }
        routeStack.append(route)
    }
    
}

extension Double {
    /// Scales height based on iPhone SE reference height (667) with improved scaling
    var h: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let baseHeight: CGFloat = 667 // iPhone SE height
        let scaleFactor = screenHeight / baseHeight
        
        // Apply more conservative scaling for larger screens
        let adjustedScale = scaleFactor > 1.0 ? 1.0 + (scaleFactor - 1.0) * 0.8 : scaleFactor
        return CGFloat(self) * adjustedScale
    }
    
    /// Scales width based on iPhone SE reference width (375) with improved scaling
    var w: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let baseWidth: CGFloat = 375 // iPhone SE width
        let scaleFactor = screenWidth / baseWidth
        
        // Apply more conservative scaling for larger screens
        let adjustedScale = scaleFactor > 1.0 ? 1.0 + (scaleFactor - 1.0) * 0.8 : scaleFactor
        return CGFloat(self) * adjustedScale
    }
    
    /// Scales font size with improved algorithm for better readability
    var sp: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let baseWidth: CGFloat = 375 // iPhone SE width
        let scaleFactor = screenWidth / baseWidth
        
        // More conservative font scaling to maintain readability
        let adjustedScale = scaleFactor > 1.0 ? 1.0 + (scaleFactor - 1.0) * 0.6 : scaleFactor
        return CGFloat(self) * adjustedScale
    }
    
    /// Scales corner radius consistently with `.w` (width-based scaling).
    var r: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let baseWidth: CGFloat = 375 // iPhone SE base width
        
        let scaleFactor = screenWidth / baseWidth
        
        // Limit radius scaling to avoid oversized rounding on iPads
        let adjustedScale = min(scaleFactor, 1.5)
        
        return self * adjustedScale
    }
}

extension UIView {
    func fadeTo(_ alpha: CGFloat, duration: TimeInterval? = 0.3) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration != nil ? duration! : 0.3) {
                self.alpha = alpha
            }
        }
    }
    
    func fadeIn(_ duration: TimeInterval? = 0.3) {
        fadeTo(1.5, duration: duration)
    }
    func fadeOut(_ duration: TimeInterval? = 0.3) {
        fadeTo(0.0, duration: duration)
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
}

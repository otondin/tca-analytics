import ComposableArchitecture
import FirebaseAnalytics

public struct AnalyticsEvent {
    let name: String
    let parameters: [String: Any]?
    
    public init(name: String, parameters: [String: Any]? = nil) {
        self.name = name
        self.parameters = parameters
    }
    
    public static func screenView(_ screenName: String, screenClass: String? = nil) -> Self {
        .init(
            name: screenName,
            parameters: [
                AnalyticsParameterScreenName: screenName,
                AnalyticsParameterScreenClass: screenClass ?? ""
            ]
        )
    }

    public static func action(_ actionName: String) -> Self {
        .init(name: actionName)
    }
      
    public static func action(_ actionName: String, from screenName: String) -> Self {
        .init(
            name: actionName,
            parameters: [
                AnalyticsParameterScreenName: screenName
            ]
        )
    }
}

public protocol AnalyticsActionProtocol {
    associatedtype ActionDescription: RawRepresentable where ActionDescription.RawValue == String
    var featureDescription: String { get }
    var event: AnalyticsEvent? { get }
}

@Reducer
public struct AnalyticsReducer<State, Action> where Action: AnalyticsActionProtocol {
    
    public init() {}
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        guard let event = action.event
        else { return .none }
        
        return .run { _ in Analytics.logEvent(event.name, parameters: event.parameters) }
    }
}

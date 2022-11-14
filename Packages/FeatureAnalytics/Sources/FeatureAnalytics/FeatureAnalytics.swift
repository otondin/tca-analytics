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

}

public protocol AnalyticsActionProtocol {
    var event: AnalyticsEvent { get }
}

public extension ReducerProtocol where Action: AnalyticsActionProtocol {
    func analyticsReducer() -> some ReducerProtocol<State, Action> {
        Reduce { state, action in
            let effects = self.reduce(into: &state, action: action)
            return .merge(
                .fireAndForget {
                    Analytics.logEvent(action.event.name, parameters: action.event.parameters)
                },
                effects
            )
        }
    }
}

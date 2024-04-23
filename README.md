# TCAFeatureAnalytics

A TCA high-order reducer to easily integrate with Google Firebase Analytics.

Example:

```swift
extension MyFeatureAction: AnalyticsActionProtocol {

    public var featureDescription { "My Feature" }
    
    public enum ActionDescription: String {
        case screenView = "my_feature_screen_view"
        case actionA = "action_a"
    }
    
    public var event: AnalyticsEven? {
        switch self {
        case .onAppear:
            return .screenView(AnalyticsAction.screenView.rawValue)
            
        case .actionA:
            return .action(ActionDescription.actionA.rawValue, from: featureDescrition)
        
        default:
            return nil
        }
    } 
}
```

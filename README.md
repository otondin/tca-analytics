# TCAFeatureAnalytics

A TCA high-order reducer to easily integrate feature actions with Google Firebase Analytics.

## Requirements

- iOS 16+
- Swift 5.9+

## Usage example:

### Parent Feature

```swift
import FeatureAnalytics

@Reducer
struct MyFeature {

    ...
    
    enum Action {
        case onAppear
        case actionA
        case actionB
    }
    
    var body: some ReducerOf<Self> {
        ...
        AnalyticsReducer()
    }
}
```
### Feature Action Extension

```swift
extension MyFeature.Action: AnalyticsActionProtocol {

    public var featureDescription { "My Feature" }
    
    public enum ActionDescription: String {
        case screenView = "screen_view"
        case actionA = "action_a"
    }
    
    public var event: AnalyticsEven? {
        switch self {
        case .onAppear:
            return .screenView(AnalyticsAction.screenView.rawValue, screenClass: featureDescription)
            
        case .actionA:
            return .action(ActionDescription.actionA.rawValue, from: featureDescrition)
        
        default:
            return nil
        }
    } 
}
```

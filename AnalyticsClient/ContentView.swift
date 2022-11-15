//
//  ContentView.swift
//  AnalyticsClient
//
//  Created by Gabriel Tondin on 14/11/2022.
//

import SwiftUI
import ComposableArchitecture
import FeatureAnalytics

struct ContentStore: ReducerProtocol {
    struct State: Equatable {}
    
    enum Action: Equatable {
        case onAppear
        case submitButtonTapped
        case noEventTrackingAction
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .submitButtonTapped:
                // TODO: submit action
                return .none
                
            case .noEventTrackingAction:
                return .none
            }
        }
        .analyticsReducer()
    }
}

extension ContentStore.Action: AnalyticsActionProtocol {
    var event: AnalyticsEvent? {
        switch self {
        case .onAppear:
            return .screenView("Content View Screen", screenClass: "ContentView")
        case .submitButtonTapped:
            return .init(
                name: "Submit button tapped",
                parameters: [
                    "screenName": "Content View Screen",
                    "screenClass": "ContentView"
                ]
            )
        default:
            return nil
        }
    }
}

struct ContentView: View {
    let store: StoreOf<ContentStore>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStack {
                Text("Content View Screen")
                
                Button {
                    viewStore.send(.submitButtonTapped)
                } label: {
                    Text("Submit")
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store(
                initialState: ContentStore.State(),
                reducer: ContentStore()
            )
        )
        
    }
}

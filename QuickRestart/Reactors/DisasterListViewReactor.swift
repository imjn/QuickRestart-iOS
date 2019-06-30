//
//  DisasterListViewReactor.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/30.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import Foundation
import RxSwift
import ReactorKit

class DisasterListViewReactor: Reactor {

    var initialState: State
    var viewController: UIViewController
    let disasterService = DisasterService()

    enum Action {
        case load
        case loadNext
    }

    enum Mutation {
        case setDisasters([Disaster], nextQuery: URL?, hasNext: Bool)
        case appendDisasters([Disaster], nextQuery: URL?, hasNext: Bool)
        case setLoading(isLoading: Bool)
        case empty
    }

    struct State {
        var section: ItemSection
        var nextQuery: URL?
        var hasNext: Bool
        var isLoading: Bool
    }

    init(view: UIViewController) {
        self.viewController = view
        self.initialState = State(section: ItemSection(model: .DisasterListSection, items: []), nextQuery: nil, hasNext: true, isLoading: false)
    }

    func mutate(action: DisasterListViewReactor.Action) -> Observable<DisasterListViewReactor.Mutation> {
        switch action {
        case .load:
            return disasterService.fetchDisasters(query: nil).map({ result in
                guard let result = result else { return .empty }
                return .setDisasters(result.disasters, nextQuery: result.nextQuery, hasNext: result.nextQuery != nil)
            })
        case .loadNext:
            return disasterService.fetchDisasters(query: currentState.nextQuery).map({ result in
                guard let result = result else { return .empty }
                return .setDisasters(result.disasters, nextQuery: result.nextQuery, hasNext: result.nextQuery != nil)
            })
        }
    }

    func reduce(state: DisasterListViewReactor.State, mutation: DisasterListViewReactor.Mutation) -> DisasterListViewReactor.State {
        var newState = state
        switch mutation {
        case .setDisasters(let disasters, let nextQuery, let hasNext):
            newState.section.items = disasters
            newState.nextQuery = nextQuery
            newState.hasNext = hasNext
        case .appendDisasters(let disasters, let nextQuery, let hasNext):
            newState.section.items.append(contentsOf: disasters)
            newState.nextQuery = nextQuery
            newState.hasNext = hasNext
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        case .empty:
            print("empty")
        }
        return newState
    }

}

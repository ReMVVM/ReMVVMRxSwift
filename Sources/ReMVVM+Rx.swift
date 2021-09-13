//
//  ReMVVM+Rx.swift
//  ReMVVMBasicExample
//
//  Created by Dariusz Grzeszczak on 11/01/2019.
//  Copyright © 2019. All rights reserved.
//

import RxSwift
import ReMVVMCore

//extension Store: ReactiveCompatible { }
extension ReMVVM.State: ReactiveCompatible { }
extension ReMVVM.Dispatcher: ReactiveCompatible { }

extension Reactive: ObserverType where Base: Dispatcher {
    public func on(_ event: Event<StoreAction>) {
        guard let action = event.element else { return }
        base.dispatch(action: action)
    }
}

//extension Reactive where Base: StateSource {
//
//    public var value: Observable<Base.State> {
//
//        return Observable.create { [base] observer in
//            let reactiveObserver = ReactiveObserver(observer)
//            base.add(observer: reactiveObserver)
//
//            return Disposables.create {
//                base.remove(observer: reactiveObserver)
//            }
//        }
//        .share(replay: 1)
//    }
//
//    private class ReactiveObserver: StateObserver {
//
//        let observer: AnyObserver<Base.State>
//        init(_ observer: AnyObserver<Base.State>) {
//            self.observer = observer
//        }
//
//        func didReduce(state: Base.State, oldState: Base.State?) {
//            observer.onNext(state)
//        }
//    }
//}

public protocol _Optional {
    associatedtype Wrapped
    var wrapped: Wrapped? { get }
}

extension Optional: _Optional {
    public var wrapped: Wrapped? { self }
}


extension Reactive where Base: StateSource, Base.State: _Optional {

    public var state: Observable<Base.State.Wrapped> {
        return Observable.create { [base] observer in
            let reactiveObserver = ReactiveObserver2(observer)
            base.add(observer: reactiveObserver)

            return Disposables.create {
                base.remove(observer: reactiveObserver)
            }
        }
        .share(replay: 1)
    }

    private class ReactiveObserver2: StateObserver {

        let observer: AnyObserver<Base.State.Wrapped>
        init(_ observer: AnyObserver<Base.State.Wrapped>) {
            self.observer = observer
        }

        func didReduce(state: Base.State.Wrapped, oldState: Base.State.Wrapped?) {
            observer.onNext(state)
        }
    }
}

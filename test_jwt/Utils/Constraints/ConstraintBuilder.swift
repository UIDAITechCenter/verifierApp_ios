//
//  ConstraintBuilder.swift
//  Pehchan
//
//  Created by farees.syed on 06/03/25.
//

import Foundation

@resultBuilder
public struct ConstraintBuilder {
    public static func buildBlock(_ components: [ConstraintCreator]...) -> [ConstraintCreator] {
        components.flatMap { $0 }
    }

    public static func buildExpression(_ expression: ConstraintCreator) -> [ConstraintCreator] {
        [expression]
    }

    public static func buildEither(first component: [ConstraintCreator]) -> [ConstraintCreator] {
        component
    }

    public static func buildEither(second component: [ConstraintCreator]) -> [ConstraintCreator] {
        component
    }

    public static func buildOptional(_ component: [ConstraintCreator]?) -> [ConstraintCreator] {
        component ?? []
    }
}

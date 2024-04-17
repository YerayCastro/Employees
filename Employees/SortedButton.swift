//
//  SortedButton.swift
//  Employees
//
//  Created by Yery Castro on 1/3/24.
//

import SwiftUI

fileprivate struct SortedButton: ViewModifier {
    @Binding var sortType: SortType
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Button {
                            sortType = .ascendent
                        } label: {
                            Text("Ascendent")
                        }
                        Button {
                            sortType = .descendent
                        } label: {
                            Text("Descendent")
                        }
                        Button {
                            sortType = .byID
                        } label: {
                            Text("By ID")
                        }
                    } label: {
                        Text("Sorted by")
                    }
                }
            }
    }
}

extension View {
    func sortedButton(sortType: Binding<SortType>) -> some View {
        modifier(SortedButton(sortType: sortType))
    }
}

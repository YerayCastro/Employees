//
//  SplashView.swift
//  Employees
//
//  Created by Yery Castro on 5/3/24.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var vm: EmpleadosVM
    var body: some View {
        Group {
            if vm.loading {
                ZStack {
                    Color(.splash)
                    Image(.splash)
                    ProgressView()
                        .controlSize(.large)
                        .padding(.top, 400)
                }
                .ignoresSafeArea()
            } else {
                MainView()
            }
        }
        .animation(.default, value: vm.loading)
        .transition(.move(edge: .top))
    }
}

#Preview {
    SplashView()
        .environmentObject(EmpleadosVM.test)
}

//
//  HideNavigationBarModifier.swift
//  code-tracker
//
//  Created by Kaan Koç on 31.08.2021.
//

import SwiftUI

struct HideNavigationBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .navigationBarTitle("")
    }
}

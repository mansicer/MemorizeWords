//
//  ViewUtils.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/27.
//

import SwiftUI

class ViewUtils {
    static func getBlurBackgroundImage(_ filename: String) -> some View {
        Image(filename)
            .resizable()
            .scaledToFill()
            .blur(radius: 20)
            .edgesIgnoringSafeArea(.all)
    }
    static func getViewBlurBackground() -> some View {
        Image("blur_img1")
            .resizable()
            .opacity(0.3)
            .cornerRadius(10)
    }
}

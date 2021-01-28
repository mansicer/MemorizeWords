//
//  AuthorityView.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/28.
//

import SwiftUI

struct AuthorityView: View {
    let authority: Authority
    
    var body: some View {
        VStack {
            ForEach(authority.content.indices) {
                idx in
                LeadingAlignmentText(text: authority.content[idx])
                if idx + 1 < authority.content.count {
                    Divider()
                }
            }
        }
    }
}

//struct AuthorityView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthorityView()
//    }
//}

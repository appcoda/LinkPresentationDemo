//
//  LinkView.swift
//  LinkPresentationDemo
//
//  Created by Gabriel Theodoropoulos.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import SwiftUI
import UIKit
import LinkPresentation

struct LinkView: UIViewRepresentable {
    typealias UIViewType = LPLinkView
    
    var metadata: LPLinkMetadata?
    
    func makeUIView(context: Context) -> LPLinkView {
        guard let metadata = metadata else { return LPLinkView() }
        let linkView = LPLinkView(metadata: metadata)
        return linkView
    }

    func updateUIView(_ uiView: LPLinkView, context: Context) {

    }
}

//
//  ShareLinkView.swift
//  LinkPresentationDemo
//
//  Created by Gabriel Theodoropoulos.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import SwiftUI
import UIKit
import LinkPresentation

class ActivityController: UIViewController, UIActivityItemSource {
    var metadata: LPLinkMetadata?
    var activityViewController: UIActivityViewController?
    var completion: UIActivityViewController.CompletionWithItemsHandler?
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        activityViewController = UIActivityViewController(activityItems: [self], applicationActivities: nil)
        activityViewController?.completionWithItemsHandler = completion
        present(activityViewController!, animated: true, completion: nil)
    }
    
    
    // MARK: - UIActivityItemSource Methods
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return ""
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return metadata?.originalURL
    }
    
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        return metadata
    }
}



struct ShareLinkView: UIViewControllerRepresentable {
    typealias UIViewControllerType = ActivityController
    
    var metadata: LPLinkMetadata?
    var completion: (() -> Void)
    
    func makeUIViewController(context: Context) -> ActivityController {
        let activityController = ActivityController()
        activityController.metadata = metadata
        activityController.completion = { (activityType, completed, returnedItems, error) in
            self.completion()
        }
        activityController.loadView()
        return activityController
    }

    func updateUIViewController(_ uiViewController: ActivityController, context: Context) { }
}

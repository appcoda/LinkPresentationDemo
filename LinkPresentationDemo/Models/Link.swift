//
//  Link.swift
//  LinkPresentationDemo
//
//  Created by Gabriel Theodoropoulos.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import Foundation
import LinkPresentation

class Link: NSObject, NSSecureCoding, Identifiable {
    var id: Int?
    var metadata: LPLinkMetadata?
    
    
    override init() {
        super.init()
    }
    
    
    // MARK: - NSSecureCoding Requirements
    
    static var supportsSecureCoding = true

    func encode(with coder: NSCoder) {
        guard let id = id, let metadata = metadata else { return }
        coder.encode(NSNumber(integerLiteral: id), forKey: "id")
        coder.encode(metadata as NSObject, forKey: "metadata")
    }

    required init?(coder: NSCoder) {
        id = coder.decodeObject(of: NSNumber.self, forKey: "id")?.intValue
        metadata = coder.decodeObject(of: LPLinkMetadata.self, forKey: "metadata")
    }
}

//
//  Permuta.swift
//  permutapp
//
//  Created by Maria Jesus Cadenas Sanchez on 11/05/2020.
//  Copyright © 2020 DlgaETSII. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol DocumentSerializeable {
    init?(dictionary:[String:Any])
}
struct Permuta {
    var course: String
    var groupOrigin: String
    var groupDestine: String
    var user: String

    var dictionary: [String: Any] {
        return [
            "curse": course,
            "groupOrigin": groupOrigin,
            "groupDestine": groupDestine,
            "user": user
        ]
    }
}
extension Permuta : DocumentSerializeable {
    init?(dictionary: [String : Any]) {
        guard let course = dictionary["course"] as? String,
            let groupOrigin = dictionary["groupOrigin"] as? String,
            let groupDestine = dictionary["groupDestine"] as? String,
            let user = dictionary["user"] as? String else {return nil}
        self.init(course: course, groupOrigin: groupOrigin, groupDestine: groupDestine, user: user)
    }
}

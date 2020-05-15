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
    var grade: String
    var course: String
    var groupOrigin: String
    var groupDestine: String
    var user: String

    var dictionary: [String: Any] {
        return [
            "grade": grade,
            "curse": course,
            "groupOrigin": groupOrigin,
            "groupDestine": groupDestine,
            "user": user
        ]
    }
}
extension Permuta : DocumentSerializeable {
    init?(dictionary: [String : Any]) {
        guard let grade = dictionary["grade"] as? String,
            let course = dictionary["course"] as? String,
            let groupOrigin = dictionary["groupOrigin"] as? String,
            let groupDestine = dictionary["groupDestine"] as? String,
            let user = dictionary["user"] as? String else {return nil}
        self.init(grade: grade, course: course, groupOrigin: groupOrigin, groupDestine: groupDestine, user: user)
    }
}

//
//  ImageViewAspectFill.swift
//  Renty
//
//  Created by İlyas Abiyev on 4/2/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import Foundation
import UIKit


class ImageViewAspectFill : UIImageView {
    convenience init() {
        self.init(image : nil)
        contentMode = .scaleAspectFill
        clipsToBounds = true
    }
}

//
//  Source.swift
//  TurkishCuisineOne
//
//  Created by Shohzod Rajabov on 03/12/21.
//

import UIKit

class Meal {
    var name: String? = nil
    var url: String?
    var ingredients = [Ingredient]()
    var steps = [Step]()
    var desc: String?
    var img: String?
    var img_url: String?
    
    init(_ json:[String : AnyObject]) {
        self.name = json["name"] as? String
        self.url = json["url"] as? String
        self.desc = json["desc"] as? String
        self.img = json["name"] as? String
        self.img_url = json["img_url"] as? String
        
        if let array = json["ingredients"] as? [[String : AnyObject]]{
            var result = [Ingredient]()
            for js in array{
                let obj = Ingredient.init(js)
                result.append(obj)
            }
            self.ingredients = result
        }
        if let array = json["steps"] as? [[String : AnyObject]]{
            var result = [Step]()
            for js in array{
                let obj = Step.init(js)
                result.append(obj)
            }
            self.steps = result
        }
    }
}

class Ingredient {
    var name: String?
    init(_ json:[String : AnyObject]) {
        self.name = json["name"] as? String
    }
}

class Step {
    var name: String?
    var img: String?
    init(_ json:[String : AnyObject]) {
        self.name = json["name"] as? String
        self.img = json["img"] as? String
    }
}

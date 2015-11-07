//
//  ProductModel.swift
//  HuntTimehop
//
//  Created by thomas on 1/5/15.
//  Copyright (c) 2015 thomas. All rights reserved.
//

import Foundation

struct ProductModel {
  var id: Int
  var name: String
  var tagline: String
  var comments: Int
  var votes: Int
  var phURL: String
  var screenshotURL: String
  var makerInside: Bool
  var hunter: String
}

//{u'item_name': u'product', u'color': u'#5898f1', u'id': 1, u'name': u'Tech', u'slug': u'tech'},
//{u'item_name': u'game', u'color': u'#ca65e9', u'id': 2, u'name': u'Games', u'slug': u'games'},
//{u'item_name': u'book', u'color': u'#f5a623', u'id': 4, u'name': u'Books', u'slug': u'books'},
//{u'item_name': u'podcast episode', u'color': u'#4dc667', u'id': 3, u'name': u'Podcasts', u'slug': u'podcasts'}

//
//  CarouselItem.swift
//  Kinova
//
//  Created by Igor Camilo on 02.08.25.
//

import TMDB

protocol CarouselItem: Identifiable {
  var caption: String? { get }
  var destination: Destination { get }
  var image: CarouselImage? { get }
}

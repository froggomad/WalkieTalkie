//
//  LoadingView.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 11/8/21.
//

import Foundation
import SwiftUI

struct LoadingAnimation: UIViewRepresentable {
    let animatedFrames: UIImage
    let image: UIImageView
    var color: UIColor

    init(color: Color = ColorSheet.primaryColor) {
        self.color = UIColor(color)
        var images: [UIImage] = []
        for i in 1...8 {
            guard let image = UIImage(named: "walkie_talking_\(String(format: "%03d", i))") else { continue }
            images.append(image)
        }
        animatedFrames = UIImage.animatedImage(with: images, duration: 4) ?? UIImage()
        image = UIImageView(frame: CGRect(x: 0, y: 0, width: 125, height: 125))
    }

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 125, height: 125))

        image.clipsToBounds = true
        image.autoresizesSubviews = true
        image.contentMode = .scaleAspectFit
        image.image = animatedFrames
        image.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        view.backgroundColor = color
        view.addSubview(image)

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        // no code here; just for protocol
    }
}

struct LoadingAnimationView: View {
    var color: Color = ColorSheet.primaryColor
    var body: some View {
        VStack {
            LoadingAnimation(color: color)
        }
    }
}

struct LoadingAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAnimationView()
            .frame(width: 125, height: 125, alignment: .center)
            .previewLayout(.sizeThatFits)
    }
}

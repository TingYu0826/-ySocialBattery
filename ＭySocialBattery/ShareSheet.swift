//
//  ShareSheet.swift
//  ＭySocialBattery
//
//  Created by 陳亭瑜 on 2025/8/1.
//

import SwiftUI

// MARK: - SwiftUI View 轉 UIImage
extension View {
    func asUIImage() -> UIImage {
        // iOS 16+ 用 ImageRenderer，iOS 15 可參考 UIHostingController
        let renderer = ImageRenderer(content: self)
        renderer.isOpaque = false   // 這一行讓背景保持透明
        return renderer.uiImage ?? UIImage()
    }
}

// MARK: - 呼叫 iOS 分享面板
struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // 不用寫內容
    }
}

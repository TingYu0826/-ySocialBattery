//
//  SocialBatteryCardView.swift
//  ＭySocialBattery
//
//  Created by 陳亭瑜 on 2025/8/4.
//

import Foundation
import SwiftUI

struct SocialBatteryCardView: View {
    var cardColor: Color
    var lightningOffset: CGFloat
    var customMood: String
    var mood: String
    var allowDrag: Bool = false
    var onDrag: ((CGFloat) -> Void)? = nil

    // 只有主畫面才要拖曳手勢，分享用的就不要
    var body: some View {
        ZStack {
            // ✨ 高質感卡片背景
            RoundedRectangle(cornerRadius: 70, style: .continuous)
                .fill(.ultraThinMaterial)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            cardColor.opacity(0.80),
                            cardColor.opacity(0.45),
                            Color.white.opacity(0.13)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 70, style: .continuous))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 70, style: .continuous)
                        .stroke(Color(red: 255/255, green: 220/255, blue: 70/255), lineWidth: 2.2)
                )
                .shadow(color: .black.opacity(0.13), radius: 16, x: 0, y: 8)

            VStack(spacing: 20) {
                ZStack {
                    Image("battery_pin")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                    Image(systemName: "bolt.fill")
                        .resizable()
                        .frame(width: 24, height: 34)
                        .foregroundColor(.yellow)
                        .shadow(color: .black.opacity(0.8), radius: 8)
                        .offset(x: lightningOffset, y: 32)
                        .gesture(
                            allowDrag ?
                                DragGesture()
                                    .onChanged { value in onDrag?(value.translation.width + lightningOffset) }
                                    .onEnded { _ in onDrag?(lightningOffset) }
                                : nil
                        )
                }
                .frame(height: 110)
                Text(customMood.isEmpty ? mood : customMood)
                    .font(.system(size: 25, weight: .medium, design: .rounded))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 4)
            }
            .padding([.horizontal, .vertical], 28)
        }
        .frame(width: 380, height: 250)
        .background(Color.white) // 保證轉圖片有底色
    }
}

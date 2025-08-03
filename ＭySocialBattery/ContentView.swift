import SwiftUI
import UIKit

struct ContentView: View {
    @State private var customMood: String = ""
    @State private var cardColor: Color = Color(red: 252/255,  green: 93/255, blue: 93/255)
    @State private var mood: String = "🪫 社交已死亡，東踏取密！"
    @State private var shareImage: UIImage?
    @State private var showShareSheet = false
    @State private var lightningOffset: CGFloat = -108   // 預設最左格

    // 7 格座標
    let lightningSlots: [CGFloat] = [-108, -72, -36, 0, 36, 72, 108]
    // 7 種心情
    let moods: [String] = [
        "🪫 社交已死亡，東踏取密！",
        "😫 快鼠掉了",
        "😕 累.jpg",
        "😐 正常",
        "🙂 還行還行",
        "😊 接近滿電，快來找我吃飯！",
        "🔋 ON FIRE!!"
    ]
    
    var body: some View {
        VStack(spacing: 48) {   //卡片上下
            // 標題（卡片外！）
            HStack(spacing: 8) {
                Text("能量小卡")
                    .font(.system(size: 42, weight: .bold ,design: .rounded))
                Image(systemName: "bolt")
                    .foregroundColor(.yellow)
                    .font(.system(size: 28))
            }
            .padding(.top, 58)

            // ——主卡片元件（可以拖曳閃電）——
            SocialBatteryCardView(
                cardColor: cardColor,
                lightningOffset: lightningOffset,
                customMood: customMood,
                mood: mood,
                allowDrag: true
            ) { dragX in
                // 拖曳時
                let minX: CGFloat = -108
                let maxX: CGFloat = 108
                let slots: [CGFloat] = [-108, -72, -36, 0, 36, 72, 108]
                let x = min(max(dragX, minX), maxX)
                lightningOffset = x
                if let nearest = slots.min(by: { abs($0 - x) < abs($1 - x) }) {
                    withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                        lightningOffset = nearest
                    }
                    mood = moods[slots.firstIndex(of: nearest) ?? 3]
                }
            }
            .frame(width: 380, height: 250)
            .padding(.bottom, 4)

            // 卡片色選擇
            HStack {
                Text("更換卡片顏色")
                    .font(.system(size: 22, weight: .bold ,design: .rounded))
                ColorPicker("", selection: $cardColor)
                    .labelsHidden()
            }
            .padding(.top, 10)

            // 新增語錄
            TextField("修改語錄⚡️", text: $customMood)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.system(size: 20,design: .rounded))
                .padding(.horizontal, 16)

            // ——分享按鈕（不能拖曳閃電）——
            Button(action: {
                // 這裡 share 卡片（元件直接畫一份不能拖曳的）
                let shareCard = SocialBatteryCardView(
                    cardColor: cardColor,
                    lightningOffset: lightningOffset,
                    customMood: customMood,
                    mood: mood,
                    allowDrag: false
                )
                let image = shareCard
                    .frame(width: 380, height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 70, style: .continuous)) // 這行很重要！
                    .asUIImage()
                shareImage = image
                showShareSheet = true
            }) {
                Text("分享能量！")
                    .font(.system(size: 24, weight: .semibold ,design: .rounded))
                    .frame(maxWidth:.infinity)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(14)
            }
            .padding(.horizontal, 110)

            Spacer()
        }
        .sheet(isPresented: $showShareSheet) {
            if let img = shareImage {
                ShareSheet(activityItems: [img])
            }
        }
        .padding(.bottom, 30)
    }
}

#Preview { ContentView() }

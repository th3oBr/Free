//
//  OnboardingView.swift
//  Free
//
//  Created by Theo Bröll on 2024-01-04.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @StateObject private var viewModel = OnboardingViewModel()

    var body: some View {
        ZStack {
            // Background colors
            Color(red: 16/255, green: 34/255, blue: 22/255).ignoresSafeArea() // background-dark

            // Background Glow Effects
            Circle()
                .fill(Color(red: 19/255, green: 236/255, blue: 91/255).opacity(0.05))
                .blur(radius: 80)
                .frame(width: 400, height: 400)
                .position(x: UIScreen.main.bounds.width, y: 100)

            LinearGradient(
                gradient: Gradient(colors: [Color(red: 19/255, green: 236/255, blue: 91/255).opacity(0.1), .clear]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: UIScreen.main.bounds.height * 0.6)
            .ignoresSafeArea()


            VStack {
                Spacer()
                // Hero Illustration
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 16/255, green: 34/255, blue: 22/255),
                                    Color(red: 19/255, green: 236/255, blue: 91/255).opacity(0.2)
                                ]),
                                center: .center,
                                startRadius: 1,
                                endRadius: 180
                            )
                        )
                        .blur(radius: 30)
                        .opacity(0.5)

                    AsyncImage(url: URL(string: "https://lh3.googleusercontent.com/aida-public/AB6AXuA12PtcgGYTK6AUZsN7KJi2oJ2xG3M4keQIVVdePU8wkFD7bl6odicGMcUofCLUywDGKkFwW-p0UAxxJa16TGUKjuEK5MMQcoWDAXfPK5ETjXUGtqUBza7DASAVa3HIxtxPjaHtvXR01G8o5NcFiu7Sy3EvrQob7CTspSxQBcC6seffSp3vQi8EwFg2Qg6cV_8E1Jhk8QI5y-jS70iVS0urxlf8yGdeXRlB3dM40NjRF3eul-05z8bLobWfn4OYo62BAoU2VXl_rcs5")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 360, maxHeight: 360)
                }
                .padding(.bottom, 20)

                // Page Indicators
                HStack(spacing: 8) {
                    Capsule()
                        .fill(Color.primaryGreen)
                        .frame(width: 24, height: 6)
                        .shadow(color: Color.primaryGreen.opacity(0.5), radius: 5, x: 0, y: 0)
                    Circle().fill(Color.gray.opacity(0.5)).frame(width: 6, height: 6)
                    Circle().fill(Color.gray.opacity(0.5)).frame(width: 6, height: 6)
                }
                .padding(.vertical, 16)

                // Text Content
                VStack(spacing: 12) {
                    Text("Master your\n")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                    + Text("digital life.")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.primaryGreen)

                    Text("Eliminate distractions, track habits, and schedule breaks for mental clarity.")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .multilineTextAlignment(.center)
                .padding(.bottom, 32)

                // Features Carousel
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        FeatureCard(
                            title: "Fokus",
                            iconName: "viewfinder",
                            imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuAzVev3lVdvss0glHij_28C3SiCyc0Qr43LlvSqWycj7-uOMTU4WRBa4-Alpmt9-2v0BFRRcd3ajaBa1BRTp3qN_cN5kZEysZ3YNHqtFEC1lRt4UOyfYGxeqp0ORasHxc8WRftqGwyYlI2T6WFmY0N8OyzcNXRA3PNBvWWB2g15aLSCVe8N4WK4FiNR73J5kYPUKpe1it8O47ggPb7ws1yjCf2-iQSW-i8RG8ynlXmYVwaD8pl3D_aUlg4mU4nBt-nQt4oZYX-zoZ7X"
                        )
                        FeatureCard(
                            title: "Analytik",
                            iconName: "chart.bar.xaxis",
                            imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuAfrafKtI-VwBh4t6n1Qh5ZkGcfKnJM6NIfQMAdEngjizESolNfvxiPL8L62GCAfRwPzUZEDIYzqMkcnzXW5CZfp_JWJKjC1gpIH2i37aavupS1bT7JmSFEdNrhBdoncU64FfEDSwwODy1scvdIvKS8NJ8RlEZtbNcfQQu70Q2QTn615RC1taWy7AEfzJQlUrMZEuCuENlxTjypmjFr27J5d0LRFjYQgwAHmnBaUghsJAgXsApTl8_Oo8Izym_tHjjIT3tR6wCyffj_"
                        )
                        FeatureCard(
                            title: "Detox",
                            iconName: "leaf.fill",
                            imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuCrFBbGKqh4BT7z7GvFQZx0xxHnpQUXAZf7w_OFHWvPze5Oz-M1BDJHxr3RW0OOJNk0z0EwN8IZ52_zbDNlwTidIx4YTQZ1q1ivIIEXFZ3mCoR-37MVJOC6qBZwfyEOe-vItJEKzyMF-ZcjJQHWtqJBaVuJewSXvBeM-xzEhAgg0zpmDOhfe2NGmhUK2tJ3w0Stx8j1FphzO7K3Hv5oJ4JI__7GMQa0lU1lywtgMq7DDbWxMsxv1fCmyQkZzvQ6yVYSzhQXI2Y_nDpW"
                        )
                    }
                    .padding(.horizontal)
                }
                .frame(height: 140)

                Spacer()

                // Bottom Actions
                VStack(spacing: 16) {
                    Button(action: {
                        viewModel.requestAuthorization()
                        appViewModel.completeOnboarding()
                    }) {
                        Text("Start Now")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color(red: 16/255, green: 34/255, blue: 22/255))
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.primaryGreen)
                            .cornerRadius(12)
                            .shadow(color: Color.primaryGreen.opacity(0.25), radius: 10, x: 0, y: 5)
                    }

                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(.gray)
                        Button(action: {}) {
                            Text("Log in")
                                .foregroundColor(.white)
                                .fontWeight(.medium)
                        }
                    }
                    .font(.system(size: 14))
                }
                .padding(.horizontal)

                Spacer().frame(height: 24)
            }
            .padding(.horizontal)
        }
        .preferredColorScheme(.dark)
    }
}

struct FeatureCard: View {
    let title: String
    let iconName: String
    let imageUrl: String

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(width: 100, height: 125)
                .scaleEffect(1.1) // Simulates group-hover:scale-110

                LinearGradient(
                    gradient: Gradient(colors: [.clear, .black.opacity(0.8)]),
                    startPoint: .top,
                    endPoint: .bottom
                )

                VStack {
                    Spacer()
                    Image(systemName: iconName)
                        .font(.system(size: 28))
                        .foregroundColor(.primaryGreen)
                        .shadow(radius: 5)
                    Spacer()
                }
            }
            .frame(width: 100, height: 125)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )

            Text(title)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AppViewModel())
}

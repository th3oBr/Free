//
//  UsageModeView.swift
//  Free
//
//  Created by Theo Bröll on 2024-01-04.
//

import SwiftUI

struct UsageModeView: View {
    @State private var areAllLimitsEnabled = true

    var body: some View {
        ZStack {
            Color(red: 16/255, green: 34/255, blue: 22/255).ignoresSafeArea()

            VStack(spacing: 0) {
                HeaderView()

                ScrollView {
                    VStack(spacing: 24) {
                        SummaryCard()
                        MasterSwitch(isEnabled: $areAllLimitsEnabled)
                        AppLimitsSection()
                    }
                    .padding()
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}


// MARK: - Subviews
private struct HeaderView: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "arrow.backward")
                    .foregroundColor(.white)
            }
            Spacer()
            Text("Usage Mode").bold()
            Spacer()
            Button("Save") {}.bold()
        }
        .padding()
        .foregroundColor(Color(red: 19/255, green: 236/255, blue: 91/255))
        .background(Color.backgroundDark.opacity(0.8))
        .overlay(Rectangle().frame(height: 1).foregroundColor(Color.white.opacity(0.1)), alignment: .bottom)
    }
}

private struct SummaryCard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 28/255, green: 43/255, blue: 33/255))
                .shadow(radius: 10)

            AsyncImage(url: URL(string: "https://lh3.googleusercontent.com/aida-public/AB6AXuAK_8_0C0oAEC37wIbd8lfvcQyHbU7eyLNJv2dWKa6azuN2-ImSIns_R4wQHRumaF03Rs7FESlkVAr5n3wo1vowDxsKR9FWqWeboSi2r9PorXuk2x04ZSZb3WJQRIhcE7JiI_c3_-X3s1RsQ1ne78CKpCl9FTRcwuhMPfky3JKI0LezpDx1-4jjqJmVyjaXRVymFTJK5BYbTxbIm6H27BwErtbXxTEOGCg8yeVeCc-YhaEZ8Oq-BqMP9uFcLw3pieuTAkS2QkR58C4x")) { image in
                image.resizable().opacity(0.4).blendMode(.overlay)
            } placeholder: {
                EmptyView()
            }

            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Daily Summary").font(.caption).bold().foregroundColor(.primaryGreen.opacity(0.8)).textCase(.uppercase)
                        Text("2h 15m").font(.largeTitle).bold()
                        Text("Total allocated budget").font(.subheadline).foregroundColor(.gray)
                    }
                    Spacer()
                    Image(systemName: "timelapse")
                        .font(.largeTitle)
                        .padding()
                        .background(Circle().stroke(Color.primaryGreen, lineWidth: 4))
                }
                .padding()

                ProgressView(value: 0.65)
                    .tint(.primaryGreen)
                    .padding(.horizontal)
                    .padding(.bottom)
            }
        }
    }
}

private struct MasterSwitch: View {
    @Binding var isEnabled: Bool

    var body: some View {
        HStack {
            Image(systemName: "power")
                .frame(width: 40, height: 40)
                .background(Color.primaryGreen.opacity(0.2))
                .foregroundColor(.primaryGreen)
                .cornerRadius(8)

            VStack(alignment: .leading) {
                Text("Enable All Limits").bold()
                Text("Strictly enforce daily budgets").font(.caption).foregroundColor(.gray)
            }

            Spacer()

            Toggle("", isOn: $isEnabled)
                .tint(.primaryGreen)
        }
        .padding()
        .background(Color.surfaceDark)
        .cornerRadius(16)
    }
}

private struct AppLimitsSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("App Limits").font(.title2).bold()

            VStack(spacing: 12) {
                AppLimitRow(
                    appName: "Instagram",
                    category: "Social",
                    timeLimit: "30m",
                    imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuA95FlXaI1YJYMyZI9y4WzYW7heK9cWCIRWRgAX8RGI12QvVsu1PIt1QRYTbWIsFVOlafNBk-Ioh7GUQIuJoETGAD9Tsth4MCla3hasOsIeH_u7EJWV3HVqZtacbqK9yHu75o4JfX0vNlODPtzfzl5ylwNFBzrpESa7_oiN9qx3InCbeTycZQ_IIFSPQ0DzKX5LO7-SwvOuvvWyD7mtlWQfkE2C9Nc5HE74TyCYy67q23zjhdzv3Kxw61CMyeEj9130ChrFZ_969Azs",
                    isEnabled: .constant(true)
                )
                AppLimitRow(
                    appName: "TikTok",
                    category: "Entertainment",
                    timeLimit: "45m",
                    imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuBFWhW4jXT2sYiJjblDaNgbG8X73_lnZ_pEWcEJkI1zGRc1TAtdMO11ldWnfdfL270I270T7zQyOtwMjX_kKa9fgaoas00TtdzwMjlh34dU9_9UQm5H79sIytIbiAOKQ2hCWwYAwCHLYQj613I77zWjlgkwryWLPTh90XGtrCX0Kaeq5EwjqHMR5Txq_Xg3TTu3eyPr-gw_5DLArV0CKdMl1zR98GpkP0t8VYqcJKDTkhn6hEOPAu9vpOF4RoFHaSKSegvpNCSy_bgW",
                    isEnabled: .constant(true)
                )
                AppLimitRow(
                    appName: "YouTube",
                    category: "Video",
                    timeLimit: "1h 00m",
                    imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuDgmAOme1NIdW1IEnuIYt4g_xo4XQYldBgAy05XQHihHDj3dBhylPYN0IAvi_DGdTIaZNkDSiyvYLkFttCnYnWheCY0qAzQEKqVm_Yn-S3EAgaVY4s8M7qr8lcQq8_VgDFExZQ0bhZsmDMrjwpfpbd_VPFy6NzcSTYxRquee-67f-Z22dJjPEKEEK2bGx9ApztC-PyadkF8o5eRgqNnpXP2QV-wgxCyFH_RVU16-J7L8-vHHkLQtI-SikpVx2PWteCBupW5AbZVIm1r",
                    isEnabled: .constant(true)
                )
                AppLimitRow(
                    appName: "WhatsApp",
                    category: "Communication",
                    timeLimit: "--",
                    imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuCU3ynioBXkSixIoTJCDKIjqyPKWlP74JFHkgcVF3r8xG6Af7A97uDWP5Oa11HPCm6GrgO688rf9PKVkMGhJNWG8MV9Ml2gAeAZPuhUFsiVI9RRhwuTahpQtyUeRv9hOwAHmbohyZSj07dmsME5jw2uE34mFYuYgA2BLFWUAuEjuW8E_hFwi8T5CX9ykJD3mi2Vi-ubVKJU36q2DwKWBNLHK18GB0wHEspp7oje08MMXMJIIsgR7Y5w1yxvJwtOf5fjsrQWH6-xWB0f",
                    isEnabled: .constant(false)
                )
            }

            Button(action: {}) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.primaryGreen)
                    Text("Add App Limit")
                        .foregroundColor(.white.opacity(0.8))
                }
                .frame(maxWidth: .infinity)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.2), style: StrokeStyle(lineWidth: 2, dash: [5]))
                )
            }
            .padding(.top)
        }
    }
}

private struct AppLimitRow: View {
    let appName: String
    let category: String
    let timeLimit: String
    let imageUrl: String
    @Binding var isEnabled: Bool

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image.resizable()
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .grayscale(isEnabled ? 0 : 1)

            VStack(alignment: .leading) {
                Text(appName).font(.headline)
                Text(category).font(.caption).foregroundColor(.gray)
            }

            Spacer()

            Button(timeLimit) {}
                .buttonStyle(.bordered)
                .tint(isEnabled ? .primaryGreen : .gray)

            Toggle("", isOn: $isEnabled)
                .tint(.primaryGreen)
        }
        .padding()
        .background(Color.surfaceDark)
        .cornerRadius(16)
        .opacity(isEnabled ? 1 : 0.6)
    }
}


#Preview {
    UsageModeView()
}

//
//  ContentView.swift
//  Catalog
//
//  Created by febriandianto prabowo on 17/05/23.
//

import SwiftUI
import ARKit
import RealityKit

struct RealityKitView: UIViewRepresentable {
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    
    func makeUIView(context: Context) -> some ARView {
        
        let view = ARView()
        
        let session = view.session
        
        let config = ARWorldTrackingConfiguration()
        
        config.planeDetection = [.horizontal]
        
        session.run(config)
        
        
        let coachingOverlay = ARCoachingOverlayView()
        
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        coachingOverlay.session = session
        
        coachingOverlay.goal = .horizontalPlane
        
        view.addSubview(coachingOverlay)
        
        
        
        
        
        return view
        
    }
}


struct ContentView : View {
    
    @State var isOverlay: Bool = true
    @State var isOverlay2: Bool = false
    
    
    var body: some View {
        ARViewContainer(isOverlay2: $isOverlay2).edgesIgnoringSafeArea(.all).overlay{
            if isOverlay{
                VStack {
                    Spacer()
                    Text("Place brochure on a flat surface")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .frame(width: 200)
                   
                    Spacer()
                    
                    Button{
                        isOverlay.toggle()
                        isOverlay2.toggle()
                    }
                    label: {
                        Text("Scan QR")
                        .font(.title)
                        .foregroundColor(.black)
                        
                        
                    }
                    .frame(width: 200, height: 60)
                    .background(Color(.systemBlue))
                    .cornerRadius(20)
                    
                    
                    
                }
            }
            
        }
        .overlay{
            if isOverlay2 {
                Image("ScanFrame")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.9)
                    
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var isOverlay2: Bool
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        
        
        let anchor5 = try! Catalog5.loadScene()
        let anchor4 = try! Catalog4.loadScene()
        let anchor3 = try! Catalog3.loadScene()
        let anchor2 = try! Catalog2.loadScene()
        let anchor1 = try! Catalog1.loadScene()
        
        
        anchor5.actions.spawnCatalog5.onAction = onSpawn
        anchor2.actions.spawnCatalog2.onAction = onSpawn
        anchor1.actions.spawnCatalog1.onAction = onSpawn
        anchor3.actions.spawnCatalog3.onAction = onSpawn
        anchor4.actions.spawnCatalog4.onAction = onSpawn
        
        
        arView.scene.anchors.append(anchor5)
        arView.scene.anchors.append(anchor4)
        arView.scene.anchors.append(anchor3)
        arView.scene.anchors.append(anchor2)
        arView.scene.anchors.append(anchor1)
        
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
    func onSpawn(entity: Entity?){
        isOverlay2 = false
    print(isOverlay2)
        
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

//
//  ContentView.swift
//  Semana11SwiftUI
//
//  Created by Rafael Diego Chuco Yantas on 25/05/26.
//

import SwiftUI
import SwiftData
import UIKit

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Alumno.apellido) private var alumnos: [Alumno]

    @State private var alumnoSeleccionado: Alumno?
    @State private var mostrarFormulario = false

    var body: some View {
        NavigationSplitView {
            List(selection: $alumnoSeleccionado) {
                ForEach(alumnos) { alumno in
                    NavigationLink(value: alumno) {
                        HStack(spacing: 12) {
                            if let data = alumno.foto, let ui = UIImage(data: data) {
                                Image(uiImage: ui)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 52, height: 52)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            } else {
                                Image(systemName: "person.crop.square")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 52, height: 52)
                                    .foregroundStyle(.secondary)
                            }
                            VStack(alignment: .leading) {
                                Text("\(alumno.apellido), \(alumno.nombre)")
                                    .font(.headline)
                                Text("DNI: \(alumno.dni)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteAlumnos)
            }
            .navigationTitle("Alumnos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        mostrarFormulario = true
                    } label: {
                        Label("Nuevo Alumno", systemImage: "plus")
                    }
                }
            }
        } detail: {
            if let alumno = alumnoSeleccionado {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        if let data = alumno.foto, let ui = UIImage(data: data) {
                            Image(uiImage: ui)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .cornerRadius(8)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Detalles del Alumno").font(.title2)
                            Text("Nombre: \(alumno.nombre)")
                            Text("Apellido: \(alumno.apellido)")
                            Text("DNI: \(alumno.dni)")
                        }
                    }
                    .padding()
                }
            } else {
                Text("Selecciona un alumno")
            }
        }
        .sheet(isPresented: $mostrarFormulario) {
            NuevoAlumnoView()
        }
    }

    private func deleteAlumnos(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let alumno = alumnos[index]
                modelContext.delete(alumno)
            }
            do {
                try modelContext.save()
            } catch {
                print("Error al eliminar alumno: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}

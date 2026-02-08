# Software_Projekt_Julius_Philipp
# Devlog


# 🛠️ Devlog – isometric Strategy Game

## 🎯 Projektüberblick
Wir entwickeln ein rundenbasiertes Strategie‑Spiel, inspiriert von *Into the Breach*.  
Der Fokus liegt auf:
- kleinen, taktisch dichten Maps  
- klar lesbaren Aktionen  
- deterministischem Gameplay (wenig bis kein RNG)   

Dieses Devlog dokumentiert unseren Fortschritt, Design‑Entscheidungen und technische Experimente.

---

## 📅 **Devlog Einträge**

### **09. Januar 2026 – Projektstart & Grundgerüst**
**Status:** Erste Struktur steht

- Repository angelegt und initiales Projektgerüst erstellt.  
- Ziel definiert: Ein taktisches, rundenbasiertes Mini‑Schlachtfeld 
- Erste Diskussionen über Kernmechaniken:  
  - deterministische Angriffe  
- Godot‑Projekt vorbereitet (statischer Kamera‑Ansatz, TileMap‑Setup).  
- Erste Tiles importiert und Layer‑Struktur festgelegt (Terrain, Units).
    - 2 Layer, Basis und Units/Terrain
- Git‑Integration eingerichtet.

---

### **13. Januar 2026 – Rendering & Isometrie‑Tests**
**Status:** 
- Start menü erstellt (Julius)
- Grundstruktur für units gelegt (Philipp)


### **22. Januar 2026 - Map-Datenstruktur**
**Status:**
-Map-Datenstruktur hinzugefügt(nach einigem hin und her über die Speichermethode)

### **bis 30.01 Erledigt:**
**Julius:**
-  Tilemap Layer festgelegt und erstellt.
-  Startmenue
-  ingame_Ui, mit zugriff auf alle Units und Karten, holt Daten per Getter, derzeit noch beispieldaten
-  Map Datenstruktur mit Philipp abgesprochen, setter für map definiert
-  isometrische Berechnungen vorerschlossen
-  Kamera bewegung und Borders, Pfeiltasten, bewegung per mouse position und dragging

**Philip:**
-  Map hinzugefügt, getter und Datenstruktur definiert
-  beschäftigung mit Isometrie, funktionsweise 2.Layer erste überlegungen.


## 🔮 Nächste Schritte
- Map Datenstruktur zu Grafik, Units solle abbildbar sein.
- Einfache Unit implementieren
- UI: Tile Highlight (Julius)
- Preview, wenn Units implementiert sind 

---

## 📌 Langfristige Ziele
- Lokaler Multyplayer
- Terrain
- verschiedene Units
- algemein flüssiges Game, mit mehreren Features


## 📌 Struktur

# Provisorische Struktur, allgemeine Idee, nicht final

```
res://
│
├─ src/                     # Reine Logik, keine Szenen
│   ├─ core/                # Basissysteme
│   │   ├─ grid_manager.gd
│   │   ├─ turn_manager.gd
│   │   ├─ action_system.gd
│   │   └─ event_bus.gd
│   │
│   ├─ units/               # Unit-Logik
│   │   ├─ unit.gd
│   │   ├─ unit_stats.gd
│   │   └─ actions/         # Push, Attack, Move, Pull, etc.
│   │       ├─ move_action.gd
│   │       ├─ attack_action.gd
│   │       └─ push_action.gd
│   │
│   ├─ enemies/
│   │   ├─ enemy_controller.gd (Lokaler Multiplayer?)
│   │   └─ intent_system.gd
│   │
│   ├─ ui/                  # UI-Logik
│   │   ├─ action_preview.gd
│   │   ├─ tile_highlight.gd
│   │   └─ hud_controller.gd
│   │
│   └─ utils/               # Helfer, Math, Pathfinding
│       ├─ grid_math.gd
│       ├─ pathfinding.gd
│       └─ directions.gd
│
├─ scenes/                  # Szenen, die im Editor sichtbar sind
│   ├─ main.tscn
│   ├─ board/
│   │   ├─ board.tscn
│   │   └─ tile.tscn
│   ├─ units/
│   │   ├─ mech.tscn
│   │   └─ enemy.tscn
│   └─ ui/
│       ├─ hud.tscn
│       └─ action_preview.tscn
│
├─ assets/                  # Grafiken, Sounds, Fonts
│   ├─ tiles/
│   ├─ units/
│   ├─ fx/
│   └─ fonts/
│
└─ autoload/                # Singletons
    ├─ GameState.gd
    ├─ EventBus.gd
    └─ Config.gd

```

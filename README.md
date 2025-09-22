# The Days

A fast-paced 2D platformer created by a group of seven students after school. The goal is simple: clear eight handcrafted obstacle rooms as quickly as you can. Each time the player falls, they are transported back to the beginning of the current challenge, so mastering the movement is key to beating the ~2 minute target completion time.

## Gameplay

- **Precision platforming:** Wall jumps, moving hazards and disappearing platforms demand quick reflexes.
- **Combat-ready:** Use the left mouse button to attack enemies that block your path.
- **Adaptive pacing:** Double jumps and a short dash help keep your momentum flowing from one room to the next.
- **Retry friendly:** Death instantly resets the current room, letting you practice difficult sections without waiting.

### Controls

| Action | Input |
| ------ | ----- |
| Move left / right | `A` / `D` |
| Jump / Double jump | `Space` |
| Dash | `Left Shift` |
| Attack | `Left Mouse Button` |
| Restart from checkpoint | `R` |

## Getting Started

1. **Install Godot 4.3 or newer.** The project uses Forward Plus rendering, so the 4.x branch is required.
2. **Clone the repository.**
   ```bash
   git clone https://github.com/<your-account>/E-Union.git
   cd E-Union
   ```
3. **Open the project in Godot.** Select `project.godot` when the project manager launches.
4. **Play the game.** Press the ▶ button in the Godot editor to start from `UI/MainMenu.tscn`.

## Project Structure

```
├── Game/                # Gameplay scripts for the player, camera and hazards
├── Map/                 # Playable level scenes
├── Scripts/             # Shared helper scripts
├── UI/                  # Main menu, pause menu and related assets
├── art/                 # Concept art and textures
├── project.godot        # Godot project configuration
└── export_presets.cfg   # Example export targets
```

## Development Notes

- **Scenes:** `UI/MainMenu.tscn` loads the campaign starting at `Map/地图chapter1.tscn`.
- **Input map:** Configured inside `project.godot` so the controls listed above are ready once the project is opened.
- **Exports:** Update `export_presets.cfg` with your desired platforms before exporting builds.

## Contributing

Bug reports and improvement ideas are welcome! Feel free to open an issue or submit a pull request with your proposed changes.

Enjoy the climb, and good luck beating the clock!

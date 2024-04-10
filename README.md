# Viewport Icon Demo

This is a [Godot 4.2](https://godotengine.org/) demo project to show using SubViewports as "icons". Additionally, it demonstraits using a MeshLibrary and GridMap to update the "icon" on display.

All viewports are set to use their own 3D environment and to ignore input (allowing it to pass down to their associated buttons (in this demo).

The two button scenes are saved in the objects folder.
* **mesh_view_button** - Uses a single MeshInstance for the icon model. This button cannot be updated as is, but with a little elbow grease, one can update the MeshInstance at runtime.
* **grid_view_button** - Uses a MeshLibrary and internal GridMap to be able to cycle through meshes in the library. Simply choosing a new tile_id (export variable for the scene) will update the icon accordingly.

## Author
Bryan "ObsidianBlk" Miller

* [Itch.io Profile](https://obsidianblk.itch.io/)
* [Github Profile](https://github.com/ObsidianBlk)

## Installation

Once downloaded simply start the executable.

## Usage
Run the project in the Godot editor and play around with settings. See how it's built!

## License

This project is being released under the [MIT License](./LICENSE.md)

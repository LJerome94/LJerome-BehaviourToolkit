![Thumbnail](docs/thumbnail.svg)
# BehaviourToolkit for Godot 4
This plugin provides a set of tools to create custom and complex behaviour in the Godot 4.x Game Engine.

## About
This project is a fork of [ThePat02/BehaviourToolkit](https://github.com/ThePat02/BehaviourToolkit). I plan to experiment with the code and try to implement classes that I use in my own projects. Main changes are listed in Differences from the original project.

### Features
- ![GEAR ICON](addons/behaviour_toolkit/icons/Gear.svg) Behaviour Architectures
	- ![FMS ICON](addons/behaviour_toolkit/icons/FiniteStateMachine.svg) Finite State Machine
	- ![BT ICON](addons/behaviour_toolkit/icons/BTRoot.svg) Behaviour Tree with generic utility 
	- ![Integration Icon](addons/behaviour_toolkit/icons/BTCompositeIntegration.svg) Nest Behaviour Trees inside State Machines and vice versa!
- ![BLACKBOARD ICON](addons/behaviour_toolkit/icons/Blackboard.svg) Blackboard Resource
- Editor Interface with shortcuts
- [Templates](docs/documentation.md#using-script-templates) for easy extension and integration
- Example Scene

<!-- When a new version is available on GitHub, the plugin will display a notification in the Toolbox! -->



## Installation
- Clone the `main` branch of this repository to your machine
<!-- - Download the latest release from the [Godot Asset Lib](https://godotengine.org/asset-library/asset) -->
- Add the `submodule` branch as [Git Submodule](https://git-scm.com/docs/git-submodule) to your own repo
  - The `submodule` branch is **always** up to date with `main` and will allow you to consistently use the newest version by `pulling`
  - If you are not confident in your CL skills, you can use a client like GitKraken to set this up



## Usage
Make sure the clones the `addons` and `script_templates` directories into your project.

1. Add a `FiniteStateMachine` or `BTRoot` node to your scene.
2. A toolbox will appear in the editor, allowing you to add behaviour nodes to the scene.
3. Setup and configure your behaviour nodes in the inspector.
4. Right-click your `FSMState`/`FSMTransition`/`BTLeaf` and extend the script.

Now you can implement your own behaviour logic using the virtual methods provided by the script templates.



## Documentation
- [Documentation](docs/documentation.md)
  -   [Finite State Machine](docs/documentation.md#finite-state-machine)
  -   [Behaviour Tree](docs/documentation.md#behaviour-tree)
  -   [Blackboard](docs/documentation.md#-blackboard)
  -   [Nesting Behaviours inside Behaviours](docs/documentation.md#nesting-behaviours-inside-behaviours)
  
![Screenshot](docs/screenshot-ui.PNG)


## Notes
This is the first time I've ever made a bigger plugin for Godot, so I am happy for any suggestions, feedback and contributions. If you need help or have any questions, feel free to open an issue on GitHub!

You can support the original author by [buying him a coffee](https://ko-fi.com/pat02).

Have fun creating awesome behaviours!

### Differences from the original project
As of now, I only modified the `README.md` so that it is clear that I (LJerome94) am not the original author. I also commented out informations specific to the [original project](https://github.com/ThePat02/BehaviourToolkit)

## License
This project is licensed under the MIT License. See the LICENSE file for details.

## Acknowledgements
Thanks to the contributors of [BehaviourToolkit](https://github.com/ThePat02/BehaviourToolkit). This project builds upon their foundation to explore new directions.

<!-- ## Star History -->
<!-- [![Star History Chart](https://api.star-history.com/svg?repos=ThePat02/BehaviourToolkit&type=Timeline)](https://star-history.com/#ThePat02/BehaviourToolkit&Timeline) -->

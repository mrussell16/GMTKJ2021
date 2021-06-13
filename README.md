# GMTKJ 2021

Godot Project  for the GMTKJ 2021.

Theme is "Joined Together".

For this I am developing a 2D platformer where the player can travel between two connected dimensions (light and dark).

Key ideas:

* Limited time can be spent in the dark dimension
* Collect light seeds to stay in the dark dimension longer
* Some platforms are only present in light/dark versions
* Enemies attack and reduce time
* Moving/shooting could reduce time

# ToDo

* Sun Morn
    * Sounds
        * Portal
            * Dimension
            * Level
        * Light seed
        * Button
        * Death
            * Spike
            * Enemy
            * Timeout
    * Itch page
    * Initial Release
* Sun Afternoon
    * Music
    * Music Release
    * Stretch
        * Level 4
        * Final Level Release

# Known Issues

* Player collision needs to be set to `infinite_inertia = false` for standing on boxes.  This causes the player's jump height to be damped if they are sliding along a tilemap wall.

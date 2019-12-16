# ColorPicker

A fully modular, interactive color wheel with optional saturation/brightness sliders written in pure SwiftUI.

## Setup

Add this repository as a Swift Package Dependency to your project. You find the option in Xcode unter "File > Swift Packages > Add Package Dependency...". Paste the HTTPS reference to this repo and you're done!

<aside class="notice">
    <b>YOU MUST</b> add an `.environmentObject(_:)` modifier to your top level View, do this in AppDelegate.swift or SceneDelegate.swift, depending on whichever platform(s) you are building your app for.
</aside>

## Usage

The `ColorPicker` structure is a control to select a hue value from 
an interactive wheel, across a full 360° plane. The current colour is shown on the 'thumb' of the track.

```swift
ColorPicker(strokeWidth: 50)

// The color wheel will take all the space it can get unless you frame it to a custom size. You are also able to specify the `strokeWidth` of the color wheel over the given property.
```

This is perfect for selecting a hue. For saturation and brightness, use the `ColorSlider` control:

```swift
ColorSlider(.saturation) // Present a linear slider for selecting a saturation value between 0...1.0

ColorSlider(.brightness) // Present a linear slider for selecting a brightness value between 0...1.0

```
You pass either `.saturation` or `.brightness` (depending on the desired control) to `ColorSlider`'s initialiser. You will notice that interaction to any of these controls instantly updates all the others!

##  Using the color selected by controls
Add this line to a View structure which needs to access the current color:
```swift
@EnvironmentObject var colorPickerConfig: ColorPickerConfig
```

Read on to discover the various ways to use the selected colour. 

## Mechanics
`ColorPicker` and `ColorSlider` make use of a shared EnvironmentObject (`ColorPickerConfig` — I know, ingenious naming). This is why you must add the modifier in your delegate file.

`ColorPickerConfig` has a few handy properties which you can use:

- `hue`, `saturation`,  `brightness` — self-explanatory (these are all marked with the `@Published` modifier so will update your `View`s)
- `uiColor` — A UIColor object dynamically constructed from HSB values. This is **not** a View-updating property.
- `color` — A SwiftUI Color object dynamically constructed from HSB values. This is **not** a View-updating property.
- `hex` — A hex code representing the current value. This is **not** a View-updating property.

A `.hex` computed property is also provided as an extension of UIColor. You're welcome.


## Credits

Many many thanks to Hendrik Ulbrich (@hendriku) for his excellent [color picker wheel](https://github.com/hendriku/ColorPicker).


## License

You can use this software under the terms and conditions of the MIT License.

Hendrik Ulbrich & Benji Burgess © 2019

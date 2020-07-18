# Changelog

## 2.0.0

- [BREAKING] This release drastically changes how the ADSR envelope works to speed up computation. The breaking change is how to the release phase slope is calculated. In the old model we've used a constant release time regardless of the release point whereas the new implementation keeps a constant release slope, making the release longer if the value of the ADSR was > sustain at the point of release

## 1.0.3

- [FEATURE] Updated drum presets

## 1.0.2

- [BUGFIX] Adsr was extremely buggy, hopefully better now

## 1.0.1

- [FEATURE] Make sure it works with Opal

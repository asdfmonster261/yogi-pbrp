# PitchBlack Recovery for the Pixel 11 Pro Fold (yogi) and malibu siblings

Device tree for building PBRP on the malibu (Tensor G6) family: yogi (Pixel 11 Pro
Fold), cubs, grizzly and kodiak. One recovery image serves all four; the device is
identified at runtime from `ro.hardware`.

Recovery rides in `vendor_boot` (there is no recovery partition on this platform).

Work in progress: boot bring-up. FBE / metadata decryption is deferred.

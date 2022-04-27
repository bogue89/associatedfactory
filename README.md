# AssociatedFactory

A factory class to manage instances associated to another instance.

### Uses

```swift
    let factory = AssociatedFactory<CustomPropery>()
    factory.instance(self, initializer: { CustomPropery() }, policy: .OBJC_ASSOCIATION_RETAIN)
```

**ShapecatcherKit** is an Objective-C framework for [shapecatcher.com](http://shapecatcher.com) that provides full support for the API to recognize unicode shapes from drawings and rate the results.

![](Screenshot.png)

The sample application included with this project demonstrates how to fully use the API but here are some code snippets.

First set your api key on the `sharedKit`:

``` obj-c
[[ShapecatcherKit sharedKit] setApiKey:ShapecatcherKitTestApiKey];
```

Then you can recognize `NSImage`s asynchronously:

``` obj-c
[[ShapecatcherKit sharedKit] recognizeFromImage:image withSuccess:^(NSArray *shapes) {
    NSLog(@"%@", shapes);
} andFailure:nil];
```

The `shapes` array contains `SKShape` objects with all the data from the api. This object also allows you to asynchronously request an image of the shape and rate how well the shape matches the drawing:

``` obj-c
[shape requestCharacterImageWithSuccess:^(NSImage *image){
    NSLog(@"%@", image);
} andFailure:nil];
```

``` obj-c
[shape setRating:SKShapeGoodRating withSuccess:^(){
    NSLog(@"%@", image);
} andFailure:nil];
```

Shapes can be rated good(`SKShapeGoodRating`) bad(`SKShapeBadRating`) or the previous rating can be undone with undo(`SKShapeUndoRating`).

*Please note the sample app does not include drawing code, it's purpose is only to demonstrate how to use the api*

# react-native-threads

Spawn new react native JavaScript processes for CPU intensive work outside of your main UI JavaScript process.

**PS:** Supports Preloading in iOS with support for turbo module in progress.

Despite this package's name, this isn't real 'threading', but rather multi-processing.
The main tradeoff of using this library is memory usage, as creating new JS processes
can have significant overhead. Be sure to benchmark your app's memory usage and other
resources before using this library! Alternative solutions include using `runAfterInteractions`
or the [Interaction Manager](https://facebook.github.io/react-native/docs/interactionmanager.html),
and I recommend you investigate those thoroughly before using this library.

**Note:** This is an updated folk of [react-native-threads](https://github.com/joltup/react-native-threads)

## Getting Started

### iOS

`pod install`

### Android

1. For android you will need to make a slight modification to your `MainApplication.java`

Import

```
import com.reactlibrary.RNThreadPackage;
```

In the `getPackages` method pass in `mReactNativeHost` to the `RNThreadPackage`

constructor:

```java
        List<ReactPackage> packages = new PackageList(this).getPackages(
          );
          packages.add(new RNThreadPackage(mReactNativeHos
```

Also note that only the official react native modules are available from your
threads (vibration, fetch, etc...). To include additional native modules in your
threads, pass them into the `RNThreadPackage` constructor after the `mReactNativeHost`
like this:
`new RNThreadPackage(mReactNativeHost, new ExampleNativePackage(), new SQLitePackage())`

2. Append the following lines to `android/settings.gradle`:
   ```
   include ':react-native-threads'
   project(':react-native-threads').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-threads/android')
   ```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:

   ```
     implementation project(':react-native-threads')
   ```

4. Create `react-native.config.js` in your root

and add following

```
// react-native.config.js
module.exports = {
  dependencies: {
    'react-native-threads': {
      platforms: {
        android: null,
      },
    },
  },
};
```

## Usage

[Example repo](https://github.com/irohitb/rn-pre-threading)
[background preload thread in iOS](https://github.com/irohitb/rn-pre-threading/commit/1838ae35c8a2b8796a12fcf42bcf96942de7d050)
[JS Code example](https://github.com/irohitb/rn-pre-threading/blob/master/App.tsx)

### Preloading (iOS only)

```
#import "RNThreadHandler.h"
  [[RNThreadHandler sharedInstance] startNewThread:@"./worker.thread" threadId:@"test2"];
```

### Threads Api

In your application code (react components, etc.):

```javascript
import {Thread} from 'react-native-threads';

// start a new react native JS process
new Thread('./second.thread.js', 'test1');

// send a message, strings only
thread.postMessage('hello');

// listen for messages
thread.onMessage = message => console.log(message);

// stop the JS process
thread.terminate();
```

## Working with Existing thread passed from native side..

```
import {ExistingThread} from 'react-native-threads'

const thread = new ExistingThread(threadId);

// send a message, strings only
thread.postMessage('hello');

// listen for messages
thread.onMessage = message => console.log(message);

// stop the JS process
thread.terminate();
```

### Get all threads ID's

```
import {getThreadsId} from 'react-native-threads'


const ids = getThreadsId();
```

### External Thread

In your thread code (dedicated file such as `thread.js`):

```javascript
import {self} from 'react-native-threads';

// listen for messages
self.onMessage = message => {};

// send a message, strings only
self.postMessage('hello');
```

Check out the [example directory](https://github.com/irohitb/rn-pre-threading)

### Thread Lifecycle

- Threads are paused when the app enters in the background
- Threads are resumed once the app is running in the foreground
- During development, when you reload the main JS bundle (shake device -> `Reload`) the threads are killed

### Debugging

Instantiating Threads creates multiple react native JS processes and can make debugging
remotely behave unpredictably. I recommend using a third party debugging tool like
[Reactotron](https://github.com/infinitered/reactotron) to aid with this. Each process,
including your main application as well as your thread code can connect to Reactotron
and log debugging messages.

### Building for Release

You will need to manually bundle your thread files for use in a production release
of your app. This documentation assumes you have a single thread file called
`index.thread.js` in your project root. If your file is named differently or in
a different location, you can update the documented commands accordingly.

**Note**: If your single thread file is in a different location, the folder structure needs to
be replicated under `./ios` and `./android/app/src/main/assets/threads`.

```
./App/Workers/worker.thread.js => ./ios/App/Workers/worker.thread.jsbundle
./App/Workers/worker.thread.js => ./android/app/src/main/assets/threads/App/Workers/worker.thread.jsbundle
```

For iOS you can use the following command:

`node node_modules/react-native/local-cli/cli.js bundle --dev false --assets-dest ./ios --entry-file index.thread.js --platform ios --bundle-output ./ios/index.thread.jsbundle`

Once you have generated the bundle file in your ios folder, you will also need to add
the bundle file to you project in Xcode. In Xcode's file explorer you should see
a folder with the same name as your app, containing a `main.jsbundle` file as well
as an `appDelegate.m` file. Right click on that folder and select the 'Add Files to <Your App Name>'
option, which will open up finder and allow you to select your `ios/index.thread.jsbundle`
file. You will only need to do this once, and the file will be included in all future
builds.

For Android create this direactory
`mkdir ./android/app/src/main/assets/threads`

And then you can use the following command:

`node node_modules/react-native/local-cli/cli.js bundle --dev false --assets-dest ./android/app/src/main/res/ --entry-file index.thread.js --platform android --bundle-output ./android/app/src/main/assets/threads/index.thread.bundle`

For convenience I recommend adding these thread building commands as npm scripts
to your project.

## Acknowledgements

This library was heavily inspired by two other packages both under the name of
`react-native-workers`.

The first was https://github.com/fabriciovergal/react-native-workers ,
and the second was https://github.com/devfd/react-native-workers

I ended up going with devfd's implementation strategy as it seemed more flexible
and feature-rich to me. At the time of this writing neither library was functioning
on the latest version of react native, and neither seemed to be very actively maintained.

This library would not exist without those two reference implementations to guide me!

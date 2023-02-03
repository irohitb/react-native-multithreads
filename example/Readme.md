## Installation

- `yarn install`

### For ios

- `cd ios && pod install`

## Notes

This repo fixes (iOS only) `react-native-threads` lib, adds more api's and allows you to pre-load threads in react native. To view the new repo with all the changes, [click here](https://github.com/irohitb/react-native-multithreads)

In this repo, I have used patch-package to implement all the changes in `react-native-threads` repo

## Fixes

- [x] iOS auto linking
- [x] Bundle provider depreciated API fix
- [x] Metro bundler fixes
- [x] On terminate remove listener as well

## What's new:

### Preloading

```
#import "RNThreadHandler.h"
  [[RNThreadHandler sharedInstance] startNewThread:@"./worker.thread" threadId:@"test2"];
```

### API's

#### Thread now takes `id` as a new params

```
new Thread('./second.thread.js', 'test1');
```

This will help you in better managing thread.

If thread with passed id already exist, it will throw error

#### `getThreadsId`

Since thread is being started from Native Side, now we can also get all the running threads.

```
import {getThreadsId} from 'react-native-threads'
```

#### `ExistingThread`

```
import {ExistingThread} from 'react-native-threads'
```

and the use like this

```
new ExistingThread(threadId);
```

#### Get All Message in Threads

```
import {
getAllMessagesInThread,
} from 'react-native-threads';

getAllMessagesInThread
```

This would give all messages send from `self` thread. Interface for which would be

```
export interface ThreadMessageInterface {
  threadId: string;
  message: string;
  parentBridgeExisted: boolean;
}
```

#### Typescript

Added support for typescript

### Notes

- [x] Threads are already loaded async in groups
- [x] with this you can preload thread Manager
- [x] RCT Exports runs on background thread.

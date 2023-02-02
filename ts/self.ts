import {NativeEventEmitter, NativeModules} from 'react-native';

const {ThreadSelfManager} = NativeModules;

export type Self = {
  postMessage(message: string): void;
  onMessage?(message: string): void;
};

const threadEventEmitter = new NativeEventEmitter(ThreadSelfManager);

const self: Self = {
  onMessage: undefined,
  postMessage: (msg: string) => {
    if (!msg) {
      return;
    }
    ThreadSelfManager.postMessage(msg);
  },
};

threadEventEmitter.addListener('ThreadMessage', (message: string) => {
  if (self.onMessage) {
    self.onMessage(message);
  }
});

export default self;

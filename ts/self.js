import { NativeEventEmitter, NativeModules } from 'react-native';
const { ThreadSelfManager } = NativeModules;
const threadEventEmitter = new NativeEventEmitter(ThreadSelfManager);
const self = {
    onMessage: undefined,
    postMessage: (msg) => {
        if (!msg) {
            return;
        }
        ThreadSelfManager.postMessage(msg);
    },
};
threadEventEmitter.addListener('ThreadMessage', (message) => {
    if (self.onMessage) {
        self.onMessage(message);
    }
});
export default self;

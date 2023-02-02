import { NativeModules, NativeEventEmitter, } from 'react-native';
const { ThreadManager } = NativeModules;
const threadEventEmitter = new NativeEventEmitter(ThreadManager);
export default class ExistingThread {
    threadId;
    id;
    threadListener;
    onError;
    constructor(threadId, onError) {
        this.threadId = threadId;
        this.getExistingThread();
        this.onError = onError;
    }
    getExistingThread() {
        this.id = ThreadManager.getExistingThread(this.threadId).then((id) => {
            this.threadListener = threadEventEmitter.addListener(`Thread${id}`, (message) => {
                if (this.onMessage) {
                    this.onMessage(message);
                }
            });
            return id;
        }).catch((e) => {
            {
                this.onError();
            }
        });
    }
    terminate() {
        if (this.id) {
            this.id.then(ThreadManager.stopThread);
            this.threadListener?.remove();
        }
    }
    postMessage(msg) {
        if (this.id) {
            this.id.then(id => {
                ThreadManager.postThreadMessage(id, msg);
            });
        }
    }
}

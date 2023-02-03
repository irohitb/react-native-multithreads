import { NativeModules, NativeEventEmitter, } from 'react-native';
const { ThreadManager } = NativeModules;
const threadEventEmitter = new NativeEventEmitter(ThreadManager);
export default class Thread {
    path;
    threadId;
    id;
    threadListener;
    errorHandler;
    constructor(jsPath, threadId) {
        if (!jsPath.endsWith('.js')) {
            throw new Error('Invalid path for thread. Only js files are supported');
        }
        this.path = jsPath;
        this.threadId = threadId;
        this.startThread();
    }
    startThread() {
        console.log('Thread Manager:', NativeModules);
        this.id = ThreadManager.startThread(this.path.replace('.js', ''), this.threadId)
            .then((id) => {
            this.threadListener = threadEventEmitter.addListener(`Thread${id}`, (message) => {
                if (this.onMessage) {
                    this.onMessage(message);
                }
            });
            return id;
        })
            .catch((err) => {
            if (this.errorHandler) {
                this.errorHandler(err);
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
export const getThreadsId = async () => {
    const threadIds = await ThreadManager.getThreadsId();
    return Object.keys(threadIds);
};
export const getAllMessagesInThread = async () => {
    const messages = await ThreadManager.getAllMessages();
    return Object.values(messages);
};

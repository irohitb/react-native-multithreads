import {
  NativeModules,
  NativeEventEmitter,
  EmitterSubscription,
} from 'react-native';

export interface ThreadInterface {
  postMessage(msg: string): void;
  terminate(): void;
}

const {ThreadManager} = NativeModules;

const threadEventEmitter = new NativeEventEmitter(ThreadManager);

export default class ExistingThread implements ThreadInterface {
  threadId: string;
  id?: Promise<any>;
  threadListener?: EmitterSubscription;
  onMessage?(msg: string): void;
  onError: () => void
  constructor(threadId: string, onError: () => void) {
    this.threadId = threadId;
    this.getExistingThread();
    this.onError = onError
  }

  public getExistingThread() {
    this.id = ThreadManager.getExistingThread(this.threadId).then((id: string) => {

      this.threadListener = threadEventEmitter.addListener(
        `Thread${id}`,
        (message: string) => {
          if (this.onMessage) {
            this.onMessage(message);
          }
        },
      );
      return id;
    }).catch((e:string) => {{
      this.onError()
    }})
  }

  public terminate(): void {
    if (this.id) {
      this.id.then(ThreadManager.stopThread);
      this.threadListener?.remove();
    }
  }

  postMessage(msg: string): void {
    if (this.id) {
      this.id.then(id => {
        ThreadManager.postThreadMessage(id, msg);
      });
    }
  }
}

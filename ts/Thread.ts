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

export default class Thread implements ThreadInterface {
  path: string;
  threadId: string;
  id?: Promise<any>;
  threadListener?: EmitterSubscription;
  onMessage?(msg: string): void;
  errorHandler?: (msg: string) => void;
  constructor(jsPath: string, threadId: string) {
    if (!jsPath.endsWith('.js')) {
      throw new Error('Invalid path for thread. Only js files are supported');
    }
    this.path = jsPath;
    this.threadId = threadId;
    this.startThread();
  }

  private startThread() {
    console.log('Thread Manager:', NativeModules);
    this.id = ThreadManager.startThread(
      this.path.replace('.js', ''),
      this.threadId,
    )
      .then((id: string) => {
        this.threadListener = threadEventEmitter.addListener(
          `Thread${id}`,
          (message: string) => {
            if (this.onMessage) {
              this.onMessage(message);
            }
          },
        );
        return id;
      })
      .catch((err: string) => {
        if (this.errorHandler) {
          this.errorHandler(err);
        }
      });
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

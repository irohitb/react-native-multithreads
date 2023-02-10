import {
  NativeModules,
  NativeEventEmitter,
  EmitterSubscription,
  Platform,
} from "react-native";

// @ts-expect-error
const isTurboModuleEnabled = global.__turboModuleProxy != null;

const { ThreadManager } = NativeModules;

const ThreadModule = isTurboModuleEnabled
  ? require("./NativeThread").default
  : ThreadManager;

const ThreadEvents = new NativeEventEmitter(ThreadModule);

export interface ThreadInterface {
  postMessage(msg: string): void;
  terminate(): void;
}

export interface ThreadMessageInterface {
  threadId: string;
  message: string;
  parentBridgeExisted: boolean;
}

export default class Thread implements ThreadInterface {
  path: string;
  threadId: string;
  id?: Promise<any>;
  threadListener?: EmitterSubscription;
  onMessage?(msg: string): void;
  errorHandler?: (msg: string) => void;
  constructor(jsPath: string, threadId: string) {
    if (!jsPath.endsWith(".js")) {
      throw new Error("Invalid path for thread. Only js files are supported");
    }
    this.path = jsPath;
    this.threadId = threadId;
    this.startThread();
  }

  private startThread() {
    this.id = ThreadManager.startThread(
      this.path.replace(".js", ""),
      this.threadId
    )
      .then((id: string) => {
        this.threadListener = ThreadEvents.addListener(
          `Thread${id}`,
          (message: string) => {
            if (this.onMessage) {
              this.onMessage(message);
            }
          }
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
      this.id.then((id) => {
        ThreadManager.postThreadMessage(id, msg);
      });
    }
  }
}

export const getThreadsId = async (): Promise<String[]> => {
  const threadIds = await ThreadManager.getThreadsId();
  return Object.keys(threadIds);
};

export const getAllMessagesInThread = async (): Promise<
  ThreadMessageInterface[]
> => {
  const messages = await ThreadManager.getAllMessages();
  if (Platform.OS === "android") {
    return Object.values(JSON.parse(messages));
  }
  return Object.values(messages);
};

import { EmitterSubscription } from 'react-native';
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
    constructor(jsPath: string, threadId: string);
    private startThread;
    terminate(): void;
    postMessage(msg: string): void;
}
export declare const getThreadsId: () => Promise<String[]>;
export declare const getAllMessagesInThread: () => Promise<ThreadMessageInterface[]>;

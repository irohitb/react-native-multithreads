import { EmitterSubscription } from 'react-native';
export interface ThreadInterface {
    postMessage(msg: string): void;
    terminate(): void;
}
export default class ExistingThread implements ThreadInterface {
    threadId: string;
    id?: Promise<any>;
    threadListener?: EmitterSubscription;
    onMessage?(msg: string): void;
    onError: () => void;
    constructor(threadId: string, onError: () => void);
    getExistingThread(): void;
    terminate(): void;
    postMessage(msg: string): void;
}

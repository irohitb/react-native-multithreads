import type { TurboModule } from "react-native";
import { TurboModuleRegistry } from "react-native";

export interface Spec extends TurboModule {
  startThread: (path: string, threadId: string) => Promise<string>;
  getExistingThread: (threadId: string) => Promise<string>;
  terminate: (threadId: string) => void;
  postMessage: (threadId: string, msg: string) => void;
  addListener(eventName: string): void;
  removeListeners: () => void;
}

export default TurboModuleRegistry.getEnforcing<Spec>("ThreadManager");

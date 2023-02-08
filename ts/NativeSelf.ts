import type { TurboModule } from "react-native";
import { TurboModuleRegistry } from "react-native";

export interface Spec extends TurboModule {
  postMessage: (message: string) => void;
  addListener(eventName: string): void;
  removeListeners: () => void;
}

export default TurboModuleRegistry.getEnforcing<Spec>("ThreadSelfManager");

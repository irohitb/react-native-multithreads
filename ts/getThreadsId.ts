import {NativeModules, NativeEventEmitter} from 'react-native';

const {ThreadManager} = NativeModules;

const getThreadsId = async (): Promise<String[]> => {
  const threadIds = await ThreadManager.getThreadsId();
  return Object.keys(threadIds);
};

export default getThreadsId;

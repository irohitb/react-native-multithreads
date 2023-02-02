import { NativeModules } from 'react-native';
const { ThreadManager } = NativeModules;
const getThreadsId = async () => {
    const threadIds = await ThreadManager.getThreadsId();
    return Object.keys(threadIds);
};
export default getThreadsId;

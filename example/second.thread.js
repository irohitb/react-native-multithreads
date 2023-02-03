import {self} from 'react-native-threads';

console.log('Second Worker thread at', Date.now());
let count = 0;

self.onMessage = message => {
  try {
    console.log(`Prom THREAD: got message ${message}`);

    count++;

    self.postMessage(`Second Thread message #${count} from worker thread!`);
  } catch (e) {
    console.log('Error Thread:', e);
  }
};

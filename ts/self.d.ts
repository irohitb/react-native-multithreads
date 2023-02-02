export type Self = {
    postMessage(message: string): void;
    onMessage?(message: string): void;
};
declare const self: Self;
export default self;

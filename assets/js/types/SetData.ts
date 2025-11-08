export type SetData<T> = (
    key: keyof T | ((prevData: T) => Partial<T>),
    value?: any,
) => void;

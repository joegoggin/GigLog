import { SetData } from "@/types/SetData";
import { ChangeEvent } from "react";

type CheckboxProps<T> = {
    className?: string;
    label: string;
    name: keyof T;
    data: T;
    setData: SetData<T>;
};

const Checkbox = <T,>({
    className = "",
    label,
    name,
    data,
    setData,
}: CheckboxProps<T>) => {
    const handleChange = (e: ChangeEvent<HTMLInputElement>) => {
        setData(name, e.target.checked);
    };

    return (
        <div className={`checkbox ${className}`}>
            <input
                type="checkbox"
                onChange={handleChange}
                checked={data[name] as boolean}
            />
            <label>{label}</label>
        </div>
    );
};

export default Checkbox;

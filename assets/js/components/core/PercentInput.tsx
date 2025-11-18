import { SetData } from "@/types/SetData";
import { ChangeEvent } from "react";

type PercentInputProps<T> = {
    className?: string;
    placeholder?: string;
    name: keyof T;
    data: T;
    setData: SetData<T>;
};

const PercentInput = <T,>({
    className = "",
    placeholder = "",
    name,
    data,
    setData,
}: PercentInputProps<T>) => {
    const handleChange = (e: ChangeEvent<HTMLInputElement>) => {
        e.preventDefault();

        setData(name, e.target.value);
    };

    return (
        <div className={`percent-input ${className}`}>
            <label>{placeholder}</label>
            <div className="percent-input__percent-container">
                <input
                    type="number"
                    min="0"
                    max="100"
                    step="1"
                    value={data[name] as number}
                    onChange={handleChange}
                />
                <h3>%</h3>
            </div>
        </div>
    );
};

export default PercentInput;

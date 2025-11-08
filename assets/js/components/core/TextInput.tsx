import { SetData } from "@/types/SetData";
import { ChangeEvent, useEffect, useState } from "react";
import { capitalize } from "@/utils/capitalize";
import { usePage } from "@inertiajs/react";

type TextInputProps<T> = {
    className?: string;
    label?: string;
    placeholder?: string;
    name: keyof T;
    data: T;
    setData: SetData<T>;
    password?: boolean;
};

const TextInput = <T,>({
    className,
    label,
    placeholder = "",
    name,
    data,
    setData,
    password,
}: TextInputProps<T>) => {
    const [classes, setClasses] = useState<string>("text-input");
    const [userEditing, setUserEditing] = useState<boolean>(false);
    const [error, setError] = useState<string>();

    const { props } = usePage();

    const handleChange = (e: ChangeEvent<HTMLInputElement>) => {
        setData(name, e.target.value);
        setUserEditing(true);
    };

    useEffect(() => {
        const newError = props.errors[name as string];

        if (newError) {
            setError(newError);
            setUserEditing(false);
        }
    }, [props]);

    useEffect(() => {
        let newClasses = "text-input";

        if (error && !userEditing) {
            newClasses += " text-input--error";
        }

        if (className) {
            newClasses += ` ${className}`;
        }

        setClasses(newClasses);
    }, [error, userEditing, className]);

    const getErrorString = () => {
        let formated_name = "";
        const split = (name as string).split("_");

        split.forEach((str) => {
            formated_name += `${capitalize(str)} `;
        });

        return `${formated_name}${error}`;
    };

    return (
        <div className={classes}>
            {label && <label>{label}</label>}
            <input
                type={password ? "password" : "text"}
                placeholder={placeholder}
                onChange={handleChange}
                value={data[name] as string}
            />
            {error && !userEditing && <p>{getErrorString()}</p>}
        </div>
    );
};

export default TextInput;

import { FormEvent, ReactNode } from "react";

type FormProps = {
    className?: string;
    onSubmit: () => void;
    children: ReactNode;
};

const Form: React.FC<FormProps> = ({ className = "", onSubmit, children }) => {
    const handleSubmit = (e: FormEvent) => {
        e.preventDefault();

        const allInputs = document.querySelectorAll("input");

        allInputs.forEach((input) => {
            input.blur();
        });

        onSubmit();
    };

    return (
        <form className={`form ${className}`} onSubmit={handleSubmit}>
            {children}
        </form>
    );
};

export default Form;

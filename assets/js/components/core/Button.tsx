import { router } from "@inertiajs/react";
import { ReactNode, MouseEvent } from "react";

export enum ButtonVariant {
    PRIMARY,
    SECONDARY,
}

type ButtonProps = {
    className?: string;
    type?: "submit" | "button" | "reset";
    href?: string;
    onClick?: (e?: any) => void;
    variant?: ButtonVariant;
    children: ReactNode;
};

const Button: React.FC<ButtonProps> = ({
    className,
    type = "button",
    href,
    onClick,
    variant = ButtonVariant.PRIMARY,
    children,
}) => {
    const handleClick = (e: MouseEvent<HTMLButtonElement>) => {
        if (type != "submit") {
            e.preventDefault();
        }

        if (onClick) {
            onClick();
        }

        if (href) {
            router.get(href);
        }
    };

    const getClassName = () => {
        let classes = `button`;

        switch (variant) {
            case ButtonVariant.PRIMARY:
                classes += " button--primary";
                break;
            case ButtonVariant.SECONDARY:
                classes += " button--secondary";
        }

        if (className) {
            classes += ` ${className}`;
        }

        return classes;
    };

    return (
        <button type={type} className={getClassName()} onClick={handleClick}>
            {children}
        </button>
    );
};

export default Button;

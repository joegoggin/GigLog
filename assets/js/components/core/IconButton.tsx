import { router } from "@inertiajs/react";
import { ReactNode, MouseEvent } from "react";

type IconButtonProps = {
    className?: string;
    href?: string;
    onClick?: (e?: any) => void;
    icon: ReactNode;
    label?: ReactNode;
};

const IconButton: React.FC<IconButtonProps> = ({
    className = "",
    href,
    onClick,
    icon,
    label,
}) => {
    const handleClick = (e: MouseEvent<HTMLElement>) => {
        e?.preventDefault();

        if (href) {
            router.get(href);
        }

        if (onClick) {
            onClick();
        }
    };

    return (
        <div className={`icon-button ${className}`} onClick={handleClick}>
            {icon}
            {label && <p>{label}</p>}
        </div>
    );
};

export default IconButton;

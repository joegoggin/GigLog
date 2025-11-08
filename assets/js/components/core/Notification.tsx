import CheckIcon from "@/components/icons/CheckIcon";
import CloseIcon from "@/components/icons/CloseIcon";
import ErrorIcon from "@/components/icons/ErrorIcon";
import InfoIcon from "@/components/icons/InfoIcon";
import WarningIcon from "@/components/icons/WarningIcon";
import { AnimatePresence, motion } from "motion/react";
import { useState } from "react";

export enum NotificationType {
    INFO = "info",
    WARNING = "warning",
    SUCCESS = "success",
    ERROR = "error",
}

export type NotificationProps = {
    type: NotificationType;
    title: string;
    message: string;
};

const Notification: React.FC<NotificationProps> = ({
    title,
    type,
    message,
}) => {
    const [showNotification, setShowNotification] = useState<boolean>(true);

    const getClassName = () => {
        let classes = "flash";

        switch (type) {
            case NotificationType.INFO:
                classes += " flash--info";
                break;
            case NotificationType.WARNING:
                classes += " flash--warning";
                break;
            case NotificationType.SUCCESS:
                classes += " flash--success";
                break;
            case NotificationType.ERROR:
                classes += " flash--error";
                break;
        }

        return classes;
    };

    const getIcon = () => {
        switch (type) {
            case NotificationType.INFO:
                return <InfoIcon />;
            case NotificationType.WARNING:
                return <WarningIcon />;
            case NotificationType.SUCCESS:
                return <CheckIcon />;
            case NotificationType.ERROR:
                return <ErrorIcon />;
        }
    };

    const handleClose = () => {
        setShowNotification(false);
    };

    return (
        <AnimatePresence>
            {showNotification && (
                <motion.div
                    initial={{ opacity: 0, scale: 0 }}
                    animate={{ opacity: 1, scale: 1 }}
                    exit={{ opacity: 0, scale: 0 }}
                    transition={{ duration: 0.3 }}
                    className={getClassName()}
                >
                    <div className="flash__info">{getIcon()}</div>
                    <div className="flash__message">
                        <h5>{title}</h5>
                        <p>{message}</p>
                    </div>
                    <div
                        className="flash__close"
                        onClick={handleClose}
                        role="button"
                    >
                        <CloseIcon />
                    </div>
                </motion.div>
            )}
        </AnimatePresence>
    );
};

export default Notification;

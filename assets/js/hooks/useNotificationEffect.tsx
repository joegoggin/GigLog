import { NotificationType } from "@/components/core/Notification";
import { Flash } from "@/types/Flash";
import { usePage } from "@inertiajs/react";
import { useEffect } from "react";

type PageProps = {
    flash: Flash;
};

export const useNotificationEffect = (
    callback: () => void,
    notificationType: NotificationType,
) => {
    const {
        props: {
            flash: { notifications },
        },
    } = usePage<PageProps>();

    useEffect(() => {
        if (notifications) {
            for (const notification of notifications) {
                if (notification.type === notificationType) {
                    callback();
                    break;
                }
            }
        }
    }, [notifications]);
};

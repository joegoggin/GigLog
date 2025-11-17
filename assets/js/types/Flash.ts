import { NotificationProps } from "@/components/core/Notification";
import { DeleteModalProps } from "@/components/modals/DeleteModal";

export type Flash = {
    notifications?: NotificationProps[];
    modal?: {
        delete?: Omit<DeleteModalProps, "showModal" | "setShowModal">;
    };
};

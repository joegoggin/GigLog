import Notification from "@/components/core/Notification";
import DeleteModal from "@/components/modals/DeleteModal";
import { Flash } from "@/types/Flash";
import { LayoutProps } from "@/types/LayoutProps";
import { Head, usePage } from "@inertiajs/react";
import { useEffect, useState } from "react";

type PageProps = {
    flash: Flash;
};

const RootLayout: React.FC<LayoutProps> = ({
    className = "",
    title,
    description,
    children,
}) => {
    const [showDeleteModal, setShowDeleteModal] = useState<boolean>(false);

    const {
        props: {
            flash: { notifications, modal },
        },
    } = usePage<PageProps>();

    useEffect(() => {
        const prefersDark = window.matchMedia(
            "(prefers-color-scheme: dark)",
        ).matches;
        const theme = prefersDark ? "dark" : "light";

        document.documentElement.setAttribute("data-theme", theme);
    }, []);

    useEffect(() => {
        if (modal?.delete) {
            setShowDeleteModal(true);
        } else {
            setShowDeleteModal(false);
        }
    }, [modal]);

    return (
        <>
            <Head>
                {title && <title>{title}</title>}
                {description && (
                    <meta name="description" content={description} />
                )}
            </Head>
            <div className={`root-layout ${className}`}>
                <div className="root-layout__notifications">
                    {notifications?.map((props, index) => (
                        <Notification key={index} {...props} />
                    ))}
                </div>
                {children}
            </div>
            {showDeleteModal && modal?.delete && (
                <DeleteModal
                    showModal={showDeleteModal}
                    setShowModal={setShowDeleteModal}
                    {...modal.delete}
                />
            )}
        </>
    );
};

export default RootLayout;

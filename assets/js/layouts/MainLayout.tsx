import Notification, {
    NotificationProps,
} from "@/components/core/Notification";
import { Head, usePage } from "@inertiajs/react";
import { ReactNode, useEffect } from "react";

type MainLayoutProps = {
    className?: string;
    title?: string;
    description?: string;
    children: ReactNode;
};

type PageProps = {
    flash: {
        notifications?: NotificationProps[];
    };
};

const MainLayout: React.FC<MainLayoutProps> = ({
    className = "",
    title,
    description,
    children,
}) => {
    const {
        props: {
            flash: { notifications },
        },
    } = usePage<PageProps>();

    useEffect(() => {
        const prefersDark = window.matchMedia(
            "(prefers-color-scheme: dark)",
        ).matches;
        const theme = prefersDark ? "dark" : "light";

        document.documentElement.setAttribute("data-theme", theme);
    }, []);

    return (
        <>
            <Head>
                {title && <title>{title}</title>}
                {description && (
                    <meta name="description" content={description} />
                )}
            </Head>
            <div className={`main-layout ${className}`}>
                <div className="main-layout__notifications">
                    {notifications?.map((props) => (
                        <Notification {...props} />
                    ))}
                </div>
                {children}
            </div>
        </>
    );
};

export default MainLayout;

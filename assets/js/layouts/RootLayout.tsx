import Notification from "@/components/core/Notification";
import { Flash } from "@/types/Flash";
import { LayoutProps } from "@/types/LayoutProps";
import { Head, usePage } from "@inertiajs/react";
import { useEffect } from "react";

type PageProps = {
    flash: Flash;
};

const RootLayout: React.FC<LayoutProps> = ({
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
            <div className={`root-layout ${className}`}>
                <div className="root-layout__notifications">
                    {notifications?.map((props) => <Notification {...props} />)}
                </div>
                {children}
            </div>
        </>
    );
};

export default RootLayout;

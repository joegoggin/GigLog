import CompanyIcon from "@/components/icons/CompanyIcon";
import HomeIcon from "@/components/icons/HomeIcon";
import JobsIcon from "@/components/icons/JobsIcon";
import LogOutIcon from "@/components/icons/LogOutIcon";
import PaymentIcon from "@/components/icons/PaymentIcon";
import SettingsIcon from "@/components/icons/SettingsIcon";
import RootLayout from "@/layouts/RootLayout";
import { LayoutProps } from "@/types/LayoutProps";
import { router, usePage } from "@inertiajs/react";

const MainLayout: React.FC<LayoutProps> = ({
    className,
    title,
    description,
    children,
}) => {
    const { url } = usePage();

    const handleClick = (path: string) => {
        if (path === "/auth/log-out") {
            router.delete(path);
            return;
        }

        router.get(path);
    };

    const getClassName = (path: string) => {
        let classes = "main-layout__menu-item";

        if (path == url) {
            classes += " main-layout__menu-item--active";
        }

        return classes;
    };

    return (
        <RootLayout
            className="main-layout"
            title={title}
            description={description}
        >
            <div className="main-layout__sidebar">
                <div className="main-layout__hamburger">
                    <h5>GigLog</h5>
                </div>
                <div className="main-layout__menu">
                    <div
                        className={getClassName("/dashboard")}
                        onClick={() => handleClick("/dashboard")}
                        role="button"
                    >
                        <HomeIcon />
                        <p>Dashboard</p>
                    </div>
                    <div
                        className={getClassName("/companies")}
                        onClick={() => handleClick("/companies")}
                        role="button"
                    >
                        <CompanyIcon />
                        <p>Companies</p>
                    </div>
                    <div
                        className={getClassName("/jobs")}
                        onClick={() => handleClick("/jobs")}
                        role="button"
                    >
                        <JobsIcon />
                        <p>Jobs</p>
                    </div>
                    <div
                        className={getClassName("/payments")}
                        onClick={() => handleClick("/payments")}
                        role="button"
                    >
                        <PaymentIcon />
                        <p>Payments</p>
                    </div>
                    <div
                        className={getClassName("/settings")}
                        onClick={() => handleClick("/settings")}
                        role="button"
                    >
                        <SettingsIcon />
                        <p>Settings</p>
                    </div>
                </div>
                <div
                    className="main-layout__menu-item main-layout__log-out"
                    onClick={() => handleClick("/auth/log-out")}
                    role="button"
                >
                    <LogOutIcon />
                    <p>Log Out</p>
                </div>
            </div>
            <div className={`main-layout__content ${className}`}>
                {children}
            </div>
        </RootLayout>
    );
};

export default MainLayout;

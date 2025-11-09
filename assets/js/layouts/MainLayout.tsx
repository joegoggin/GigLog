import CompanyIcon from "@/components/icons/CompanyIcon";
import HomeIcon from "@/components/icons/HomeIcon";
import JobsIcon from "@/components/icons/JobsIcon";
import LogOutIcon from "@/components/icons/LogOutIcon";
import PaymentIcon from "@/components/icons/PaymentIcon";
import RootLayout from "@/layouts/RootLayout";
import { LayoutProps } from "@/types/LayoutProps";

const MainLayout: React.FC<LayoutProps> = ({
    className,
    title,
    description,
    children,
}) => {
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
                    <div className="main-layout__menu-item main-layout__menu-item--active">
                        <HomeIcon />
                        <p>Dashboard</p>
                    </div>
                    <div className="main-layout__menu-item">
                        <CompanyIcon />
                        <p>Companies</p>
                    </div>
                    <div className="main-layout__menu-item">
                        <JobsIcon />
                        <p>Jobs</p>
                    </div>
                    <div className="main-layout__menu-item">
                        <PaymentIcon />
                        <p>Payments</p>
                    </div>
                </div>
                <div className="main-layout__menu-item main-layout__log-out">
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

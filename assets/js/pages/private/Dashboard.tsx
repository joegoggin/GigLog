import Button from "@/components/core/Button";
import MainLayout from "@/layouts/MainLayout";
import { router } from "@inertiajs/react";

const DashboardPage: React.FC = () => {
    const handleClick = () => {
        router.delete("/log-out");
    };

    return (
        <MainLayout className="dashboard-page" title="Dashboard">
            <h1>Dashboard Page</h1>
            <Button onClick={handleClick}>Log Out</Button>
        </MainLayout>
    );
};

export default DashboardPage;

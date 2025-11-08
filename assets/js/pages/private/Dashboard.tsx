import Button from "@/components/core/Button";
import FullscreenCenteredLayout from "@/layouts/FullScreenCenteredLayout";
import { router } from "@inertiajs/react";

const DashboardPage: React.FC = () => {
    const handleClick = () => {
        router.delete("/log-out");
    };

    return (
        <FullscreenCenteredLayout className="dashboard-page" title="Dashboard">
            <h1>Dashboard Page</h1>
            <Button onClick={handleClick}>Log Out</Button>
        </FullscreenCenteredLayout>
    );
};

export default DashboardPage;

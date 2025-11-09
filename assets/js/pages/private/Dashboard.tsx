import Button from "@/components/core/Button";
import FullscreenCenteredLayout from "@/layouts/FullScreenCenteredLayout";
import { router, usePage } from "@inertiajs/react";
import { useEffect } from "react";

const DashboardPage: React.FC = () => {
    const { props } = usePage();
    const handleClick = () => {
        router.delete("/log-out");
    };

    useEffect(() => {
        console.log(props);
    }, [props]);

    return (
        <FullscreenCenteredLayout className="dashboard-page" title="Dashboard">
            <h1>Dashboard Page</h1>
            <Button onClick={handleClick}>Log Out</Button>
        </FullscreenCenteredLayout>
    );
};

export default DashboardPage;

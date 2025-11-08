import Button from "@/components/core/Button";
import FullscreenCenteredLayout from "@/layouts/FullScreenCenteredLayout";

const InvalidTokenPage: React.FC = () => {
    return (
        <FullscreenCenteredLayout className="invalid-token-page">
            <h1>Log In Failed!</h1>
            <h4>Error: Token provided is invalid!</h4>
            <Button href={"/auth/login"}>Log In</Button>
        </FullscreenCenteredLayout>
    );
};

export default InvalidTokenPage;

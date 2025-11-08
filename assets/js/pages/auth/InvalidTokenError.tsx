import MainLayout from "@/layouts/MainLayout";
import Button from "@/components/core/Button";

const InvalidTokenPage: React.FC = () => {
    return (
        <MainLayout className="invalid-token-page">
            <h1>Log In Failed!</h1>
            <h4>Error: Token provided is invalid!</h4>
            <Button href={"/auth/login"}>Log In</Button>
        </MainLayout>
    );
};

export default InvalidTokenPage;

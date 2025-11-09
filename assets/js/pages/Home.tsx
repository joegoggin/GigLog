import Button, { ButtonVariant } from "@/components/core/Button";
import { useAuth } from "@/hooks/useAuth";
import FullscreenCenteredLayout from "@/layouts/FullScreenCenteredLayout";
import { useEffect } from "react";

const HomePage: React.FC = () => {
    const { isLoggedIn } = useAuth();

    useEffect(() => {
        console.log(isLoggedIn);
    }, [isLoggedIn]);

    return (
        <FullscreenCenteredLayout className="home-page" title="GigLog">
            <h1>GigLog</h1>
            <div className="home-page__text">
                <p>
                    Freelancing opens a whole new world of opportunities giving
                    you the freedom to work on your own terms. This freedom
                    comes at a cost though. As a freelancer you are expected to
                    keep track of your own hours, payments, taxes, and expenses.
                    This can be hard to keep track of especially when you are
                    working multiple different gigs as many freelancers do. Our
                    goal at GigLog is to create a robust platform that has
                    everything you need to keep track of in one place.
                </p>
            </div>
            <div className="home-page__buttons">
                {isLoggedIn ? (
                    <Button href="/dashboard">View Dashboard</Button>
                ) : (
                    <>
                        <Button href="/auth/sign-up">Sign Up</Button>
                        <Button
                            href="/auth/log-in"
                            variant={ButtonVariant.SECONDARY}
                        >
                            Log In
                        </Button>
                    </>
                )}
            </div>
        </FullscreenCenteredLayout>
    );
};

export default HomePage;

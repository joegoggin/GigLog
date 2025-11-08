import Button from "@/components/core/Button";
import Checkbox from "@/components/core/Checkbox";
import Form from "@/components/core/Form";
import { NotificationType } from "@/components/core/Notification";
import TextInput from "@/components/core/TextInput";
import { useNotificationEffect } from "@/hooks/useNotificationEffect";
import FullscreenCenteredLayout from "@/layouts/FullScreenCenteredLayout";
import { useForm } from "@inertiajs/react";
import { useEffect } from "react";

const LogInPage = () => {
    const { data, setData, post } = useForm({
        email: "",
        password: "",
        remember_me: false,
    });

    const handleSubmit = () => {
        post("/auth/log-in");
    };

    useNotificationEffect(() => {
        setData("email", "");
        setData("password", "");
    }, NotificationType.ERROR);

    useEffect(() => {
        console.log(data);
    }, [data]);

    return (
        <FullscreenCenteredLayout className="log-in-page" title="Log In">
            <h1>Log In</h1>
            <Form onSubmit={handleSubmit}>
                <TextInput
                    name="email"
                    placeholder="Email"
                    data={data}
                    setData={setData}
                />
                <TextInput
                    name="password"
                    placeholder="Password"
                    data={data}
                    setData={setData}
                    password
                />
                <Checkbox
                    name="remember_me"
                    label="Remember me"
                    data={data}
                    setData={setData}
                />
                <Button type="submit">Log In</Button>
            </Form>
        </FullscreenCenteredLayout>
    );
};

export default LogInPage;

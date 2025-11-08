import Button from "@/components/core/Button";
import Form from "@/components/core/Form";
import { NotificationType } from "@/components/core/Notification";
import TextInput from "@/components/core/TextInput";
import { useNotificationEffect } from "@/hooks/useNotificationEffect";
import FullscreenCenteredLayout from "@/layouts/FullScreenCenteredLayout";
import { useForm } from "@inertiajs/react";

const SignUpPage: React.FC = () => {
    const { data, setData, post } = useForm({
        first_name: "",
        last_name: "",
        email: "",
    });

    const handleSubmit = () => {
        post("/auth/sign-up");
    };

    useNotificationEffect(() => {
        setData("first_name", "");
        setData("last_name", "");
        setData("email", "");
    }, NotificationType.SUCCESS);

    return (
        <FullscreenCenteredLayout className="sign-up" title="Sign Up">
            <h1>Sign Up</h1>
            <Form onSubmit={handleSubmit}>
                <TextInput
                    name="first_name"
                    placeholder="First Name"
                    data={data}
                    setData={setData}
                />
                <TextInput
                    name="last_name"
                    placeholder="Last Name"
                    data={data}
                    setData={setData}
                />
                <TextInput
                    name="email"
                    placeholder="Email"
                    data={data}
                    setData={setData}
                />
                <Button type="submit">Sign Up</Button>
            </Form>
        </FullscreenCenteredLayout>
    );
};

export default SignUpPage;

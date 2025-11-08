import Button from "@/components/core/Button";
import Form from "@/components/core/Form";
import { NotificationType } from "@/components/core/Notification";
import TextInput from "@/components/core/TextInput";
import { useNotificationEffect } from "@/hooks/useNotificationEffect";
import MainLayout from "@/layouts/MainLayout";
import { useForm } from "@inertiajs/react";

const SignUpPage: React.FC = () => {
    const { data, setData, post } = useForm({
        email: "",
    });

    const handleSubmit = () => {
        post("/auth/sign-up");
    };

    useNotificationEffect(() => {
        setData("email", "");
    }, NotificationType.SUCCESS);

    return (
        <MainLayout className="sign-up" title="Sign Up">
            <h1>Sign Up</h1>
            <Form onSubmit={handleSubmit}>
                <TextInput
                    placeholder="Email"
                    name="email"
                    data={data}
                    setData={setData}
                />
                <Button type="submit">Sign Up</Button>
            </Form>
        </MainLayout>
    );
};

export default SignUpPage;

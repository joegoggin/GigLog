import Button from "@/components/core/Button";
import Form from "@/components/core/Form";
import TextInput from "@/components/core/TextInput";
import MainLayout from "@/layouts/MainLayout";
import { useForm } from "@inertiajs/react";

const SetPasswordPage: React.FC = () => {
    const { data, setData, put } = useForm({
        password: "",
        password_confirmation: "",
    });

    const handleSubmit = () => {
        put("/set-password");
    };

    return (
        <MainLayout className="set-password-page" title="Set Password">
            <h1>Set Password Page</h1>
            <Form onSubmit={handleSubmit}>
                <TextInput
                    name="password"
                    placeholder="Password"
                    data={data}
                    setData={setData}
                    password
                />
                <TextInput
                    name="password_confirmation"
                    placeholder="Confirm"
                    data={data}
                    setData={setData}
                    password
                />
                <Button type="submit">Set Password</Button>
            </Form>
        </MainLayout>
    );
};

export default SetPasswordPage;

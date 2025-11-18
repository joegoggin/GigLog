import Button from "@/components/core/Button";
import Checkbox from "@/components/core/Checkbox";
import Form from "@/components/core/Form";
import { NotificationType } from "@/components/core/Notification";
import PercentInput from "@/components/core/PercentInput";
import TextInput from "@/components/core/TextInput";
import { useNotificationEffect } from "@/hooks/useNotificationEffect";
import MainLayout from "@/layouts/MainLayout";
import { useForm } from "@inertiajs/react";

const CreateCompanyPage: React.FC = () => {
    const { data, setData, post } = useForm({
        name: "",
        requires_tax_withholdings: false,
        tax_withholding_rate: 30,
    });

    const handleSubmit = () => {
        post("/companies/create");
    };

    useNotificationEffect(() => {
        setData("name", "");
        setData("requires_tax_withholdings", false);
        setData("tax_withholding_rate", 30);
    }, NotificationType.SUCCESS);
    return (
        <MainLayout className="create-company-page">
            <h1>Create Company</h1>
            <Form onSubmit={handleSubmit}>
                <TextInput
                    name="name"
                    data={data}
                    setData={setData}
                    placeholder="Company Name"
                />
                <Checkbox
                    label="Requires Tax Withholding"
                    name="requires_tax_withholdings"
                    data={data}
                    setData={setData}
                />
                {data["requires_tax_withholdings"] && (
                    <PercentInput
                        className="create-company-page__percent"
                        name="tax_withholding_rate"
                        data={data}
                        setData={setData}
                        placeholder="Tax Withholding Rate"
                    />
                )}
                <Button type="submit">Create Company</Button>
            </Form>
        </MainLayout>
    );
};

export default CreateCompanyPage;

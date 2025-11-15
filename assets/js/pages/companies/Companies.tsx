import IconButton from "@/components/core/IconButton";
import AddIcon from "@/components/icons/AddIcon";
import DeleteIcon from "@/components/icons/DeleteIcon";
import EditIcon from "@/components/icons/EditIcon";
import InfoIcon from "@/components/icons/InfoIcon";
import MainLayout from "@/layouts/MainLayout";
import { Company } from "@/types/models/Company";
import { usePage, router } from "@inertiajs/react";

type PageProps = {
    companies: Company[];
};

const CompaniesPage: React.FC = () => {
    const {
        props: { companies },
    } = usePage<PageProps>();

    const handleDelete = (company: Company) => {
        const route = `/companies/${company.id}`;

        router.delete(route);
    };

    return (
        <MainLayout className="companies-page">
            <h1>Companies</h1>
            <div className="companies-page__grid">
                {companies.map((company) => (
                    <div className="companies-page__card" key={company.id}>
                        <h3>{company.name}</h3>
                        <div>
                            <IconButton
                                className="companies-page__add-job"
                                icon={<AddIcon />}
                                label="Add New Job"
                                href="/jobs/create"
                            />
                            <IconButton
                                className="companies-page__info"
                                icon={<InfoIcon />}
                                label="View More Info"
                                href={`/companies/${company.id}`}
                            />
                            <IconButton
                                className="companies-page__edit"
                                icon={<EditIcon />}
                                label="View More Info"
                                href={`/companies/${company.id}`}
                            />
                            <IconButton
                                className="companies-page__delete"
                                icon={<DeleteIcon />}
                                label="Delete Company"
                                onClick={() => handleDelete(company)}
                            />
                        </div>
                    </div>
                ))}
            </div>
        </MainLayout>
    );
};

export default CompaniesPage;

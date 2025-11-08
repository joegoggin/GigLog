import RootLayout from "@/layouts/RootLayout";
import { LayoutProps } from "@/types/LayoutProps";

const FullscreenCenteredLayout: React.FC<LayoutProps> = ({
    className,
    title,
    description,
    children,
}) => {
    return (
        <RootLayout
            className={`fullscreen-centered-layout ${className}`}
            title={title}
            description={description}
        >
            {children}
        </RootLayout>
    );
};

export default FullscreenCenteredLayout;

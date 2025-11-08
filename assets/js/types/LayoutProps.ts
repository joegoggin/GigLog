import { ReactNode } from "react";

export type LayoutProps = {
    className?: string;
    title?: string;
    description?: string;
    children: ReactNode;
};

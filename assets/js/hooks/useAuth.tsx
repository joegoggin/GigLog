import { User } from "@/types/models/User";
import { usePage } from "@inertiajs/react";
import { useEffect, useState } from "react";

type PageProps = {
    user?: User;
};

export const useAuth = () => {
    const [user, setUser] = useState<User | null>(null);
    const [isLoggedIn, setIsLoggedIn] = useState<boolean>(false);

    const { props } = usePage<PageProps>();

    useEffect(() => {
        if (props.user) {
            setUser(props.user);
        } else {
            setUser(null);
        }
    }, [props]);

    useEffect(() => {
        if (user) {
            setIsLoggedIn(true);
        } else {
            setIsLoggedIn(false);
        }
    }, [user]);

    return { user, isLoggedIn };
};

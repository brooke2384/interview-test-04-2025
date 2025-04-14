export interface User {
    id: number;
    name: string;
    email: string;
    email_verified_at?: string;
}

export interface Movie {
    id: number;
    slug: string;
    title: string;
    description: string;
    released: string;
    created_at: string;
}

export interface Review {
    id: number;
    movie_id: string;
    user_id: string;
    rating: number;
    review: string;
    created_at: string;
    updated_at: string;
}

export interface ShowMovie extends Movie {
    reviews: Array<Review & { user: User }>;
}

export type PageProps<
    T extends Record<string, unknown> = Record<string, unknown>,
> = T & {
    auth: {
        user: User;
    };
};

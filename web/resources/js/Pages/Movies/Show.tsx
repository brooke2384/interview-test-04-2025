import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout';
import { PageProps, ShowMovie } from '@/types';
import { formatRating } from '@/Utils/formatRating';
import { Head } from '@inertiajs/react';

export default function Dashboard({
    movie,
}: PageProps<{ movie: ShowMovie }>) {
    return (
        <AuthenticatedLayout
            header={
                <h2 className="text-xl font-semibold leading-tight text-gray-800">
                    {movie.title}
                </h2>
            }
        >
            <Head title={`Movies - ${movie.title}`} />

            <div className="py-12">
                <div className="mx-auto max-w-7xl sm:px-6 lg:px-8">
                    <div className="p-6 overflow-hidden bg-white shadow-sm sm:rounded-lg">
                        <p>{movie.description}</p>
                    </div>
                </div>

                <section aria-labelledby="comments-title" className="mt-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
                    <h3 id="comments-title" className="mb-2 text-l font-semibold leading-tight text-gray-800">Reviews</h3>
                    <ul className="list-none">
                        {movie.reviews.map(review => (
                            <li key={review.id}>
                                <article className="p-6 mb-2 overflow-hidden bg-white shadow-sm sm:rounded-lg">
                                    <header>
                                        <span
                                            className="text-l text-black font-semibold me-2"
                                        >
                                            {review.user.name}
                                        </span>
                                        <span
                                            className="text-xs text-black"
                                            aria-label={`Rating: ${review.rating} out of 5`}
                                        >
                                            {formatRating(review.rating)}
                                        </span>
                                    </header>
                                    <p
                                        className="text-sm text-gray-800 font-light mt-2"
                                    >
                                        {review.review}
                                    </p>
                                </article>
                            </li>
                        ))}
                    </ul>
                </section>
            </div>
        </AuthenticatedLayout>
    );
}

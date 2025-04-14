export function formatRating(rating: number) {
  return "★".repeat(rating) + "☆".repeat(5 - rating);
}
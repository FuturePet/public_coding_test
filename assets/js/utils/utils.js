const getStartOfWeek = (date) => {
  const start = date.setDate(date.getDate() - date.getDay());
  return new Date(start);
};

const getEndOfWeek = (date) => {
  const end = date.setDate(date.getDate() + (6 - date.getDay()));
  return new Date(end);
};

export const startDate = getStartOfWeek(new Date());
export const endDate = getEndOfWeek(new Date());
export const maskOnlyLetters = value => {
  return value.replace(/[0-9!@#¨$%^&*)(+=._-]+/g, "");
};

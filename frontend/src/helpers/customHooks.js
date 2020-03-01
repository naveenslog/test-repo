import { useEffect, useRef } from 'react';

// usePrevious: hooks to compare previous and current values of a certain state variable
export const usePrevious = (value) => {
  const ref = useRef();
  useEffect(() => {
    ref.current = value;
  });
  return ref.current;
};

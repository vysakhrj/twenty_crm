const getDefaultUrl = () => {
  if (
    window.location.hostname === 'localhost' ||
    window.location.hostname === '127.0.0.1'
  ) {
    // In development environment front and backend usually run on separate ports
    // we set the default value to localhost:3000.
    // In dev context, we use env vars to overwrite it
    return 'http://localhost:3000';
  } else {
    // Outside of localhost, use the current origin so the Vite proxy can forward
    // requests to the backend, or in production the same server serves both
    return window.location.origin;
  }
};

export const REACT_APP_SERVER_BASE_URL =
  window._env_?.REACT_APP_SERVER_BASE_URL ||
  process.env.REACT_APP_SERVER_BASE_URL ||
  getDefaultUrl();

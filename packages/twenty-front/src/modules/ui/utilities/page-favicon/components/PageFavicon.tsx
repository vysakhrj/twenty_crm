import { Helmet } from 'react-helmet-async';

export const PageFavicon = () => {
  return (
    <Helmet>
      <link
        rel="icon"
        type="image/x-icon"
        href="/inceptra-favicon.png"
      />
    </Helmet>
  );
};

import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Change your life", "Start to drink"],
    typeSpeed: 50,
    loop: true
  });
}

export { loadDynamicBannerText };

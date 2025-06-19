// tailwind.config.js
/** @type {import('tailwindcss').Config} */
export default {
    content: [
        './index.html',
        './src/**/*.{vue,js,ts,jsx,tsx}',
    ],
    theme: {
        extend: {
            screens: {
                screen480: '480px',
                screen768: '768px',
                screen1024: '1024px',
                screen1440: '1440px',
                screen1920: '1920px',
            },
        },
    },
    plugins: [],
}

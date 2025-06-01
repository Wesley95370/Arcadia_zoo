import './styles/navbar.css';
import './styles/home.css';
import './styles/footer.css';
import './styles/avis.css';
import './styles/services.css';
import './styles/animaux.css';
import './styles/contact.css';
import './styles/habitat.css';
import './styles/login.css';
import './bootstrap.js';
console.log('Hello Webpack Encore!');


// Gestion du menu burger
document.addEventListener('DOMContentLoaded', () => {
    const burger = document.querySelector('.burger-menu');
    const navList = document.querySelector('.nav-list');

    burger.addEventListener('click', () => {
        burger.classList.toggle('active');
        navList.classList.toggle('active');
    });
});
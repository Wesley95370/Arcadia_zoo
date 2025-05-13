const Encore = require('@symfony/webpack-encore');

Encore
    .setOutputPath('public/build/')
    .setPublicPath('/build')
    .addEntry('app', './assets/app.js')
    .addEntry('navbar', './assets/styles/navbar.css')
    .addEntry('home', './assets/styles/home.css')
    .addEntry('footer', './assets/styles/footer.css')
    .addEntry('avis', './assets/styles/avis.css')
    .splitEntryChunks()
    .enableSingleRuntimeChunk()
    .cleanupOutputBeforeBuild()
    .enableBuildNotifications()
    .enableSourceMaps(!Encore.isProduction())
    .enableVersioning(Encore.isProduction())
    .configureBabelPresetEnv((config) => {
        config.useBuiltIns = 'usage';
        config.corejs = '3.23';
    })
    // Ajoute cet alias
    .addAliases({
        '@symfony/stimulus-bridge/controllers.json': require('path').resolve('assets/controllers.json')
    });

module.exports = Encore.getWebpackConfig();
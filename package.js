Package.describe({
  name: 'miguelalarcos:react-autocomplete',
  version: '0.1.0',
  // Brief, one-line summary of the package.
  summary: 'An autocomplete widget for React.',
  // URL to the Git repository containing the source code for this package.
  git: 'https://github.com/miguelalarcos/react-autocomplete.git',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');

  api.use('mongo');
  api.use('reactive-dict');
  api.use('reactjs:react@0.2.4');
  api.use('jhartma:cjsx@2.4.1');
  api.use('stylus');
  api.addFiles('react-autocomplete.styl', 'client');
  api.addFiles('react-autocomplete.cjsx', 'client');
  api.export('autocompleteMx', 'client');
  api.export('stateMx', 'client');
  api.export('Autocomplete', 'client');


});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('miguelalarcos:react-autocomplete');
  api.addFiles('react-autocomplete-tests.js');
});

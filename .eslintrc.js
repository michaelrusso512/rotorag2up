module.exports = {
  "env": {
    "node": true,
    "browser": true,
    "jest": true
  },
  "globals": {
    "shallow": false,
    "mount": false,
    "render": false
  },
  "parser": "babel-eslint",
  "parserOptions": {
    "ecmaVersion": 8,
    "sourceType": "module",
    "ecmaFeatures": {
      "jsx": true,
      "experimentalObjectRestSpread": true
    }
  },
  "plugins": [
    "standard",
    "babel",
    "compat"
  ],
  "extends":  ["standard", "standard-react"],
  "rules": {
    "compat/compat": "error"
  },
  "settings": {
    "import/resolver": "babel-plugin-root-import"
  }
};

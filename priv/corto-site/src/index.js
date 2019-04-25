import React from 'react';
import ReactDOM from 'react-dom';
import Favicon from 'react-favicon';

import './index.css';
import App from './App';
import * as serviceWorker from './serviceWorker';

ReactDOM.render(
  <div>
    <Favicon url="https://i.ibb.co/SwHKLw5/favicon-16x16.png" />
    <App />
  </div>
  , document.getElementById('root'));

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();

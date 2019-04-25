import React, { Component } from 'react';
import ReactJson from 'react-json-view'
import './App.css';

class App extends Component {

  componentWillMount() {
    document.title = 'Corto - url shortener'
  }
  dataJson(){
    return {
      "link": {
        "url": "<YOUR-URL>"
      }
    }
  }
  render() {
    return (
      <div className="App">
        <header className="App-header">
          <h1>Shorten URL API</h1>
          <p className="round-div-corner">
            POST https://corto.link/api/links
          </p>
          <ReactJson src={this.dataJson()}
                     theme="summerfruit:inverted"
                     collapsed={false}
                     displayDataTypes={false}
                     name={false}
                     indentWidth={4}
                     displayObjectSize={false}
                 />
        </header>
      </div>
  );
  }
}

export default App;

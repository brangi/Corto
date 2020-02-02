import React, { Component } from 'react';
import ReactJson from 'react-json-view'
import './App.css';

class App extends Component {

  constructor(props) {
    super(props);
    this.state = {success: false, shortLink: ''};
    this.shortIt = this.shortIt.bind(this);
    this.handleChange = this.handleChange.bind(this);
    this.onPaste = this.onPaste.bind(this);


  }
  componentWillMount() {
    document.title = 'Corto';
  }
  handleChange(e){
    this.setState(
      {
        [e.target.name]: e.target.value
      }
    )
  }

  onPaste(e) {
    this.setState({ url: e.clipboardData.getData('Text') });
  }

  isValidurl(string){
    const matcher = /^(?:\w+:)?\/\/([^\s\.]+\.\S{2}|localhost[\:?\d]*)\S*$/;
    return matcher.test(string);
  }

  shortIt() {
    if(this.isValidurl(this.state.url)){
      fetch("/api/links", {
        method: "post",
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          "link": {
            "url": this.state.url
          }
        })
      })
        .then(response => response.json())
        .then( (response) => {
          if(response.data) {
            document.getElementById("url-form").reset();
            this.setState({ url: '' });
            this.setState({ success: true });
            this.setState({ shortLink: response.data.shortLink });
          }
        })

    }
  }

  showShortLink(){
    return (
      <p className="round-div-corner">
        {this.state.shortLink}
      </p>
    );
  }

  notValidUrl(){
    return (
      <p className="round-div-corner">
        Not a valid url !
      </p>
    );
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
          <h2>Corto</h2>
          <br/>
          <div className="flex">
            <form id="url-form">
              <input type="text"
                     ref="urlInput"
                     className="input-link"
                     name="url"
                     placeholder="Place your URL here..."
                     onChange={this.handleChange}
                     onPaste={this.onPaste}
              />
            </form>
            <button className="button-done" onClick={this.shortIt} >Short it</button>
          </div>
          { this.state.success ? this.showShortLink() : null }
          <h4>OR</h4>
          <br/>
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

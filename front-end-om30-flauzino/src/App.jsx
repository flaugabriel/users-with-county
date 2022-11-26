import React, { Fragment } from 'react';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import './App.css';
import Sidebar from './components/Sidebar';
import Topnav from './components/Topnav';
import Counties from './pages/counties';
import CountiesEdit from './pages/counties/edit/index';
import NoMatch from './pages/noMatch';
import Users from './pages/users';

const API_URL = 'http://localhost:3000/api/v1/'

function App() {

  return (
    <Fragment>
      <BrowserRouter>
        <Topnav />
        <div className="container-fluid">
          <div className="row">
            <Sidebar />
            <main className="col-md-9 ms-sm-auto col-lg-10 px-md-4">
              <Routes>
                <Route path="/" element={<Counties urlApi={API_URL} />} />
                <Route path="/counties" element={<Counties urlApi={API_URL} />} />
                <Route path="/counties/:id" element={<CountiesEdit urlApi={API_URL} />} />
                <Route path="/users" element={<Users urlApi={API_URL} />} />
                <Route path="*" element={<NoMatch />} />
              </Routes>
            </main>
          </div>
        </div>
      </BrowserRouter>
    </Fragment>
  );
}

export default App;

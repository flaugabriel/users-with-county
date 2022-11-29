import axios from 'axios';
import { useState, useEffect, Fragment } from 'react';
import { maskCEP } from '../../tools/cepMask';

const Addresses = ({urlApi}) => {
  const [addresses, setAddress] = useState({});

  function getAPIData() {
   return axios.get(urlApi + 'addresses').then((res) => res.data);
  }

  useEffect(() => {
    let mounted = true;
    getAPIData().then((items) => {
      console.log(items);
      if (mounted && items.status !== 'not_found') {
        setAddress(items)
      }
      mounted = false
    });
    if (addresses && addresses.length > 0) {
      mounted = false
    }else {
      mounted = true
    }

    return () => (mounted);
  },);

  return (
    <Fragment>
      <div className="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <div className="col-md-4">
          <h2>Lista de Endereços</h2>
        </div>
        <div className='row'>
            <div className="col-md-12">
              <div className="btn-toolbar mb-2 mb-md-0">
                <div className="btn-group me-2">
                  <div className="input-group input-group-lg">
                    <input type="text" className="form-control" placeholder="Pesquisa..." />
                    <span className='mb-md-1'></span>
                  </div>
                  <input type="checkbox" className="btn-check" id="recent" name="recent" autocomplete="off"/>
                  <label className="btn btn-outline-primary" for="recent">Recente</label>
                  <input type="checkbox" className="btn-check" id="lasties" name="lasties" autocomplete="off"/>
                  <label className="btn btn-outline-primary" for="lasties">Ultimos</label>
                  <button className="btn btn-sm btn-success" type="button">Buscar</button>
                  <button className="btn btn-outline-primary text-dark" type="button">Limpar</button>
                </div>
              </div>
            </div>
          </div>
      </div>
      <div className="table-responsive">
        <table className="table table-striped table-sm">
          <thead>
            <tr>
              <th scope="col">Cep</th>
              <th scope="col">Compemento</th>
              <th scope="col">Rua</th>
              <th scope="col">Bairro</th>
              <th scope="col">Cidade</th>
              <th scope="col">UF</th>
              <th scope="col">Codígo IBGE</th>
              <th scope="col">Municipio</th>
              <th scope="col">Ações</th>
            </tr>
          </thead>
          <tbody>
            {addresses && addresses.length > 0 ? 
            addresses.map((item) => 
              <tr key={item.id}>
                <td>{maskCEP(item.cep)}</td>
                <td>{item.complement}</td>
                <td>{item.street}</td>
                <td>
                  {item.neighborhood}
                </td>
                <td>{item.city}</td>
                <td>{item.uf}</td>
                <td>{item.ibge_code}</td>
                <td>{item.county_name}</td>
                <td>
                  <a className="btn btn-primary " href={`/addresses/${item.id}`}>Editar</a>
                </td>
              </tr>
            ) : <span>
                Não foi encontrado nenhum Endereços municipais
              </span>}
          </tbody>
        </table>
        <nav aria-label="Page navigation example">
          <ul className="pagination">
            <li className="page-item">
              <a className="page-link" href="#" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
              </a>
            </li>
            <li className="page-item"><a className="page-link" href="#">1</a></li>
            <li className="page-item"><a className="page-link" href="#">2</a></li>
            <li className="page-item"><a className="page-link" href="#">3</a></li>
            <li className="page-item">
              <a className="page-link" href="#" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
              </a>
            </li>
          </ul>
        </nav>
      </div>
    </Fragment>
  );
}

export default Addresses;
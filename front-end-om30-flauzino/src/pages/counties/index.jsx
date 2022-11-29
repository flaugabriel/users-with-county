import axios from 'axios';
import { useState, useEffect, Fragment, useRef } from 'react';
import ModalUsers from './components/ModalUsers';


const Counties = ({urlApi}) => {
  const [counties, setCounties] = useState({});
  const [openModal, setOpenModal] = useState(false);

  const refresh = useRef(null)

  function actionUpdateStatus(id) {
    return axios.put(urlApi + 'counties/update_status/' + id).then((res) => res.data)
  }

  const setStatus = (id) => {
    actionUpdateStatus(id).then((resp) => {
      if (resp.messenger  !== undefined && resp.messenger !== '') {
        setCounties(...counties)
      }else{
        alert('Algo deu errado durante atualização do status');
      }
    });
  }

  function getAPIData() {
   return axios.get(urlApi + 'counties').then((res) => res.data);
  }


  useEffect(() => {
    let mounted = true;
    getAPIData().then((items) => {
      if (mounted) {
        setCounties(items)
      }
    });
    if (counties && counties.length > 0) {
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
          <h2>Lista de Municipios</h2>
        </div>
      </div>
      <div className="table-responsive">
        <table className="table table-striped table-sm">
          <thead>
            <tr>
              <th scope="col">Nome</th>
              <th scope="col">Status</th>
              <th scope="col">Pessoas</th>
              <th scope="col">Endereços</th>
              <th scope="col">Ações</th>
            </tr>
          </thead>
          <tbody>
            {counties && counties.length > 0 ? 
            counties.map((item) => 
              <tr key={item.id}>
                <td>{item.name}</td>
                <td>
                  {item.status === 'off' ? 
                    <span className="badge bg-danger">Inativo</span>
                  :
                    <span className="badge bg-success">Ativo</span>
                  }
                </td>
                {item.user_count > 0 ?
                  <td>
                    <a className="btn btn-info" data-bs-toggle="modal" href='/#' onClick={() => setOpenModal(true)} data-bs-target={`#user-${item.id}`}> {item.user_count}</a>
                      <ModalUsers county={item} openModal={openModal} urlApi={urlApi} refresh={refresh}/>
                  </td>
                  : 
                  <td>Ainda não posui</td>
                }
                <td>{item.address_count}</td>
                <td>
                  <div className="btn-group dropstart">
                    <button type="button" className="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                      Abrir
                    </button>
                    <ul className="dropdown-menu">
                      <li>
                        <a className="dropdown-item" href={`/counties/${item.id}`}>Editar</a>
                      </li>
                      <li>
                        <a className="dropdown-item" href="/#" onClick={() => setStatus(item.id)}>
                        { item.status === 'on' ? 'Inativar ?' : 'Ativar ?'
                        }
                      </a></li>
                    </ul>
                  </div>
                </td>
              </tr>
            ) : <span>
                Não foi encontrado nenhum Endereços municipais
              </span>}
          </tbody>
        </table>
      </div>
    </Fragment>
  );
}

export default Counties;
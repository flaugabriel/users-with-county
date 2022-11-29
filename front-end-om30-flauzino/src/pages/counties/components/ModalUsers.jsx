import axios from 'axios';
import { useState, useEffect } from 'react';

const ModalUsers = (props, refresh) => {
	const [isLoad, setIsLoad] = useState(true);
  
  function getAPIData() {
    return axios.get(props.urlApi + 'counties/show_user/' + props.county.id).then((res) => res.data)
  }

  function actionUpdateStatus(id) {
    return axios.delete(props.urlApi + 'counties/destroy_user_county/' + id).then((res) => res.data)
  }

  const [resp, setResp] = useState({});

  const destroyUser = (id) => {
    setResp({});

    actionUpdateStatus(id).then((resp) => {
      if (resp.messenger  !== undefined && resp.messenger !== '') {
        alert(resp.messenger);
        getAPIData().then((user) => {
          setResp(user)
        }); 
      }else{
        alert('Algo deu errado durante atualização do status');
      }
    });
  }

  useEffect(() => {
    let mounted = props.openModal;
    if (props.openModal) {
      getAPIData().then((user) => {
        if (mounted && isLoad) {
          setResp(user)
          setIsLoad(false)
        }
      }); 
    }

    return () => (mounted = false);
  },)

  const closeModal = () => {
    refresh = false
  };

  return (
    <div className="modal fade" id={`user-${props.county.id}`} tabIndex="-1" aria-labelledby={`user-${props.county.id}-label`} aria-hidden="true">
      <div className="modal-dialog modal-xl">
        <div className="modal-content">
          <div className="modal-header">
            <h5 className="modal-title" id={`user-${props.county.id}-label`}>{props.county.name} - status: {props.county.status === 'off' ? 'Inativo' : 'Ativo'}</h5>
            <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div className="modal-body">
            <div className="table-responsive">
              <table className="table table-striped table-sm">
                <thead>
                  <tr>
                    <th scope="col">Nome</th>
                    <th scope="col">CPF</th>
                    <th scope="col">CNS</th>
                    <th scope="col">Email</th>
                    <th scope="col">Data de nascimento</th>
                    <th scope="col">Telefone</th>
                    <th scope="col">Status</th>
                    <th scope="col">Ação</th>
                  </tr>
                </thead>
                <tbody>
                  {resp && resp.length > 0 ?
                    resp.map((user) =>
                      <tr key={user.id}>
                        <td>{user.name}</td>
                        <td>{user.cpf}</td>
                        <td>{user.cns}</td>
                        <td>{user.email}</td>
                        <td>{user.birth_day}</td>
                        <td>{user.phone}</td>
                        <td>
                          {user.status === 'off' ?
                            <span className="badge bg-danger">Inativo</span>
                            :
                            <span className="badge bg-success">Ativo</span>
                          }
                        </td>
                        <td>
                          <a className="btn btn-danger btn-sm" href="/#" onClick={() => destroyUser(user.id)}>Remover</a>
                        </td>
                      </tr>
                    ) : <span>
                      Não foi encontrado nenhuma pessoa neste municipio
                    </span>}
                </tbody>
              </table>
            </div>
          </div>
          <div className="modal-footer">
            <button type="button" className="btn btn-secondary" onClick={() => closeModal()} data-bs-dismiss="modal">Fecha</button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default ModalUsers;
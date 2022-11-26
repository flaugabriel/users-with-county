import axios from 'axios';
import { useState, useEffect, Fragment } from 'react';
import { useParams } from 'react-router-dom'
import { useRef } from "react";
import countyForm from "./CountyForm";

const CountiesEdit = (props) => {
	const { id } = useParams();

	function getAPIData() {
		return axios.get(props.urlApi + 'counties/' + id).then((res) => res.data)
	}

	const [resp, setResp] = useState({});
	const [respUsers, setRespUsers] = useState([]);
	const [isLoad, setIsLoad] = useState(true);

	useEffect(() => {
		let mounted = true;

		if (mounted && isLoad) {
			getAPIData().then((items) => {
				setResp(items.county);
				setRespUsers(items.new_users)
				setIsLoad(false);
			});
		}
		
		return () => (mounted);
	},)

	const formElement = useRef(null);
  const additionalData = {
    sent: new Date().toISOString(),
  };

  const { handleSubmit, status, message } = countyForm({
    form: formElement.current,
    additionalData,
		id: resp.id
  });

  if (status === "success") {
    return (
      <>
        <div className="text-2xl">Tudo certo!</div>
        <div className="text-md">{message}</div>
      </>
    );
  }

  if (status === "error") {
    return (
      <>
        <div className="text-2xl">Algo aconteceu!</div>
        <div className="text-md">{message}</div>
				<a className="btn btn-primary" href={`/counties/${id}`}>Voltar</a>
      </>
    );
  }

	return (
		<Fragment>
			<h2>Edita o Municipio {resp.name}</h2>
			<div className="form-group">
				<form className="row g-3" action={props.urlApi} onSubmit={handleSubmit} method="POST" target="_blank" ref={formElement}>
					<div className="col-md-4">
						<label  className="form-label">Nome</label>
						<input
          type="text"
          placeholder="Digite aqui..."
          name="name"
          className="form-control"
          required
        />
					</div>
					<div class="col-md-3">
  				  <label for="validationCustom04" class="form-label">Adiciona pessoa</label>
  				  <select class="form-select" id="validationCustom04" required>
  				    <option selected disabled value="">Selecione...</option>
							{respUsers && respUsers.length > 0 ? 
            		respUsers.map((user)=>
									<option value={user.id}>{user.name}</option>
								) : <option selected disabled>Não foram encontrado nem uma pessoa</option>
							}
  				  </select>
  				</div>
					{status !== "loading" && (
      		  <div className="mb-3 pt-0">
      		    <button
      		      className="btn btn-success"
      		      type="submit"
      		    >
      		      Salvar
      		    </button>
      		  </div>
      		)}
				</form>
			</div>
		</Fragment>
	);
}

export default CountiesEdit;
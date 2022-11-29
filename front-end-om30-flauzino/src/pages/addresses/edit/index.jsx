import axios from 'axios';
import { useState, useEffect, Fragment } from 'react';
import { useParams } from 'react-router-dom'
import { useRef } from "react";
import addressForm from "./AddressForm";
import { maskCEP } from '../../../tools/cepMask';

const AddressEdit = (props) => {
	const { id } = useParams();
	const [cep, setCep] = useState('')
	const [complement, setComplement] = useState('')
	const [street, setStreet] = useState('')
	const [neighborhood, setNeighborhood ] = useState('')
	const [city, setCity] = useState('')
	const [uf, setUf] = useState('')
	const [ibge_code, setIbgeCode] = useState('')

	function getAPIData() {
		return axios.get(props.urlApi + 'addresses/' + id).then((res) => res.data)
	}

	const [resp, setResp] = useState({});
	const [respCounties, setRespCounties] = useState([]);
	const [isLoad, setIsLoad] = useState(true);

	useEffect(() => {
		let mounted = true;

		if (mounted && isLoad) {
			getAPIData().then((items) => {
				setResp(items.address);
				console.log(items.address);
				setRespCounties(items.new_counties)
				setIsLoad(false);
			});
		}

		return () => (mounted);
	},)

	const formElement = useRef(null);
	const additionalData = {
		sent: new Date().toISOString(),
	};

	const { handleSubmit, status, message } = addressForm({
		form: formElement.current,
		additionalData,
		id: resp.id
	});

	if (status === "success") {
		return (
			<>
				<div className="text-2xl text-success">Salvo!</div>
				<div className="text-md">{message}</div>
			</>
		);
	}

	if (status === "error") {
		return (
			<>
				<div className="text-2xl text-danger">Algo aconteceu!</div>
				<div className="text-md">{message}</div>
				<a className="btn btn-primary" href={`/addresses/${id}`}>Volta/Refazer</a>
			</>
		);
	}

	return (
		<Fragment>
			<h2>Edita o Endereço</h2>
			<div className="form-group">
				<form className="row g-3" action={props.urlApi} onSubmit={handleSubmit} method="POST" target="_blank" ref={formElement}>
					<div className="col-md-4">
						<label className="form-label">CEP</label>
						<input
							type="text"
							placeholder="Digite aqui..."
							name="cep"
							value={maskCEP(cep === 0 ? resp.cep.toString() : cep)}
							onChange={(e)=> setCep(e.target.value)}
							className="form-control"
						/>
					</div>
					<div className="col-md-4">
						<label className="form-label">Complemento</label>
						<input
							type="text"
							placeholder="Digite aqui..."
							name="complement"
							value={complement === '' ? resp.complement : complement}
							onChange={(e)=> setComplement(e.target.value)}
							className="form-control"
						/>
					</div>
					<div className="col-md-4">
						<label className="form-label">Rua</label>
						<input
							type="text"
							placeholder="Digite aqui..."
							name="street"
							value={street === '' ? resp.street : street}
							onChange={(e)=> setStreet(e.target.value)}
							className="form-control"
						/>
					</div>
					<div className="col-md-4">
						<label className="form-label">Bairro</label>
						<input
							type="text"
							placeholder="Digite aqui..."
							name="neighborhood"
							value={neighborhood === '' ? resp.neighborhood : neighborhood}
							onChange={(e)=> setNeighborhood(e.target.value)}
							className="form-control"
						/>
					</div>
					<div className="col-md-4">
						<label className="form-label">Cidade</label>
						<input
							type="text"
							placeholder="Digite aqui..."
							name="city"
							value={city === '' ? resp.city : city}
							onChange={(e)=> setCity(e.target.value)}
							className="form-control"
						/>
					</div>
					<div className="col-md-4">
						<label className="form-label">UF</label>
						<input
							type="text"
							placeholder="Digite aqui..."
							name="uf"
							value={uf === '' ? resp.uf : uf}
							onChange={(e)=> setUf(e.target.value)}
							className="form-control"
						/>
					</div>
					<div className="col-md-4">
						<label className="form-label">Codígo IBGE</label>
						<input
							type="text"
							placeholder="Digite aqui..."
							name="ibge_code"
							value={ibge_code === '' ? resp.ibge_code : ibge_code}
							onChange={(e)=> setIbgeCode(e.target.value)}
							className="form-control"
						/>
					</div>
					<div className="col-md-3">
						<label for="validationCustom04" className="form-label">Adiciona Municipio</label>
						<select className="form-select" id="validationCustom04" name="county_id">
							<option value={resp.county_id} selected>Selecione...</option>
							{respCounties && respCounties.length > 0 ?
								respCounties.map((user) =>
									<option value={user.id}>{user.name}</option>
								) : <option selected disabled>Não foram encontrado municipios</option>
							}
						</select>
					</div>
					{status !== "loading" && (
						<div className="mb-3 pt-0">
							<button
								className="btn btn-success"
								type="submit"
							>
								Atualizar
							</button>
						</div>
					)}
				</form>
			</div>
		</Fragment>
	);
}

export default AddressEdit;
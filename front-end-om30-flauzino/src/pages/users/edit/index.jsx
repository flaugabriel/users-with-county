import axios from 'axios';
import { useState, useEffect, Fragment } from 'react';
import { redirect, useParams } from 'react-router-dom'
import { cpfMask } from '../../../tools/cpfMask'
import { maskDate } from '../../../tools/maskDate'
import { phoneNumber } from '../../../tools/phoneNumber'

const UserEdit = (props) => {
	const { id } = useParams();
	const [userName, setUserName] = useState('');
	const [userCpf, setUserCpf] = useState('');
	const [userCns, setUserCns] = useState('');
	const [userBirthDate, setBirthDate] = useState('');
	const [userEmail, setUserEmail] = useState('');
	const [userPhone, setUserPhone] = useState('');
	const [picture, setPicture] = useState(null);
  const [imgData, setImgData] = useState(null);

	function getAPIData() {
		return axios.get(props.urlApi + 'users/' + id).then((res) => res.data)
	}

	const [resp, setResp] = useState({});
	const [isLoad, setIsLoad] = useState(true);

	useEffect(() => {
		let mounted = true;

		if (mounted && isLoad) {
			getAPIData().then((items) => {
				setResp(items.user);
				setIsLoad(false);
			});
		}

		return () => (mounted);
	},)

	const onChangePicture = e => {
    if (e.target.files[0]) {
      setPicture(e.target.files[0]);
      const reader = new FileReader();
      reader.addEventListener("load", () => {
        setImgData(reader.result);
      });
      reader.readAsDataURL(e.target.files[0]);
    }
  };

	function handleSubmit(event) {
    event.preventDefault();
		const	data = {
			name: event.target.name.value,
			email: event.target.email.value,
			birth_date: event.target.birth_date.value,
			cpf: event.target.cpf.value,
			cns: event.target.cns.value,
			phone: event.target.phone.value,
		}
    submitToAPI(data,event);
  }

	function submitToAPI(data, event) {
    fetch(props.urlApi+'users/'+id, {
			headers: {
				'Content-Type': 'application/json'
			},
      method: "PUT",
      body: JSON.stringify({user: data}),
    })
    .then((response) => response.json())
    .then((data) => {
			if (data.messenger !== '' && event.target.avatar.files[0]) {
				setAvatar(event.target.avatar.files[0])
			}else{
				if (data.messenger === undefined) {
					alert('Atualizado!');
					window.location.href = '/users'
				}else {
					alert(data.messenger);
				}
			}
    })
    .catch((error) => alert(error));
  }

	function setAvatar(fileField){
		const formData = new FormData();
		formData.append('avatar', fileField);
		submitAvatar(formData)
	}

	function submitAvatar(formData){
		fetch(props.urlApi+'users/avatar/'+id, {
			method: 'PUT',
			body: formData
		})
  	.then((response) => response.json())
  	.then((result) => {
			if (result.status !== 200) {
				alert('Atualizado!');
				window.location.href = '/users'
			}else{
				alert(result)
			}
  	})
  	.catch((error) => {
  	  alert('Error:', error);
  	});
	}

	return (
		<Fragment>
			<h2>Edita pessoa: <span className="badge bg-info"> {resp.name}</span></h2>
			<div className="form-group">
				<form className="row g-3" onSubmit={(e) => handleSubmit(e)}>
					<div className="col-md-4">
						<label className="form-label text-info">Formatos de foto permitidas (jpeg, png)</label>
						<input id="profilePic" className='form-control' type="file" name='avatar' onChange={onChangePicture} />
					</div>
					<div className="col-md-4">
						<label className="form-label">Nome</label>
						<input
							type="text"
							placeholder="Digite aqui..."
							name="name"
							value={userName === '' ? resp.name : userName}
							onChange={(e)=> setUserName(e.target.value)}
							className="form-control"
							required
						/>
					</div>
					<div className="col-md-3">
						<label className="form-label">CPF</label>
						<input
							type="text"
							placeholder="Digite aqui..."
							name="cpf"
							value={cpfMask(userCpf === '00000000000' ? resp.cpf : userCpf)}
							onChange={(e)=> setUserCpf(e.target.value)}
							className="form-control"
							required
						/>
					</div>
					<div className="col-md-3">
						<label className="form-label">CNS</label>
						<input
							type="text"
							placeholder="Digite aqui..."
							name="cns"
							value={userCns === '' ? resp.cns : userCns}
							onChange={(e)=> setUserCns(e.target.value)}
							className="form-control"
							required
						/>
					</div>
					<div className="col-md-3">
						<label className="form-label">Email</label>
						<input
							type="text"
							placeholder="Digite aqui..."
							name="email"
							value={userEmail === '' ? resp.email : userEmail}
							onChange={(e)=> setUserEmail(e.target.value)}
							className="form-control"
							required
						/>
					</div>
					<div className="col-md-3">
						<label className="form-label">Data de aniversário</label>
						<input
							type="text"
							placeholder="Digite aqui..."
							name="birth_date"
							value={maskDate(userBirthDate === '00000000' ? resp.birth_date : userBirthDate)}
							onChange={(e)=> setBirthDate(e.target.value)}
							className="form-control"
							required
						/>
					</div>
					<div className="col-md-3">
						<label className="form-label">Telefone com DD</label>
						<input
							type="text"
							placeholder="Digite aqui..."
							name="phone"
							value={phoneNumber(userPhone === '00000000000' ? resp.phone : userPhone)}
							onChange={(e)=> setUserPhone(e.target.value)}
							className="form-control"
							required
						/>
					</div>
						<div className="mb-3 pt-0">
							<button
								className="btn btn-success"
								type="submit"
							>
								Atualizar
							</button>
						</div>
				</form>
				<div className="container">
					{
					imgData === null ? 
					<span className="text-secondary"><h2>Faça o upload de uma foto que a mesma devera aparece abaixo.</h2></span>
					: 
	          <img className="img-thumbnail" alt="user avatar" src={imgData}/>
					}
        </div>
			</div>
		</Fragment>
	);
}

export default UserEdit;
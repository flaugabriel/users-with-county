import { useState } from "react";
import axios from 'axios';

function CountyForm({ form, additionalData, endpointUrl}) {
  const [status, setStatus] = useState("");
  const [message, setMessage] = useState("");

  const handleSubmit = (e) => {
    function fetchCounties(urlApi, data){
      axios({
        url: urlApi + 'counties/', 
        method: "POST",
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
        },
        data: JSON.stringify(data),
      }).then((err) => {
        setMessage("Salvo com sucesso!");
        setStatus("success");
      }).catch((err) => {
        setMessage(err.response.data.messenger);
        setStatus("error");
      });
    }

    if (form) {
      e.preventDefault();
      setStatus("loading");
      setMessage("");

      const finalFormEndpoint = endpointUrl || form.action;
      const data = Array.from(form.elements)
        .filter((input) => input.name)
        .reduce(
          (obj, input) => Object.assign(obj, { [input.name]: input.value }),
          {}
        );

      if (additionalData) {
        Object.assign(data, additionalData);
      }
  
      fetchCounties(finalFormEndpoint, data)
    }
  };

  return { handleSubmit, status, message };
}

export default CountyForm;
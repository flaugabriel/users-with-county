User.create(name: 'Manuel freitas', cpf: '81522896040', cns: '564165165162165', email: 'flaugabriel@gmail.com',
            birth_date: Date.today - 20.years, phone: '69999705594', status: 0)
User.create(name: 'Jose chico xavier', cpf: '81522896040', cns: '564165165162165', email: 'flaugabriel@gmail.com',
            birth_date: Date.today - 19.years, phone: '69999705594', status: 0)
User.create(name: 'Camila', cpf: '81522896040', cns: '564165165162165', email: 'flaugabriel@gmail.com',
            birth_date: Date.today - 27.years, phone: '69999705594', status: 0)
User.create(name: 'Diana pereira', cpf: '81522896040', cns: '564165165162165', email: 'flaugabriel@gmail.com',
            birth_date: Date.today - 24.years, phone: '69999705594', status: 0)
User.create(name: 'danel silva de freitas', cpf: '81522896040', cns: '564165165162165', email: 'flaugabriel@gmail.com',
            birth_date: Date.today - 21.years, phone: '69999705594', status: 0)
User.create(name: 'Carlos andre', cpf: '81522896040', cns: '564165165162165', email: 'flaugabriel@gmail.com',
            birth_date: Date.today - 46.years, phone: '69999705594', status: 0)
User.create(name: 'Pedro martins', cpf: '81522896040', cns: '564165165162165', email: 'flaugabriel@gmail.com',
            birth_date: Date.today - 66.years, phone: '69999705594', status: 0)
User.create(name: 'Gabriel Mota', cpf: '81522896040', cns: '564165165162165', email: 'flaugabriel@gmail.com',
            birth_date: Date.today - 36.years, phone: '69999705594', status: 0)
User.create(name: 'Alexandra figueiredo', cpf: '14316990047', cns: '564165165162234', email: 'teste1@gmail.com',
            birth_date: Date.today - 45.years, phone: '69999705545', status: 0)
User.create(name: 'Samara julia', cpf: '43468216009', cns: '564165325235235', email: 'teste2@gmail.com',
            birth_date: Date.today - 26.years, phone: '69999705564', status: 0)
User.create(name: 'Samuel flauzino', cpf: '10426332075', cns: '564165165144465', email: 'teste4@gmail.com',
            birth_date: Date.today - 3.years, phone: '69999705562', status: 0)
User.create(name: 'Walter Flauzino', cpf: '24510225075', cns: '6554335165162165', email: 'teste5@gmail.com',
            birth_date: Date.today - 56.years, phone: '69999705523', status: 0)
User.create(name: 'Alexandra figueiredo', cpf: '24510225075', cns: '6554335165162165', email: 'teste5@gmail.com',
            birth_date: Date.today - 56.years, phone: '69999705523', status: 0)
County.create(name: 'Porto Velho', status: 0)
County.create(name: 'Rio Branco',  status: 1)
County.create(name: 'Adamantina',  status: 1)
County.create(name: 'Rio de janeiro', status: 0)
County.create(name: 'Goiania', status: 0)
County.create(name: 'Santos', status: 0)
County.create(name: 'Sorocaba', status: 0)
County.create(name: 'Vilhena', status: 0)
County.create(name: 'Ji-parana', status: 0)
County.create(name: 'Jaru', status: 0)
County.create(name: 'Cruzeiro do Sul', status: 0)
County.create(name: 'Botafogo', status: 0)
County.create(name: 'Humaitá', status: 0)
County.create(name: 'Aguaí', status: 1)
County.create(name: 'Águas da Prata', status: 1)
Address.create(cep: 76_810_160, complement: 'Condominio vila dos jasmins casa 2', street: 'principal',
               neighborhood: 'Novo horizonte', city: 'Porto Velho', uf: 'RO', ibge_code: '1100205', county_id: 1)
Address.create(cep: 76_810_160, complement: 'Algodoeiro zona sul', street: 'Algodoeiro', neighborhood: 'Eletronorte',
               city: 'Porto Velho', uf: 'RO', ibge_code: '1100205', county_id: 1)
Address.create(cep: 76_810_160, complement: 'outro teste', street: 'Presidente dultra', neighborhood: 'Tancredo neves',
               city: 'Rio Branco', uf: 'AC', ibge_code: '1200401', county_id: 2)
Address.create(cep: 76_808_158, complement: 'teste bla bla bla', street: 'alvaro maia', neighborhood: 'Nova união',
               city: 'Adamantina', uf: 'SP', ibge_code: '3500105', county_id: 3)
Address.create(cep: 76_808_158, complement: 'teste bla', street: 'Rua estrela dalva', neighborhood: 'Belvederes',
               city: 'Rio de janeiro', uf: 'RJ', ibge_code: '3304557', county_id: 4)
Address.create(cep: 76_808_158, complement: 'teste bla bla', street: 'Rua nossa', neighborhood: 'Coahb', city: 'Goiania',
               uf: 'GO', ibge_code: '5208707', county_id: 5)
UserCounty.create(user_id: 1, county_id: 1)
UserCounty.create(user_id: 3, county_id: 2)
UserCounty.create(user_id: 5, county_id: 3)
UserCounty.create(user_id: 2, county_id: 4)
UserCounty.create(user_id: 4, county_id: 5)

Ext.setup({
    icon: 'icon.png',
    tabletStartupScreen: 'tablet_startup.png',
    phoneStartupScreen: 'phone_startup.png',
    glossOnIcon: false,
    onReady: function() {
        
				var form;
        
        var formBase = {
            scroll: false,
            url   : 'postUser.php',
            standardSubmit : false,
						defaults: {
							hidden: true,
							bodyPadding: 200
						},
            items: [{
                    xtype: 'fieldset',
                    title: '¿Cuántas horas por semana dedicas a estar conectado a internet?',
                    defaults: { xtype: 'selectfield' },
										items: [{
		                    xtype: 'selectfield',
		                    name: 'options',
												options: [
                        	{text: 'Menos de 5 horas',  value: '1'},
                        	{text: '5 a 9 horas', value: '2'},
                        	{text: '10 a 19 horas', value: '3'},
                        	{text: '20 horas o más', value: '4'}
                    			]}
										]},
										{
				             xtype: 'fieldset',
				             title: '¿Cuál es el motor de búsqueda de tú elección?',
				             defaults: { xtype: 'radiofield' },
										 
				             items: [
				                { name : 'color', label: 'Google', value : 1},
				                { name : 'color', label: 'Yahoo' , value : 2},
												{ name : 'color', label: 'Bing' , value : 3},
												{ name : 'color', label: 'Otro' , value : 4}
				             ]},
										 {
				             xtype: 'fieldset',
				             title: 'De la lista siguiente, selecciona las redes sociales en las que estás inscrito',
				             defaults: { xtype: 'checkboxfield' },
				             items: [
				                { name : 'color', label: 'Twitter', value : 1},
				                { name : 'color', label: 'Facebook' , value : 2},
												{ name : 'color', label: 'Orkut' , value : 3},
												{ name : 'color', label: 'Google +' , value : 4},
												{ name : 'color', label: 'Ninguna' , value : 5}
				             ]},
										{
					           xtype: 'fieldset',
					           title: '¿Cuentas con conocimientos en plataformas para publicación de contenidos tales como Wordpress, Harmony, Joomla, etc?',
					           defaults: { xtype: 'radiofield' },
					           items: [
					              { name : 'color', label: 'Si', value : 1},
					              { name : 'color', label: 'No' , value : 2},
					           ]}
            ],
            listeners : {
                submit : function(form, result){
                    console.log('success', Ext.toArray(arguments));
                },
                exception : function(form, result){
                    console.log('failure', Ext.toArray(arguments));
                }
            },
        
            dockedItems: []
        };

				if (Ext.is.Phone) {
            formBase.fullscreen = true;
        } else {
            Ext.apply(formBase, {
                autoRender: true,
                centered: true,
								float: true,
                hideOnMaskTap: false,
                layout: {
		                type: 'vbox',
		                align: 'stretch'
		            }
            });
        }

        form = new Ext.form.FormPanel(formBase);
        form.show();

				// Create a Carousel of Items
        var carousel1 = new Ext.Carousel({
						defaults: {
							cls: 'card'
						},
            items: [
            	form.items.get(0),
							form.items.get(1),
            	form.items.get(2),
							form.items.get(3)
						]
        });

        new Ext.Panel({
            fullscreen: true,
            layout: {
                type: 'vbox',
                align: 'stretch'
            },
            defaults: {
                flex: 1
            },
            items: [carousel1]
        });
        
        
    }
});
const { io } = require('../index');
const Band = require('../models/band');
const Bands = require('../models/bands');
const bands = new Bands();

bands.addBand( new Band('Queen') );
bands.addBand( new Band('Bon Jovi') );
bands.addBand( new Band('Caloncho') );
bands.addBand( new Band('The Strumbellas') );

console.log(bands);

// Socket messages
io.on('connection', client => {
    console.log('Client Connected');

    client.emit('active-bands', bands.getBands());
    
    client.on('disconnect', () => { 
        console.log('Client Disconnected');
    });
    
    client.on('message', (payload) => {
        console.log('Message', payload);

        io.emit( 'message', {admin: 'New Message'});
    });

    client.on('vote-band', (payload) => {

        bands.voteBand( payload.id );
        io.emit('active-bands', bands.getBands());
    });

    client.on('add-band', (payload) => {
        const newBand = new Band( payload.name );
        bands.addBand( newBand );
        io.emit('active-bands', bands.getBands());
    });
    
    client.on('delete-band', (payload) => {
        bands.deleteBand(payload.id);
        io.emit('active-bands', bands.getBands());
    });
  });
const functions = require('firebase-functions');

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

const nodemailer = require("nodemailer");

const transporter = nodemailer.createTransport({
	host: "smtp.gmail.com",
	port: 587,
	secure: false, // true for 465, false for other ports
	auth: {
	  user: 'vornvalentine@gmail.com', // generated ethereal user
	  pass: 'safiieugfokmbbms' // generated ethereal password
	}
});

const mailOptions = {
	from: 'vornvalentine@gmail.com',
	to: '',
	subject: 'Ticket Booking',
	text: 'Hi',
	html: '',
};

exports.sendMail = functions.https.onRequest(function(req, res) {
	// const query = req.query.text;

	mailOptions.html =
		`
		<p>
			Dear <b>${req.query.userName}</b>! We'd like to say thank you for keep using our service.
		</p></br></br>
		<p>Event Name: <b>${req.query.eventName}</b></p>
		<p>Ticket Number: <b>${req.query.number}</b></p>
		`;

	mailOptions.to = req.query.mailTo;
	
	transporter
		.sendMail(mailOptions)
		.then(function() {
			return { error: null, isOk: true };
		})
		.catch(function(error) {
			return { error: error.message, isOk: false };
		})
});

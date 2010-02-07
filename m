MIME-Version: 1.0
Date: Sun, 7 Feb 2010 22:43:44 +0200
Message-ID: <bcc5a9cc1002071243i27ed36a9k38152e5d29034ad4@domain.hid>
From: Jaryn Sepesi <jaryn.sepesi@domain.hid>
Content-Type: multipart/alternative; boundary=001485f87576a28c95047f08bd36
Subject: [Xenomai-help]  Analogy vs Comedi
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--001485f87576a28c95047f08bd36
Content-Type: text/plain; charset=ISO-8859-1

Hi everyone!

I'm designing a real-time system based on Xenomai and NI 6259 DAQ board.
Analogy contains a driver for my card, but there is one little problem. I
have some experience using this card with normal non-RT linux + Comedi, so I
know It needs to be calibrated via tools like comedi_soft_calibrate. I
didn't find any suitable equivalent of this tool in Xenomai documentation.

My question is - Is it possible to use Comedi tools (like mentioned
comedi_soft_calibrate) together with analogy driver? And if not, can I use
comedi driver combined with Xenomai? I mean for RT applications. (Yes, I
know this is definitely not a clean approach, but still better than use
different RTOS)

Thank you very much!

BR,
Jaryn Sepesi

--001485f87576a28c95047f08bd36
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi everyone!<br><br>I&#39;m designing a real-time system based on Xenomai a=
nd NI 6259 DAQ board. Analogy contains a driver for my card, but there is o=
ne little problem. I have some experience using this card with normal non-R=
T linux + Comedi, so I know It needs to be calibrated via tools like comedi=
_soft_calibrate. I didn&#39;t find any suitable equivalent of this tool in =
Xenomai documentation.<br>
<br>My question is - Is it possible to use Comedi tools (like mentioned com=
edi_soft_calibrate) together with analogy driver? And if not, can I use com=
edi driver combined with Xenomai? I mean for RT applications. (Yes, I know =
this is definitely not a clean approach, but still better than use differen=
t RTOS)<br>
<br>Thank you very much!<br><br>BR,<br>Jaryn Sepesi<br>

--001485f87576a28c95047f08bd36--


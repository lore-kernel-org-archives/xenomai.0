Message-ID: <709633.57305.qm@domain.hid>
Date: Tue, 19 Jan 2010 13:13:00 +0000 (GMT)
From: A C <adrien_chiron@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1510047286-1263906780=:57305"
Subject: [Adeos-main] hw interrupts off, __ipipe_handle_irq
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos <adeos-main@gna.org>

--0-1510047286-1263906780=:57305
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,=0Ain the comment before the definition of the function __ipipe_handl=
e_irq(), it is written : "hw interrupts are off on entry". For the isr of t=
he nios2, is it done (disable hw interrupts) in entry.s or in __ipipe_grab_=
irq() ? In fact, we do not find where it is done.=0ARegards=0AAdrien Chiron=
 & Vincent Vanbesien=0A=0A=0A=0A      
--0-1510047286-1263906780=:57305
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman,new york,times,serif;fon=
t-size:12pt"><div>Hello,<br>in the comment before the definition of the fun=
ction __ipipe_handle_irq(), it is written : "hw interrupts are off on entry=
". For the isr of the nios2, is it done (disable hw interrupts) in entry.s =
or in __ipipe_grab_irq() ? In fact, we do not find where it is done.<br>Reg=
ards<br>Adrien Chiron &amp; Vincent Vanbesien<br></div>=0A<!-- cg21.c41.mai=
l.ird.yahoo.com compressed Tue Jan 19 05:04:58 PST 2010 -->=0A</div><br>=0A=
=0A=0A=0A=0A      </body></html>
--0-1510047286-1263906780=:57305--


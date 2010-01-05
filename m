Message-ID: <307528.52616.qm@domain.hid>
Date: Tue, 5 Jan 2010 13:03:18 +0000 (GMT)
From: A C <adrien_chiron@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-486611790-1262696598=:52616"
Subject: [Adeos-main] __ipipe_walk_pipeline()
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos <adeos-main@gna.org>

--0-486611790-1262696598=:52616
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,=0AIn  __ipipe_handle_irq, there is a call to the function __ipipe_wa=
lk_pipeline() "that plays interrupts pending in the log", is it really the =
execution of the treatement linked to an interruption ? =0AIf yes, what hap=
pens when there is a new interruption ? In fact, we know that Hw interrupts=
 are off on entry. So, if a new interruption for a more prioritary domain c=
omes during the execution of __ipipe_walk_pipeline() for a less prioritary =
domain, how __ipipe_walk_pipeline() is preempted ?=0ACheers=0AAdrien Chiron=
 & Vincent Vanbesien=0A=0A=0A=0A      
--0-486611790-1262696598=:52616
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman,new york,times,serif;fon=
t-size:12pt"><div>Hello,<br>In&nbsp; __ipipe_handle_irq, there is a call to=
 the function __ipipe_walk_pipeline() "that plays interrupts pending in the=
 log", is it really the execution of the treatement linked to an interrupti=
on ? <br>If yes, what happens when there is a new interruption ? In fact, w=
e know that Hw interrupts are off on entry. So, if a new interruption for a=
 more prioritary domain comes during the execution of __ipipe_walk_pipeline=
() for a less prioritary domain, how __ipipe_walk_pipeline() is preempted ?=
<br>Cheers<br>Adrien Chiron &amp; Vincent Vanbesien<br></div>=0A<!-- cg21.c=
41.mail.ird.yahoo.com compressed/chunked Tue Jan  5 04:45:07 PST 2010 -->=
=0A</div><br>=0A=0A=0A=0A=0A      </body></html>
--0-486611790-1262696598=:52616--


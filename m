Message-ID: <784.75506.qm@domain.hid>
Date: Tue, 15 Dec 2009 14:42:33 +0000 (GMT)
From: A C <adrien_chiron@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1256412553-1260888153=:75506"
Subject: [Adeos-main] Porting Adeos-Ipipe on AVR32 (NGW 100),
	enable_pipeline.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos <adeos-main@gna.org>

--0-1256412553-1260888153=:75506
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,=0AWe are trying to implement the function enable_pipeline. =0A=0AFor=
 the NIOS2 architecture in this fonction there are calls to the functions _=
_ipipe_init_hrclock(), __ipipe_init_hrtimer(). So we checked those function=
s and we understand what they do. But there are still two questions :=0A- W=
here can we find the physical adresses of the clock (timer 64 bits) (named =
"na_hrclock") and of the timer (timer 32 bits) (named "na_hrtimer) ? We don=
't find the declaration.=0A=0A- Where is setting up the input clock frequen=
cy of the two timers (timer 64 bits and timer 32 bits)?=0A=0AFor the AVR32,=
 we have at least  two 16-bit timers, we are thinking about to do the same =
functions (__ipipe_init_hrclock(), __ipipe_init_hrtimer()). We think we can=
 also use the "ioremap_nocache" fonction. =0A=0ARegards=0A=0AAdrien Chiron =
and Vincent Vanbesien=0A=0A=0A=0A      
--0-1256412553-1260888153=:75506
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman,new york,times,serif;fon=
t-size:12pt"><div>Hello,<br>We are trying to implement the function enable_=
pipeline. <br><br>For the NIOS2 architecture in this fonction there are cal=
ls to the functions __ipipe_init_hrclock(), __ipipe_init_hrtimer(). So we c=
hecked those functions and we understand what they do. But there are still =
two questions :<br>- Where can we find the physical adresses of the clock (=
timer 64 bits) (named "na_hrclock") and of the timer (timer 32 bits) (named=
 "na_hrtimer) ? We don't find the declaration.<br><br>- Where is setting up=
 the input clock frequency of the two timers (timer 64 bits and timer 32 bi=
ts)?<br><br>For the AVR32, we have at least&nbsp; two 16-bit timers, we are=
 thinking about to do the same functions (__ipipe_init_hrclock(), __ipipe_i=
nit_hrtimer()). We think we can also use the "ioremap_nocache" fonction.
 <br><br>Regards<br><br>Adrien Chiron and Vincent Vanbesien<br></div>=0A<!-=
- cg14.c41.mail.ird.yahoo.com compressed/chunked Tue Dec 15 04:58:42 PST 20=
09 -->=0A</div><br>=0A=0A=0A=0A=0A      </body></html>
--0-1256412553-1260888153=:75506--


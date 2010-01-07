Message-ID: <449944.37907.qm@domain.hid>
Date: Thu, 7 Jan 2010 13:48:23 +0000 (GMT)
From: A C <adrien_chiron@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-255680901-1262872103=:37907"
Subject: [Adeos-main] __ipipe_grab_irq
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos <adeos-main@gna.org>

--0-255680901-1262872103=:37907
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,=0Ain the function __ipipe_grab_irq for the NIOS2, there is the follo=
wing block :=0A=0Aif (likely(irq =3D=3D __ipipe_hrtimer_irq)) {=0A        _=
_raw_get_cpu_var(__ipipe_tick_regs).estatus =3D regs->estatus;=0A        __=
raw_get_cpu_var(__ipipe_tick_regs).ea =3D regs->ea;=0A        if (!__ipipe_=
root_domain_p) {=0A            __raw_get_cpu_var(__ipipe_tick_regs).estatus=
 &=3D ~NIOS2_STATUS_PIE_MSK); =0A              }=0A    }=0A=0AWe do not und=
erstand why there is an unusual case for an interruption from the timer. We=
 understand each lines but not the global nature. Any help ?=0A=0ACheers=0A=
Adrien Chiron & Vincent Vanbesien=0A=0A=0A      
--0-255680901-1262872103=:37907
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman,new york,times,serif;fon=
t-size:12pt"><div>Hello,<br>in the function __ipipe_grab_irq for the NIOS2,=
 there is the following block :<br><br>if (likely(irq =3D=3D __ipipe_hrtime=
r_irq)) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; __raw_get_cpu_var(__ipip=
e_tick_regs).estatus =3D regs-&gt;estatus;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; __raw_get_cpu_var(__ipipe_tick_regs).ea =3D regs-&gt;ea;<br>&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (!__ipipe_root_domain_p) {<br>&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; __raw_get_cpu_var(__ipipe_ti=
ck_regs).estatus &amp;=3D ~NIOS2_STATUS_PIE_MSK); <br>&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; }<br><br=
>We do not understand why there is an unusual case for an interruption from=
 the timer. We understand each lines but not the global nature. Any help
 ?<br><br>Cheers<br>Adrien Chiron &amp; Vincent Vanbesien<br><br></div>=0A<=
!-- cg5.c41.mail.ird.yahoo.com compressed Thu Jan  7 04:51:55 PST 2010 -->=
=0A</div><br>=0A=0A=0A=0A=0A      </body></html>
--0-255680901-1262872103=:37907--


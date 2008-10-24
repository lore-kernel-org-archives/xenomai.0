Date: Fri, 24 Oct 2008 13:53:27 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-107273184-1224856407=:63324"
Message-ID: <258091.63324.qm@domain.hid>
Subject: Re: [Xenomai-help] trap exceptions in user
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

--0-107273184-1224856407=:63324
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I have upgraded the kernel to 2.6.24 + xenomai 2.4.5=0A=0AThe custom except=
ion doesn't work as I expected.=0A=0Astatic rthal_trap_handler_t old_trap_h=
andler;=0A  In an the kernel driver I set:=0Aold_trap_handler =3D rthal_tra=
p_catch(&custom_trap_fault);=0A  the custom handler is:=0Astatic int custom=
_trap_fault(unsigned event, unsigned domid, void *data)=0A{=0A  if (is_my_a=
pplication(...) && i_want_to_manage_exception(event)) {=0A    ManageCustomE=
xceptions();=0A    return RTHAL_EVENT_STOP; /* 1=3DSTOP */=0A }=0A return (=
(rthal_trap_handler_t) old_trap_handler)(event, domid, data);=0A}=0A=0AThe =
exception 7 is passed to the xenomai exception handler (TS flag).=0A=0AI co=
nsider now ManageCustomExceptions a function that do nothing.=0A=0AINT 3 or=
 1=0AAdeos does what I expected. It returns and nothing done.=0AThe program=
 continue happy to the next instruction.=0A=0AINT 0 (divide error) or 16 (f=
pu exception)=0AThe system hangs.=0AWhen I pass to xenomai It doesn't handl=
e the exception and relax the thread an propagate=0Ato linux (I think as ex=
pected to do).=0A[in the xnpod_trap_fault, xnpod_shadow_p is true then xnsh=
adow_relax is performed so the =0A routine return 0 (RTHAL_EVENT_PROPAGATE)=
]=0A=0AIs it possible to customize such exceptions? Am I missing something?=
=0A=0A    Gabriele=0A=0A=0A      Scopri il blog di Yahoo! Mail:=0ATrucchi, =
novit=C3=A0 e scrivi la tua opinione.=0Ahttp://www.ymailblogit.com/blog
--0-107273184-1224856407=:63324
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial,helvetica,sans-serif;font-size:10p=
t">I have upgraded the kernel to 2.6.24 + xenomai 2.4.5<br>=0A<br>The custo=
m exception doesn't work as I expected.<br><br>static rthal_trap_handler_t =
old_trap_handler;<br>&nbsp; In an the kernel driver I set:<br>old_trap_hand=
ler =3D rthal_trap_catch(&amp;custom_trap_fault);<br>&nbsp; the custom hand=
ler is:<br>static int custom_trap_fault(unsigned event, unsigned domid, voi=
d *data)<br>{<br>&nbsp; if (is_my_application(...) &amp;&amp; i_want_to_man=
age_exception(event)) {<br>&nbsp;&nbsp;&nbsp; ManageCustomExceptions();<br>=
&nbsp;&nbsp;&nbsp; return RTHAL_EVENT_STOP; /* 1=3DSTOP */<br>&nbsp;}<br>&n=
bsp;return ((rthal_trap_handler_t) old_trap_handler)(event, domid, data);<b=
r>}<br><br>The exception 7 is passed to the xenomai exception handler (TS f=
lag).<br><br>I consider now ManageCustomExceptions a function that do nothi=
ng.<br><br>INT 3 or 1<br>Adeos does what I expected. It returns and nothing=
 done.<br>The program continue happy to the next instruction.<br><br>INT 0 =
(divide error) or 16 (fpu exception)<br>The system
 hangs.<br>When I pass to xenomai It doesn't handle the exception and relax=
 the thread an propagate<br>to linux (I think as expected to do).<br>=0A[in=
 the xnpod_trap_fault, xnpod_shadow_p is true then xnshadow_relax is perfor=
med so the <br>&nbsp;routine return 0 (RTHAL_EVENT_PROPAGATE)]<br><br>Is it=
 possible to customize such exceptions? Am I missing something?<br><br>&nbs=
p;&nbsp;&nbsp; Gabriele<br><br></div><br>=0A=0A=0A=0A      <hr size=3D1><fo=
nt face=3D"Arial" size=3D"2">Scopri il <a href=3D"http://us.rd.yahoo.com/ma=
il/it/taglines/yahoo/ymail/SIG=3D11djrg460/**http%3A%2F%2Fwww.ymailblogit.c=
om%2Fblog%2F"> Blog di Yahoo! Mail</a>: trucchi, novit=C3=A0, consigli... e=
 scrivi la tua opinione!</font></body></html>
--0-107273184-1224856407=:63324--


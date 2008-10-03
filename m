Date: Fri, 3 Oct 2008 12:30:33 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-151598186-1223037033=:12208"
Message-ID: <118594.12208.qm@domain.hid>
Subject: [Xenomai-help] trap exceptions in user
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

--0-151598186-1223037033=:12208
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0AI need to trap and manage  exceptions (floating point for example).=0AI =
want to execute at user domain (x86-ring 3) something like that=0A=0Areal_t=
ime_task function:=0A{=0A  <set exception handlers> (for example fpu_handle=
r)=0A=0A  <real time code (asm x86)>  (this code need  custom management of=
 exceptions)=0A=0A  <release exception handlers>=0A}=0A=0Afpu_handler funct=
ion=0A{=0A  ...=0A}=0A=0AI need to customize some exception (fpu is the mos=
t important) inside real time.=0AHow can I do that?=0AIs it possible in  th=
e rt user domain? And what about that in the rt-kernel domain?=0A=0AThank y=
ou=0A=0A=0A      Scopri il blog di Yahoo! Mail:=0ATrucchi, novit=C3=A0 e la=
 tua opinione.=0Ahttp://www.ymailblogit.com/blog
--0-151598186-1223037033=:12208
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:10pt"><div><br>I need to trap and manage&nbsp; exceptions (floati=
ng point for example).<br>I want to execute at user domain (x86-ring 3) som=
ething like that<br><br>real_time_task function:<br>{<br>&nbsp; &lt;set exc=
eption handlers&gt; (for example fpu_handler)<br><br>&nbsp; &lt;real time c=
ode (asm x86)&gt;&nbsp; (this code need&nbsp; custom management of exceptio=
ns)<br><br>&nbsp; &lt;release exception handlers&gt;<br>}<br><br>fpu_handle=
r function<br>{<br>&nbsp; ...<br>}<br><br>I need to customize some exceptio=
n (fpu is the most important) inside real time.<br>How can I do that?<br>Is=
 it possible in&nbsp; the rt user domain? And what about that in the rt-ker=
nel domain?<br><br>Thank you<br><br></div></div><br>=0A=0A=0A=0A      <hr s=
ize=3D1><font face=3D"Arial" size=3D"2">Scopri il <a href=3D"http://us.rd.y=
ahoo.com/mail/it/taglines/yahoo/ymail/SIG=3D11djrg460/**http%3A%2F%2Fwww.ym=
ailblogit.com%2Fblog%2F"> Blog di Yahoo! Mail</a>: trucchi, novit=C3=A0, co=
nsigli... e anche la tua opinione!</font></body></html>
--0-151598186-1223037033=:12208--


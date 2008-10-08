Date: Wed, 8 Oct 2008 10:34:46 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2060974364-1223462086=:90718"
Message-ID: <563071.90718.qm@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

--0-2060974364-1223462086=:90718
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0A=0A>I think you are traping yourself with impossible constraints.=0A>=0A=
>Anyway, the only way is register a custom exception handler using rthal=0A=
>functions. In your trap handler, you may wake up a user-space server=0A>th=
read which role is to handle exceptions (in user-space). This means that:=
=0A>- upon exception, you have a switch to the user-space server thread=0A>=
context, this will be slow;=0A=0ADo I change rthal inside xenomai? How can =
I do?=0AIs there a benchmark or some number to understand better this slown=
ess (in us)?=0A=0A>- you have to rewrite the exception handling code, you c=
an not rely=0A>on the exception handling code that was written in the assem=
bly blob.=0A>=0A>I do not think it is a good idea to simply override the ex=
ception=0A>vectors, the kernel uses them, and you certainly want the kernel=
 to=0A>continue working.=0A =0AYes I think so=0A=0ANow SIS is about 500 kb =
of pure asm and works with a big cli on start and a sti=0Aon finish @ring 0=
 and reprogram the exception vectors but I want to integrate into xenomai. =
=0A=0AProposal:=0A=0A- At start SIS save the addresses of the exception vec=
tors=0A- When an exception is raised then the processor switch to the custo=
m exception vectors but=0A  if the SIS is not currently active then jump to=
 the old exception vectors=0A=0AIs it possible?=0A=0ASorry for the large nu=
mber of questions=0A=0A=0A      Scopri il blog di Yahoo! Mail:=0ATrucchi, n=
ovit=C3=A0 e scrivi la tua opinione.=0Ahttp://www.ymailblogit.com/blog
--0-2060974364-1223462086=:90718
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:10pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 10pt;"><span style=3D"font-family: arial,helvetica,sans-se=
rif;"></span><div style=3D"font-family: arial,helvetica,sans-serif; font-si=
ze: 10pt;"><br><span style=3D"font-family: arial,helvetica,sans-serif;"></s=
pan><br>&gt;I think you are traping yourself with impossible constraints.<b=
r>&gt;<br>&gt;Anyway, the only way is register a custom exception handler u=
sing rthal<br>&gt;functions. In your trap handler, you may wake up a user-s=
pace server<br>&gt;thread which role is to handle exceptions (in user-space=
). This means that:<br>&gt;- upon exception, you have a switch to the user-=
space server thread<br>&gt;context, this will be slow;<br><br>Do I change r=
thal inside xenomai? How can I do?<br>Is there a benchmark or some number t=
o
 understand better this slowness (in us)?<br><br>&gt;- you have to rewrite =
the exception handling code, you can not rely<br>&gt;on the exception handl=
ing code that was written in the assembly blob.<br>&gt;<br>&gt;I do not thi=
nk it is a good idea to simply override the exception<br>&gt;vectors, the k=
ernel uses them, and you certainly want the kernel to<br>&gt;continue worki=
ng.<br>&nbsp;<br>Yes I think so<br><br>Now SIS <span style=3D"font-family: =
arial,helvetica,sans-serif;">is about 500 kb of pure asm and </span>works w=
ith a big cli on start and a sti<br>on finish @ring 0 and reprogram the exc=
eption vectors but I want to integrate into xenomai. <br><br>Proposal:<br><=
br>- At start SIS save the addresses of the exception vectors<br>- When an =
exception is raised then the processor switch to the custom exception vecto=
rs but<br>&nbsp; if the SIS is not currently active then jump to the old ex=
ception vectors<br><br>Is it possible?<br><br>Sorry for the large
 number of questions<br><br><br></div></div></div><br>=0A=0A=0A=0A      <hr=
 size=3D1><font face=3D"Arial" size=3D"2">Scopri il <a href=3D"http://us.rd=
.yahoo.com/mail/it/taglines/yahoo/ymail/SIG=3D11djrg460/**http%3A%2F%2Fwww.=
ymailblogit.com%2Fblog%2F"> Blog di Yahoo! Mail</a>: trucchi, novit=C3=A0, =
consigli... e scrivi la tua opinione!</font></body></html>
--0-2060974364-1223462086=:90718--


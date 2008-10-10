Date: Fri, 10 Oct 2008 13:50:36 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1742083866-1223646636=:70429"
Message-ID: <39918.70429.qm@domain.hid>
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

--0-1742083866-1223646636=:70429
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0A=0A> Xenomai uses rthal_trap_catch, so, you can use Xenomai code as an e=
xample.=0A=0ANamed=0AKD: kernel driver (ring 0).=0AUD: user space task (rin=
g 3).=0A=0A- KD reserve 16 MB  of memory (note: virtual and physical contig=
uous)=0A=0A- I use rthal_trap_catch to customize exceptions (redirected to =
"custom_except" function)=0A  The "custom_except" function print the number=
 of exception and recall the xenomai standard one.=0A=0A- KD has an rtdm in=
terface to map the 16 MB memory on user space with rtdm_iomap_to_user.=0A=
=0A- UD starts and It maps with the rtdm (rtdm_iomap_to_user)=0A=0A- UD cop=
y a binary asm x86 test fpu (some instructions to generate exceptions for t=
ests) in the 16 MB memory mapped=0A=0A- UD start the real time task=0A=0ANo=
w here is a the problem.=0AIf I invoke an exception (int 3, floating point =
exception and so on) outside the 16 MB mapped memory "custom_except" is cal=
led ok.=0AIf the same code is invoked into the 16 MB mapped memory the prog=
ram crash (and this is ok) reporting the description of the exception in th=
e terminal (also this is ok) but "custom_except" is not called!=0A=0AIs the=
re something wrong using the mapped memory in this mode?=0A=0ANOTE:=0AI am =
using xenomai 2.4.0rc1 with kernel 2.6.23=0A=0A=0A      Scopri il blog di Y=
ahoo! Mail:=0ATrucchi, novit=C3=A0 e scrivi la tua opinione.=0Ahttp://www.y=
mailblogit.com/blog
--0-1742083866-1223646636=:70429
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial,helvetica,sans-serif;font-size:10p=
t"><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;"=
><br><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt=
;">&gt; Xenomai uses rthal_trap_catch, so, you can use Xenomai code as an e=
xample.<br><br>Named<br>KD: kernel driver (ring 0).<br>UD: user space task =
(ring 3).<br><br>- KD reserve 16 MB&nbsp; of memory (note: virtual and phys=
ical contiguous)<br><br>- I use rthal_trap_catch to customize exceptions (r=
edirected to "custom_except" function)<br>&nbsp; The "custom_except" functi=
on print the number of exception and recall the xenomai standard one.<br><b=
r>- KD has an rtdm interface to map the 16 MB memory on user space with rtd=
m_iomap_to_user.<br><br>- UD starts and It maps with the rtdm (rtdm_iomap_t=
o_user)<br><br>- UD copy a binary asm x86 test fpu (some instructions to
 generate exceptions for tests) in the 16 MB memory mapped<br><br>- UD star=
t the real time task<br><br>Now here is a the problem.<br>If I invoke an ex=
ception (int 3, floating point exception and so on) outside the 16 MB mappe=
d memory "custom_except" is called ok.<br>If the same code is invoked into =
the 16 MB mapped memory the program crash (and this is ok) reporting the de=
scription of the exception in the terminal (also this is ok) but "custom_ex=
cept" is not called!<br><br>Is there something wrong using the mapped memor=
y in this mode?<br><br>NOTE:<br>I am using xenomai 2.4.0rc1 with kernel 2.6=
.23<br><br></div></div></div><br>=0A=0A=0A=0A      <hr size=3D1><font face=
=3D"Arial" size=3D"2">Scopri il <a href=3D"http://us.rd.yahoo.com/mail/it/t=
aglines/yahoo/ymail/SIG=3D11djrg460/**http%3A%2F%2Fwww.ymailblogit.com%2Fbl=
og%2F"> Blog di Yahoo! Mail</a>: trucchi, novit=C3=A0, consigli... e scrivi=
 la tua opinione!</font></body></html>
--0-1742083866-1223646636=:70429--


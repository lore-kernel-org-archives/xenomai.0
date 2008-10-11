Date: Sat, 11 Oct 2008 19:32:40 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1318023392-1223753560=:51777"
Message-ID: <333188.51777.qm@domain.hid>
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

--0-1318023392-1223753560=:51777
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0A>Yes, but I still think this is useless. If your user-space code expects=
=0A>to be running from 1MB to 16MB, it expects this for virtual addresses,=
=0A>not for physical addresses. So, I really think you should mmap the 1MB=
=0A>to 16MB region by passing the start address to mmap with the MMAP_FIXED=
=0A>flag.=0A=0AI know my way to solve this problem is very strange but ther=
e are some reasons.=0AIt is done for compatibility reasons (DMA and a stran=
ge architecture with custom gdt entries needed by the asm blob...)=0AIn thi=
s application I don't need contiguous physical addresses so I will try the =
mmap fixed way.=0AI didn't only want to fork the driver but it is not a big=
 problem...=0A=0A>You should trace the exception path in the I-pipe patch t=
o find the=0A>point where your exception handling callback is not called.=
=0A=0Awill it be a large print work or there are another ways to do that? :=
)=0A=0A    Gabriele=0A=0A=0A      Scopri il blog di Yahoo! Mail:=0ATrucchi,=
 novit=C3=A0 e scrivi la tua opinione.=0Ahttp://www.ymailblogit.com/blog
--0-1318023392-1223753560=:51777
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial,helvetica,sans-serif;font-size:10p=
t"><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;"=
><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;"><=
br>&gt;Yes, but I still think this is useless. If your user-space code expe=
cts<br>&gt;to be running from 1MB to 16MB, it expects this for virtual addr=
esses,<br>&gt;not for physical addresses. So, I really think you should mma=
p the 1MB<br>&gt;to 16MB region by passing the start address to mmap with t=
he MMAP_FIXED<br>&gt;flag.<br><br>I know my way to solve this problem is ve=
ry strange but there are some reasons.<br>It is done for compatibility reas=
ons (DMA and a strange architecture with custom gdt entries needed by the a=
sm blob...)<br>In this application I don't need contiguous physical address=
es so I will try the mmap fixed way.<br>I didn't only want to fork the
 driver but it is not a big problem... <br><br>&gt;You should trace the exc=
eption path in the I-pipe patch to find the<br>&gt;point where your excepti=
on handling callback is not called.<br><br>will it be a large print work or=
 there are another ways to do that? :)<br><br>&nbsp;&nbsp;&nbsp; Gabriele<b=
r><br></div></div></div><br>=0A=0A=0A=0A      <hr size=3D1><font face=3D"Ar=
ial" size=3D"2">Scopri il <a href=3D"http://us.rd.yahoo.com/mail/it/tagline=
s/yahoo/ymail/SIG=3D11djrg460/**http%3A%2F%2Fwww.ymailblogit.com%2Fblog%2F"=
> Blog di Yahoo! Mail</a>: trucchi, novit=C3=A0, consigli... e scrivi la tu=
a opinione!</font></body></html>
--0-1318023392-1223753560=:51777--


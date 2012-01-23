MIME-Version: 1.0
Sender: manuel.vonthron@domain.hid
In-Reply-To: <4F1DBC6B.3070502@domain.hid>
References: <CA+vRzyJBZswywEyhG8JUXZRr3j7tKwhOaT1nKJti4ScLn7sZLg@domain.hid>
	<4F173B1C.3000300@domain.hid>
	<CA+vRzy+ezWaWjp3mnGgD5VGaHqzcrK7MN47sww48y6xqT1NT9A@mail.gmail.com>
	<4F187F9B.4070203@domain.hid>
	<CA+vRzyLS2gMFBWCVZqv2oeSENvxacUugVViMXN+yGAMz5ubrxg@domain.hid>
	<4F1DBC6B.3070502@domain.hid>
From: Manuel Vonthron <manuel.vonthron@domain.hid>
Date: Mon, 23 Jan 2012 15:19:18 -0500
Message-ID: <CA+vRzy+X7ufmgKpveu+mRUCj6CYfB=WWZ0XbnKP8aXQZLN-tnQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary=bcaec50160cfff315704b737bf88
Subject: Re: [Xenomai-help] "Inappropriate ioctl for device" with
 xeno_16550A on Xenomai 2.6, not Xenomai 2.5
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--bcaec50160cfff315704b737bf88
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

> I guess you would get some error message if the driver was not working,
> did you check the kernel logs?
>

There isn't  even a warning. Here is what I get when running my app (from
syslog):
  Jan 23 15:14:38 mrsub kernel: [445923.280301] Xenomai: RTDM: closing file
descriptor 0.
  Jan 23 15:14:38 mrsub kernel: [445923.301782] Xenomai: native: cleaning
up heap "" (ret=3D0).
  Jan 23 15:14:38 mrsub kernel: [445923.323247] Xenomai: native: cleaning
up mutex "ctrl-mutex" (ret=3D0).

(on a separate note, in this log, the RT heap name isn't found while it
actually exists in /proc/xenomai/heap)

I have no message when "modprobing" the driver.




> >
> > Thanks
> >
> >
> >
>
>
> --
>                                                                Gilles.
>



--=20
Manuel Vonthron
Laboratoire de Nanorobotique
=C9cole Polytechnique de Montr=E9al
Montr=E9al, QC
http://nano.polymtl.ca/

--bcaec50160cfff315704b737bf88
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br>
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">I guess you would=
 get some error message if the driver was not working,<br>
did you check the kernel logs?<br></blockquote><div><br>There isn&#39;t=A0 =
even a warning. Here is what I get when running my app (from syslog):<br>=
=A0 Jan 23 15:14:38 mrsub kernel: [445923.280301] Xenomai: RTDM: closing fi=
le descriptor 0.<br>

=A0 Jan 23 15:14:38 mrsub kernel: [445923.301782] Xenomai: native: cleaning=
 up heap &quot;&quot; (ret=3D0).<br>=A0 Jan 23 15:14:38 mrsub kernel: [4459=
23.323247] Xenomai: native: cleaning up mutex &quot;ctrl-mutex&quot; (ret=
=3D0).<br>

<br>(on a separate note, in this log, the RT heap name isn&#39;t found whil=
e it actually exists in /proc/xenomai/heap)<br><br>I have no message when &=
quot;modprobing&quot; the driver.<br><br><br>=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">


&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt;<br>
&gt;<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br>Manuel Vo=
nthron<br>Laboratoire de Nanorobotique<br>=C9cole Polytechnique de Montr=E9=
al<br>Montr=E9al, QC<br><a href=3D"http://nano.polymtl.ca/" target=3D"_blan=
k">http://nano.polymtl.ca/</a><br>



--bcaec50160cfff315704b737bf88--


MIME-Version: 1.0
Sender: manuel.vonthron@domain.hid
In-Reply-To: <4F187F9B.4070203@domain.hid>
References: <CA+vRzyJBZswywEyhG8JUXZRr3j7tKwhOaT1nKJti4ScLn7sZLg@domain.hid>
	<4F173B1C.3000300@domain.hid>
	<CA+vRzy+ezWaWjp3mnGgD5VGaHqzcrK7MN47sww48y6xqT1NT9A@mail.gmail.com>
	<4F187F9B.4070203@domain.hid>
From: Manuel Vonthron <manuel.vonthron@domain.hid>
Date: Mon, 23 Jan 2012 14:53:09 -0500
Message-ID: <CA+vRzyLS2gMFBWCVZqv2oeSENvxacUugVViMXN+yGAMz5ubrxg@domain.hid>
Content-Type: multipart/alternative; boundary=20cf3071c6aea394de04b737627c
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

--20cf3071c6aea394de04b737627c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2012 at 3:39 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> gcc 4.6.2 definitely needs -fno-omit-frame-pointer. Stupid suggestion:
> if you re-used the same build directory for xenomai user-space, did you
> think about running "make clean" after reconfiguring?
>

I wasn't using the same build directory. And as far as my own program is
concerned, I "make clean" before each compilation.
However I just saw one difference on the kernel configuration,
RT/drivers/Serial
  - on the working (2.5) machine, access mode is set to "any"
  - on the other one (2.6), access mode is set to "port-based" only

Can this setting be the cause of my problem ?

Thanks



--=20
Manuel Vonthron
Laboratoire de Nanorobotique
=C9cole Polytechnique de Montr=E9al
Montr=E9al, QC
http://nano.polymtl.ca/

--20cf3071c6aea394de04b737627c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Thu, Jan 19, 2012 at 3:39 PM, Gilles Chantepe=
rdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org.=
org" target=3D"_blank">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrot=
e:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
gcc 4.6.2 definitely needs -fno-omit-frame-pointer. Stupid suggestion:<br>
if you re-used the same build directory for xenomai user-space, did you<br>
think about running &quot;make clean&quot; after reconfiguring?<br></blockq=
uote><div><br>I wasn&#39;t using the same build directory. And as far as my=
 own program is concerned, I &quot;make clean&quot; before each compilation=
.<br>

However I just saw one difference on the kernel configuration, RT/drivers/S=
erial<br>=A0 - on the working (2.5) machine, access mode is set to &quot;an=
y&quot;<br>=A0 - on the other one (2.6), access mode is set to &quot;port-b=
ased&quot; only<br>

<br>Can this setting be the cause of my problem ?<br clear=3D"all"><br></di=
v></div>Thanks<br><br><br><br>-- <br>Manuel Vonthron<br>Laboratoire de Nano=
robotique<br>=C9cole Polytechnique de Montr=E9al<br>Montr=E9al, QC<br><a hr=
ef=3D"http://nano.polymtl.ca/" target=3D"_blank">http://nano.polymtl.ca/</a=
><br>





--20cf3071c6aea394de04b737627c--


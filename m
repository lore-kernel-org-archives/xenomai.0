MIME-Version: 1.0
Sender: manuel.vonthron@domain.hid
In-Reply-To: <4F173B1C.3000300@domain.hid>
References: <CA+vRzyJBZswywEyhG8JUXZRr3j7tKwhOaT1nKJti4ScLn7sZLg@domain.hid>
	<4F173B1C.3000300@domain.hid>
From: Manuel Vonthron <manuel.vonthron@domain.hid>
Date: Wed, 18 Jan 2012 16:56:33 -0500
Message-ID: <CA+vRzy+ezWaWjp3mnGgD5VGaHqzcrK7MN47sww48y6xqT1NT9A@mail.gmail.com>
Content-Type: multipart/alternative; boundary=20cf3079ba569e430e04b6d486ad
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

--20cf3079ba569e430e04b6d486ad
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

"-fno-omit-frame-pointer" doesn't fix the problem but gcc versions are
indeed different:
  - gcc 4.3.2 on the "working" machine
  - gcc 4.6.2 on the other

Thanks for your help


On Wed, Jan 18, 2012 at 4:35 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 01/18/2012 10:09 PM, Manuel Vonthron wrote:
> > Dear all,
> >
> > I am using the driver "xeno_16550A" for serial communication between a
> > powersupply and its controlling PC (x86). I started working with Xenoma=
i
> > 2.5.5, but I recently switched to another machine where I installed
> Xenomai
> > 2.6.
> >
> > On this new machine, I get the "Inappropriate ioctl for device" error
> while
> > setting up my serial connection:
> >   err =3D rt_dev_ioctl(fd, RTSER_RTIOC_SET_CONFIG, &serial_config);
> >   >> error -25: Inappropriate ioctl for device
> > The following reads/writes don't fail but without proper configuration,
> > messages aren't understood by the device.
> >
> > My tests with non-RT code and the regular Linux driver keeps working wi=
th
> > this new machine and again, the RT code is the very same, I only update=
d
> my
> > Makefile to match the new version.
> >
> > - setserial infos:
> >   /dev/ttyS0 uart 16550A port 0x03f8 irq 4 baud_base 115200 spd_normal
> > skip_test
> > - xeno_16550A loaded with:
> >   `modprobe -v xeno_16550A io=3D0x03f8 irq=3D4 baud_base=3D115200`
> > - result of "rtdm" unit test:
> >   SetupExclusive openSuccessive openDefer close by driver handlerDefer
> > close by pending referenceNormal closeDeferred module unload#
> >
> > Do you have any idea where the error comes from and how would I fix it?
>
> It could be due to the version of gc. Try passing
> CFLAGS=3D"-fno-omit-frame-pointer"
> on configure commande line.
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

--20cf3079ba569e430e04b6d486ad
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

&quot;-fno-omit-frame-pointer&quot; doesn&#39;t fix the problem but gcc ver=
sions are indeed different:<br>=A0 - gcc 4.3.2 on the &quot;working&quot; m=
achine<br>=A0 - gcc 4.6.2 on the other <br><br>Thanks for your help<br><br>=
<br>

<div class=3D"gmail_quote">On Wed, Jan 18, 2012 at 4:35 PM, Gilles Chantepe=
rdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org.=
org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">

<div class=3D"im">On 01/18/2012 10:09 PM, Manuel Vonthron wrote:<br>
&gt; Dear all,<br>
&gt;<br>
&gt; I am using the driver &quot;xeno_16550A&quot; for serial communication=
 between a<br>
&gt; powersupply and its controlling PC (x86). I started working with Xenom=
ai<br>
&gt; 2.5.5, but I recently switched to another machine where I installed Xe=
nomai<br>
&gt; 2.6.<br>
&gt;<br>
&gt; On this new machine, I get the &quot;Inappropriate ioctl for device&qu=
ot; error while<br>
&gt; setting up my serial connection:<br>
&gt; =A0 err =3D rt_dev_ioctl(fd, RTSER_RTIOC_SET_CONFIG, &amp;serial_confi=
g);<br>
&gt; =A0 &gt;&gt; error -25: Inappropriate ioctl for device<br>
&gt; The following reads/writes don&#39;t fail but without proper configura=
tion,<br>
&gt; messages aren&#39;t understood by the device.<br>
&gt;<br>
&gt; My tests with non-RT code and the regular Linux driver keeps working w=
ith<br>
&gt; this new machine and again, the RT code is the very same, I only updat=
ed my<br>
&gt; Makefile to match the new version.<br>
&gt;<br>
&gt; - setserial infos:<br>
&gt; =A0 /dev/ttyS0 uart 16550A port 0x03f8 irq 4 baud_base 115200 spd_norm=
al<br>
&gt; skip_test<br>
&gt; - xeno_16550A loaded with:<br>
&gt; =A0 `modprobe -v xeno_16550A io=3D0x03f8 irq=3D4 baud_base=3D115200`<b=
r>
&gt; - result of &quot;rtdm&quot; unit test:<br>
&gt; =A0 SetupExclusive openSuccessive openDefer close by driver handlerDef=
er<br>
&gt; close by pending referenceNormal closeDeferred module unload#<br>
&gt;<br>
&gt; Do you have any idea where the error comes from and how would I fix it=
?<br>
<br>
</div>It could be due to the version of gc. Try passing<br>
CFLAGS=3D&quot;-fno-omit-frame-pointer&quot;<br>
on configure commande line.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br>Manuel Vo=
nthron<br>Laboratoire de Nanorobotique<br>=C9cole Polytechnique de Montr=E9=
al<br>Montr=E9al, QC<br><a href=3D"http://nano.polymtl.ca/" target=3D"_blan=
k">http://nano.polymtl.ca/</a><br>



--20cf3079ba569e430e04b6d486ad--


MIME-Version: 1.0
In-Reply-To: <4D88012F.5010601@domain.hid>
References: <AANLkTinbWB880bzWqR2o-6Ah2A_iZCucMQU-HaOcunEL@mail.gmail.com>
	<4D88012F.5010601@domain.hid>
Date: Wed, 23 Mar 2011 08:24:26 -0300
Message-ID: <AANLkTim=CnW9SkjOkJNFe0ZG_6F9Nmcp6UBa=R=Ex65r@domain.hid>
From: Rodrigo Muraro <rodrigo.muraro@domain.hid>
Content-Type: multipart/alternative; boundary=0015174c13287f3b4f049f249a2c
Subject: Re: [Adeos-main] port du Xenomai
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

--0015174c13287f3b4f049f249a2c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks,

The timer was ticking, the problem was the USB driver.

Rodrigo

2011/3/21 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Rodrigo Muraro wrote:
> > Salut,
> >
> > Je suis en train de porter Xenomai pour le processeur OMAP-L138.
> >
> > Je suis parti du kernel 2.6.34 fourni par Texas Instruments e j'ai
> applique
> > le patch I-pipe Xenomai 2.5.4.
>
> You probably would better start with 2.6.35, as it already has an I-pipe
> patch:
>
> http://download.gna.org/adeos/patches/v2.6/arm/adeos-ipipe-2.6.35.9-arm-1=
.18-01.patch
>
> The current version of Xenomai is 2.5.6.
>
> >
> > Ensuite j'ai suivi les indications d=E9crites dans le document suivant:
> > http://www.xenomai.org/index.php/I-pipe:ArmPorting
> >
> > J'ai modifi=E9 que le fichier time.c du repertoire arch/arm/mach-davinc=
i
> >
> > Le kernel se bloque pendant l'initialisation du pilote USB, plus
> pr=E9cis=E9ment
> > apr=E8s l'appel =E0 la fonction msleep.
>
> Tips and tricks #2. Check that the timer is ticking.
>
> Please note that for an easier access to everybody, this list uses the
> english language.
>
> --
>                                                                 Gilles.
>
>

--0015174c13287f3b4f049f249a2c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks,<br><br>The timer was ticking, the problem was the USB driver.<br><b=
r>Rodrigo<br><br><div class=3D"gmail_quote">2011/3/21 Gilles Chanteperdrix =
<span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">g=
illes.chanteperdrix@domain.hid</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=3D"im"=
>Rodrigo Muraro wrote:<br>
&gt; Salut,<br>
&gt;<br>
&gt; Je suis en train de porter Xenomai pour le processeur OMAP-L138.<br>
&gt;<br>
&gt; Je suis parti du kernel 2.6.34 fourni par Texas Instruments e j&#39;ai=
 applique<br>
&gt; le patch I-pipe Xenomai 2.5.4.<br>
<br>
</div>You probably would better start with 2.6.35, as it already has an I-p=
ipe<br>
patch:<br>
<a href=3D"http://download.gna.org/adeos/patches/v2.6/arm/adeos-ipipe-2.6.3=
5.9-arm-1.18-01.patch" target=3D"_blank">http://download.gna.org/adeos/patc=
hes/v2.6/arm/adeos-ipipe-2.6.35.9-arm-1.18-01.patch</a><br>
<br>
The current version of Xenomai is 2.5.6.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; Ensuite j&#39;ai suivi les indications d=E9crites dans le document sui=
vant:<br>
&gt; <a href=3D"http://www.xenomai.org/index.php/I-pipe:ArmPorting" target=
=3D"_blank">http://www.xenomai.org/index.php/I-pipe:ArmPorting</a><br>
&gt;<br>
&gt; J&#39;ai modifi=E9 que le fichier time.c du repertoire arch/arm/mach-d=
avinci<br>
&gt;<br>
&gt; Le kernel se bloque pendant l&#39;initialisation du pilote USB, plus p=
r=E9cis=E9ment<br>
&gt; apr=E8s l&#39;appel =E0 la fonction msleep.<br>
<br>
</div>Tips and tricks #2. Check that the timer is ticking.<br>
<br>
Please note that for an easier access to everybody, this list uses the<br>
english language.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
<br>
</font></blockquote></div><br>

--0015174c13287f3b4f049f249a2c--


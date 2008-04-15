Date: Tue, 15 Apr 2008 21:17:09 +0200
Message-Id: <1071861222@domain.hid>
MIME-Version: 1.0
From: Jochen Behnke <JK.Behnke@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] system() call allowed from within RT task ?
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
Cc: xenomai@xenomai.org


> -----Urspr=FCngliche Nachricht-----
> Von: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> Gesendet: 15.04.08 19:02:58
> An: Jochen Behnke <JK.Behnke@domain.hid>
> CC: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] system() call allowed from within RT task =3F

Hello Gilles,

thanks four your quick response.=20
Which I-pipe/Xenomai version would you recommend =3F
(probably the latest )

Regards
Jochen

>=20
> Jochen Behnke wrote:
>  > Hello,
>  >=20
>  > within my application I use system() calls from within a xenomai task=
.
>  > Is this allowed =3F
>  >=20
>  > The reason I'm asking this, is the following:
>  > In my application I have multiple xenomai tasks. One of them is time =
critical (Task=5FA).
>  > An other (non time critical) xenomai task (Task=5FB) is used to pass da=
ta back
>  > and forth between Task=5FA and normal linux tasks. Task=5FB uses the syst=
em()-call
>  > to accomplish certain requests.
>  > I have set the T=5FWARNSW for Task=5FA in order to get a SIGXCPU, wheneve=
r it switches
>  > to secondary mode. As long as Task=5FB is not executing a sytem() call,=
 everything is fine.
>  > But when for example Task=5FB executes a system("cp -R dirA dirB") the =
application terminates
>  > due to a SIGXCPU signal.
>  >=20
>  > I'm using=20
>  > - Linux Kernel 2.6.17 (I-PIPE 1.5-02)
>=20
> I-pipe 1.5-02 is too old. only more recent I-pipe patches have the
> necessary support to allow real-time applications to call fork (or
> system).
>=20
>=20
> --=20
>=20
>=20
> 					    Gilles.
>=20


=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Unbegrenzter Speicherplatz f=FCr Ihr E-Mail Postfach=3F Jetzt aktivieren!
http://freemail.web.de/club/landingpage.htm/=3Fmc=3D025555



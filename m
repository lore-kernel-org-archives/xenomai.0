From: Leopold Palomo Avellaneda <lepalom@domain.hid>
Date: Fri, 21 Sep 2007 09:10:32 +0200
References: <200709201549.13035.lepalom@domain.hid>
	<200709210036.51949.berlemont.hauw@domain.hid>
In-Reply-To: <200709210036.51949.berlemont.hauw@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2165065.0CROJaDZMp";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200709210910.37620.lepalom@domain.hid>
Subject: Re: [Xenomai-help] Comedi driver for use with xenomai
Reply-To: lepalom@domain.hid
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

--nextPart2165065.0CROJaDZMp
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

A Divendres 21 Setembre 2007 00:36, Alexis Berlemont va escriure:
> Hi,
>
> > some time ago, Alexis Berlemont posted this message [1] about the
> > possibility to use a comedi (or modified) driver with xenomai .
> >
> > My question is: there's a driver in comedi that I would like to use with
> > xenomai. Is this possible?
>
> Currently, the RTDM version of Comedi supports only test drivers. I have
> tried to port some NI drivers just so as to ensure that my Comedi
> infrastructure was coherent.

Ok, what is a NI driver?

> However, if you want to add a new driver which comes from the original
> Comedi set, there will be little work to do as the API has changed a litt=
le
> bit.

oops ...

> Which driver is it ?

the jr3_pci. It's a pci card, with a dsp to read the signal from a force=20
sensor.
http://www.comedi.org/cgi-bin/viewcvs.cgi/comedi/comedi/drivers/jr3_pci.c?r=
ev=3D1.5&view=3Dlog

> You may have noticed that I am still developing Comedi4RTDM. I have decid=
ed
> to start from scratch in order to make the most of the RTDM advantages. T=
he
> drawback is, for me, is the time needed to perform such a task (according
> to my private schedule).

It's a lot of work ..... but there's one think that I don't understand. Are=
=20
you modifying the comedi sources? Because is yes, the idea is to have not a=
=20
fork of comedi, than the efforts in the comedi team then will be used by th=
e=20
xenomai team.

> Because of many issues, it's been while since I committed on the Comedi
> branch (too many bugs/instabilities, lack of time, etc.). I will send many
> fixes / changes / adds (notably a minimal version of a NI driver) the next
> week.
>
> I hope that will help you.

thank for the mail and the clarification.

> By the way, if you (or anyone else) are interested in working in this
> mini-project, assessing it or just giving your opinion on the subject,
> please let me know.

I have no idea about the comedi drivers structure, neither the xenomai. I c=
an=20
be a tester, sure. I have just compiled, making a debian package, installed=
=20
and sent the test. If I can have this driver, I can use xenomai if not, I=20
have to return to rtai .... and I think that it's very interesting in my ca=
se=20
use xenomai and not rtai.

Regards,

Leo

=2D-=20
=2D-
Linux User 152692
PGP: 0xF944807E
Catalonia

--nextPart2165065.0CROJaDZMp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG825taC7AnPlEgH4RAiDnAJ9G3qsEogObGeYvHVk+AEdf1hPz/QCdEWw+
6H+v7+8256V8LiR5mClC15E=
=U6X3
-----END PGP SIGNATURE-----

--nextPart2165065.0CROJaDZMp--


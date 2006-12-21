Message-ID: <8403506.1166715370788.JavaMail.ngmail@domain.hid>
Date: Thu, 21 Dec 2006 16:36:10 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <b647ffbd0612210717u4b8f0505m65d01bc2824a144a@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <b647ffbd0612210717u4b8f0505m65d01bc2824a144a@domain.hid>
	<b647ffbd0612210509r7494454fqc820f83a4b1f8719@domain.hid>
	<15069404.1166690889417.JavaMail.ngmail@domain.hid>
	<458A4DE0.5030005@domain.hid>
	<2890274.1166696466862.JavaMail.ngmail@domain.hid>
	<16382545.1166699974895.JavaMail.ngmail@domain.hid>
	<1166700491.4936.5.camel@domain.hid>
	<25528819.1166701882755.JavaMail.ngmail@domain.hid>
	<13574091.1166708188484.JavaMail.ngmail@domain.hid>
	<1166710393.4960.13.camel@domain.hid>
	<12420573.1166713240349.JavaMail.ngmail@domain.hid>
Subject: [Xenomai-help] Re: Re: A fairly small rtnet/Xenomai...
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: dmitry.adamushko@domain.hid, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

Hi Dmitry,

when I use fork() instead of vfork() I have the freeze again.=20
I.e. using vfork() it works fine, using fork() freezes the system.

Regards

Mathias
> >
> > > - does the bug still occurs after the call to the system() routine ha=
s
> > > been replaced by the following frag?
> > >
> > >     if (vfork() =3D=3D 0)
> > >             execlp("/bin/ls", "ls", "-l", NULL);
> > >     else
> > >             wait(NULL);
> > >
> > I have replaced the system() call by your code fragement. And yes, this
> works!
> > No freeze!
>=20
> Ok, could you let me know what happens if you use fork() instead of
> vfork()?
>=20
> system() is the same thing : fork -> exec + but it also deals with signal=
s.
>=20


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2


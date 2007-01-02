Message-ID: <23680523.1167726237795.JavaMail.ngmail@domain.hid>
Date: Tue, 2 Jan 2007 09:23:57 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: Re: [Xenomai-help] Re: A fairly small rtnet/Xenomai...
In-Reply-To: <1167216287.31795.18.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <1167216287.31795.18.camel@domain.hid>
	<1166786437.4960.180.camel@domain.hid>
	<458BB057.9090009@domain.hid> <458ACFDA.8070300@domain.hid>
	<25528819.1166701882755.JavaMail.ngmail@domain.hid>
	<13574091.1166708188484.JavaMail.ngmail@domain.hid>
	<1166710393.4960.13.camel@domain.hid>
	<12420573.1166713240349.JavaMail.ngmail@domain.hid>
	<b647ffbd0612210717u4b8f0505m65d01bc2824a144a@domain.hid>
	<8403506.1166715370788.JavaMail.ngmail@domain.hid>
	<b647ffbd0612210743m2b208cb2w6e9054336fd68028@domain.hid>
	<9212697.1166778373331.JavaMail.ngmail@domain.hid>
	<458BA432.2000205@domain.hid>
	<b647ffbd0612220140m504db8e4x52ca45477e425d44@domain.hid>
	<9386881.1166783234553.JavaMail.ngmail@domain.hid>
	<28348634.1166787644219.JavaMail.ngmail@domain.hid>
	<45923BEE.6020302@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org, gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

Happy new year to all!

Back in the office, I tried out the patches from Chilles and Philippe.
And yes, it is working now! No crash!
Using these patches, I can now call a system() call out of a rea ltime task=
 that is followed=20
by a rt_task_sleep() and a printf() without crash on a 2.6.19 kernel.

Thanks for the support!

Best regards

Mathias
> > here comes a workaround for the COW issue on Linux 2.6.19. The patch
> > relies on a new VM_NOCOW flag which should be set for real-time
> > application if you use Xenomai trunk.
> >=20
> > It would be nice if you could test it.
> >=20
>=20
> You will additionally need to apply this patch to the Xenomai tree in
> order to activate the COW-disable feature:


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2


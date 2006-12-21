Message-ID: <13574091.1166708188484.JavaMail.ngmail@domain.hid>
Date: Thu, 21 Dec 2006 14:36:28 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <b647ffbd0612210509r7494454fqc820f83a4b1f8719@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <b647ffbd0612210509r7494454fqc820f83a4b1f8719@domain.hid>
	<b647ffbd0612210245p12227990j2584147720e95adc@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>
	<13529671.1166621136153.JavaMail.ngmail@domain.hid>
	<15069404.1166690889417.JavaMail.ngmail@domain.hid>
	<458A4DE0.5030005@domain.hid>
	<2890274.1166696466862.JavaMail.ngmail@domain.hid>
	<16382545.1166699974895.JavaMail.ngmail@domain.hid>
	<1166700491.4936.5.camel@domain.hid>
	<25528819.1166701882755.JavaMail.ngmail@domain.hid>
Subject: [Xenomai-help] Re: Re: Re: Re: A fairly small rtnet/Xenomai
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
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

Hi all,

some more interesing measurements:
1) Even when I remove the printf() completely, the system freezes.
My realtimetask is then
static void realtimetask(void *arg)
{
    system("ls -l");
    rt_task_sleep(1000000000ULL);

}

2) When I replace the printf() by a gepid() the behaviour is the same.

3) Jan, your application using the rt_task_shadow behaves the very same (it=
 freezes)!

4) A getpid() directly after system does not help - however, a printf at th=
is position helps to
prevent the freeze.

But now, I found one very interesting thing:
When I rename my /lib/tls to /lib/tls.disabled, it works!!!!
It seems to be (once more) a ugly thread local storage stuff.
The ldd dependency of xeno_crash show libc and libpthread that are take fro=
m=20
/lib/tls/i686/cmov directory.
Perhaps that could give a hint!

Regards

Mathias

> Hello Philippe,
> >
> > > The important issue to check is the above one. Please try calling
> > > rt_task_delete(NULL), and in a second test, rt_task_suspend(NULL),
> > > instead of letting the thread routine return. TIA,
> > O.K, here are the results:
> > I have placed rt_task_delete() at all possible positions in
> realtimetask().
> > The system freezes when I place rt_task_delete() after the printf()
> statement.
> > At all other positions (after system(), after rt_task_sleep()) the syst=
em
> does not freeze.
> > I get the very same results when I use rt_task_suspend() instead of
> rt_task_delete().
> >
> > It means, that the printf() call causes the freeze.
>=20
> just to be sure.
>=20
> Could you try with other secondary domain calls (instead of printf() )
> : write() (open/close as I suggested before) or even getpid() ?
>=20
> (1) instead of the last code line (printf() after rt_task_sleep() ) ;
>=20
> (2) put it after system(). Does it still prevent a PC from hanging?
>=20
>=20
> --=20
> Best regards,
> Dmitry Adamushko
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


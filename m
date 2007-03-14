Message-ID: <21950566.1173862047952.JavaMail.ngmail@domain.hid>
Date: Wed, 14 Mar 2007 09:47:27 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: Re: [Xenomai-help] Howto catch SEGV signals in Xenomai
In-Reply-To: <22180008.1173860253238.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <22180008.1173860253238.JavaMail.ngmail@domain.hid>
	<1173825460.16997.107.camel@domain.hid>
	<11906791.1173797505269.JavaMail.ngmail@domain.hid>
	<45F6C278.4040709@domain.hid> <1173801179.16997.56.camel@domain.hid>
	<17910.63947.624116.867944@domain.hid>
	<1173825266.16997.105.camel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: mathias_koehrer@domain.hid, rpm@xenomai.org, gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

Hi all,

one additional thing I found out:
I used the Xenomai SVN version not on a 2.6.20.2 but on the 2.6.19.2 kernel=
.
And here I had the freeze again.=20
As I have written in my previous mail, it worked fine with 2.6.20.2
It seems as if kernel 2.6.19.2 is causing the trouble...
No idea why...
For me it is fine to switch over to 2.6.20, however I'd like to use a "stab=
le" version
of Xenomai for it.
Is there a schedule for the next "stable" xenomai version that supports 2.6=
.20?

Thanks for all support!

Regards

Mathias
> thanks for all the feedback on that issue.
> Since yesterday I did a couple of tests on kernel 2.6.19.2
> 1. I used the adeos patch provided with xenomai-2.3.0=20
> SMP mode =3D> freeze with my program. I have enclosed the kernel config f=
or
> this one
> UP mode =3D> freeze with my program
>=20
> 2. I added the patch from Philippe (the second one):
>=20
> --- ksrc/nucleus/pod.c=09=09 (revision 2293)
> +++ ksrc/nucleus/pod.c=09=09 (working copy)
> @@ -1420,6 +1420,11 @@
>  =09=09 =09=09    the KICKED bit set, so that xnshadow_relax() is never
>  =09=09 =09=09    prevented from blocking the current thread. */
>  =09=09 =09=09 if (xnthread_test_info(thread, XNKICKED)) {
> +=09=09 =09=09 =09=09 XENO_ASSERT(NUCLEUS, (mask & XNRELAX) =3D=3D 0,
> +=09=09 =09=09 =09=09 =09=09     xnpod_fatal("Relaxing a kicked thread"
> +=09=09 =09=09 =09=09 =09=09 =09=09 =09=09 "(thread=3D%s, mask=3D%lx)?!",
> +=09=09 =09=09 =09=09 =09=09 =09=09 =09=09 thread->name, mask);
> +=09=09 =09=09 =09=09 =09=09 );
>  =09=09 =09=09 =09=09 xnthread_clear_info(thread, XNRMID | XNTIMEO);
>  =09=09 =09=09 =09=09 xnthread_set_info(thread, XNBREAK);
>  =09=09 =09=09 =09=09 goto unlock_and_exit;
>=20
> I used this patch on the UP kernel 2.6.19.2. Same adeos version as before=
.
> The result  was the same =3D> PC freeze
>=20
> 3. I tried kernel 2.6.20.2 and the same (SMP) configuration as with
> 2.6.19.2
> I used the Xenomai subversion #2292 and the adeos patch that is in
> subversion
> (adeos-ipipe-2.6.20-i386-1.7-02.patch).
> And with that combination it is working! I get the expected "Segmentation
> fault" message.
> I don't know why, but it seems to be working!
>=20
> I will try to use the same Xenomai svn version on the 2.6.19.2 to see if
> this is a 2.6.19 issue...
>=20
> Regards
>=20
> Mathias
>=20
>=20
>=20
>=20
> --=20
> Mathias Koehrer
> mathias_koehrer@domain.hid
>=20
>=20
> Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
> ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCns=
tig
> und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer=
,
> nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
> http://www.arcor.de/rd/emf-dsl-2

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2


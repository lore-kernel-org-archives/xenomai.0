Message-ID: <458AC8AF.6080306@domain.hid>
Date: Thu, 21 Dec 2006 18:47:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
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
	<13574091.1166708188484.JavaMail.ngmail@domain.hid>
	<458AC0A3.70700@domain.hid>
In-Reply-To: <458AC0A3.70700@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig47E45E6F70BD19AF99C9A633"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: A fairly small rtnet/Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig47E45E6F70BD19AF99C9A633
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> M. Koehrer wrote:
>> Hi all,
>>
>> some more interesing measurements:
>> 1) Even when I remove the printf() completely, the system freezes.
>> My realtimetask is then
>> static void realtimetask(void *arg)
>> {
>>     system("ls -l");
>>     rt_task_sleep(1000000000ULL);
>>
>> }
>>
>> 2) When I replace the printf() by a gepid() the behaviour is the same.=

>=20
> Hah, it finally oopses! Hurray!! Now the funny part begins...
>=20

It must be a tight race window. My oops disappears once logging goes to
serial console, so I only caught the following from the stalled console:

BUG: sleeping function called from invalid context at
include/asm/semaphore.h
in_atomic():0, irqs_disabled():1
 [...] lock_kernel+0x28
       default_llseek+0x15
       sys_llseek+0x4e
       sysenter_past_esp+0x65

This all happens shortly after the test case terminated. I'm able scroll
for a short while up in the log, but then the box goes South. With the
serial console attached I only get that trap-#14 reports by Xenomai that
the test program got switched to secondary mode.

I'm not able to continue my test on this particular system for the rest
of the year. I will try to reproduce it again elsewhere (the SPINLOCK
debugging switches seem to reveal something - sometime), but there is no
guarantee that I can do anything about it.

Jan


--------------enig47E45E6F70BD19AF99C9A633
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFisivniDOoMHTA+kRAlefAJ9zlpvM4OcR6o6Xp6WSrqcmvI9tBQCfc96T
PzSj3Cy6stlVBw940OhawoQ=
=wpTS
-----END PGP SIGNATURE-----

--------------enig47E45E6F70BD19AF99C9A633--


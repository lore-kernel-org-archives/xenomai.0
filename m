Message-ID: <46FF78DF.7090104@domain.hid>
Date: Sun, 30 Sep 2007 12:22:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46F9167F.20008@domain.hid> <1190756271.26427.0.camel@domain.hid>
	<46FA26ED.4070505@domain.hid>
In-Reply-To: <46FA26ED.4070505@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig206688466CB23EFD37E4234F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Non-APIC setup broken for 2.4-SVN?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig206688466CB23EFD37E4234F
Content-Type: multipart/mixed;
 boundary="------------050607070704070508030909"

This is a multi-part message in MIME format.
--------------050607070704070508030909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> On Tue, 2007-09-25 at 16:09 +0200, Jan Kiszka wrote:
>>> Hi,
>>>
>>> to make it short has anyone or could anyone try latest SVN over kerne=
l=20
>>> 2.6.20 (i-pipe for 2.6.22 is instable) _without_ LAPIC? It works for =
me,=20
>>> but exposes milliseconds of latencies. Same setup with LAPIC enabled =
is=20
>>> fine and obviously stable. Before digging into this (time is short=20
>>> anyway), I would like to exclude problems of my notebook hardware.
>>>
>> Not confirmed here. Everything looks ok.
>=20
> Yes, I found a second box working fine with a comparable (though not=20
> identical) config. I suspect some hw issue of my notebook now, but I=20
> will try to look into this a bit deeper once time permits.

It was a correlation between trying to use the PIT while Linux fiddled
with the HPET (when HPET is in use, the PIT cannot be programmed). See
my attached warning patch which may prevent others from pulling hairs.

> More important is to understand and fix the consistent 2.6.22 issues I =

> see. Only works in qemu for me, all real i386 boxes lock up sooner or=20
> later. :-/

I'm on this. Multiple bugs are involved, at least one of them is visible
already with vanilla on my work notebook. Another one is related to
Xenomai not dealing with the lapic device being in
CLOCK_EVT_MODE_SHUTDOWN whenever the NMI watchdog is in use. And a third
one only gives me "Detected illicit call from domain Xenomai" before the
box reboots. :(

Jan

--------------050607070704070508030909
Content-Type: text/x-patch;
 name="hpet-conflict-detection.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="hpet-conflict-detection.patch"

Index: xenomai/scripts/Kconfig.frag
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai/scripts/Kconfig.frag	(Revision 3019)
+++ xenomai/scripts/Kconfig.frag	(Arbeitskopie)
@@ -11,8 +11,13 @@ comment "NOTE: Xenomai conflicts with PC
 comment "(menu Device Drivers/Input device support/Miscellaneous devices=
)"
 	depends on !X86_TSC && X86 && INPUT_PCSPKR
=20
+comment "NOTE: Xenomai conflicts with HPET Timer support."
+	depends on !X86_LOCAL_APIC && X86 && HPET_TIMER
+comment "(menu Processor type and features/HPET Timer Support)"
+	depends on !X86_LOCAL_APIC && X86 && HPET_TIMER
+
 config XENOMAI
-	depends on (X86_TSC || !X86 || !INPUT_PCSPKR)
+	depends on ((X86_TSC || !X86 || !INPUT_PCSPKR) && (!HPET_TIMER || !X86 =
|| X86_LOCAL_APIC))
 	bool "Xenomai"
 	default y
         select IPIPE

--------------050607070704070508030909--

--------------enig206688466CB23EFD37E4234F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFG/3jjniDOoMHTA+kRAhFfAJ4tAzWY4RB9UtrqwYGi+/Ukqaj5vwCfVLM4
iprohucdEs8Pj+uitkwMEgI=
=HEYT
-----END PGP SIGNATURE-----

--------------enig206688466CB23EFD37E4234F--


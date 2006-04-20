Message-ID: <44477688.3070505@domain.hid>
Date: Thu, 20 Apr 2006 13:54:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] strangeness at kernel configuration
References: <20060418144146.GA4482@domain.hid>	<20060418153508.GB4482@domain.hid>	<44450DDF.9080205@domain.hid>
	<20060419152914.GB13542@domain.hid>
In-Reply-To: <20060419152914.GB13542@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0CE8557D6B6073D786D50786"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Luotao Fu <l.fu@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0CE8557D6B6073D786D50786
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Luotao Fu wrote:
> Hi Philipe,
>=20
> On Tue, Apr 18, 2006 at 06:03:43PM +0200, Philippe Gerum wrote:
>> Luotao Fu wrote:
>> Your configuration works perfectly here over #944. You might want to=20
>> restart building from a freshly patched kernel anew, there seems to be=
=20
>> something badly broken in your current tree, perhaps some mismatching =

>> modules that have not been recompiled properly?
>>
>> --=20
>>
>> Philippe.
> Thanx for testing. I, however could locate the problem at the APIC
> Timer function in the kernel: With=20
> ......
> CONFIG_X86_UP_APIC=3Dy
> CONFIG_X86_UP_IOAPIC=3Dy
> CONFIG_X86_LOCAL_APIC=3Dy
> CONFIG_X86_IO_APIC=3Dy
> ......
> I could reproduce the problem (loading rtdm driver causes oops, cannot =
run
> any application using native or posix skin) reliably on my machine.=20
> (Celeron 733MHz. 256MB RAM...a normal PC) Shutting off the APIC stuffs,=

> however, solves the problem........ Have I overlooked
> anything or does Xenomai have problems with the apic controller on
> celeron (since it seems to work for you)?
>=20

Do you pass "lapic" via the kernel command line? If lapic is missing,
this would not work anyway. This illegal combination used to cause
crashes, but the detection should have been fixed some weeks ago.

I just tried to reproduce your scenario - and I was "successful": All
APIC stuff on, up to RTDM all xeno stuff built in, "forgotten" lapic in
bootparam, and then modprobe xeno_timerbench, oops.

The oops is a minor issue which I will try to address more gracefully
later. The major issue is that missing lapic. You should have this in
your kernel log:

=2E..
Xenomai: Local APIC absent or disabled!
         Disable APIC support or pass "lapic=3D1" as bootparam.
Xenomai: system init failed, code -19.
Xenomai: starting POSIX services.
Xenomai: POSIX skin init failed, code -19.
Xenomai: RTDM skin init failed, code -19.
=2E..

So, all fine from the xenomai POV, except for that bug in
rtdm_dev_register().

Jan


--------------enig0CE8557D6B6073D786D50786
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFER3aIniDOoMHTA+kRAj9JAJ4t+3/4ZHMEdce+a/NmZLmhFjTbtACfQMIn
8N4ojZMVDegIWxWSutQdciU=
=1OQT
-----END PGP SIGNATURE-----

--------------enig0CE8557D6B6073D786D50786--


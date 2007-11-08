Message-ID: <47336D6D.2020203@domain.hid>
Date: Thu, 08 Nov 2007 21:11:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4732C546.90602@domain.hid> <4733535E.4070700@domain.hid>
	<47336447.8090203@domain.hid>
In-Reply-To: <47336447.8090203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC32B78D2671260E560CB6EFC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Testing LTTng: first insights
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC32B78D2671260E560CB6EFC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> ...
>>> Xenomai is loaded at this time but not yet used. Linux runs in tickle=
ss
>>> highres mode and obviously had programmed the host timer to fire here=
=2E
>>> But instead of one timer IRQ (233) + its handling, we see an addition=
al
>>> early shot (about 3 =B5s too early here - the longer the timer is
>>> programmed in advance, the larger the error gets) before the xntimer
>>> finally expires. But at the same time, /proc/xenomai/latency reports
>>> 1000 (1 =B5s). So there must be more discrepancy between TSC and APIC=

>>> timebases, no? Well, nothing critical, but at least suboptimal, maybe=

>>> pointing at some hidden minor bug. Once time permits, I will check th=
e
>>> APIC frequency and the delay calculation on my box and compare it to
>>> what Linux uses.
>> Looks like Xenomai is using an inaccurate APIC frequency (probably sin=
ce
>> ages): 10.383 MHz on one of my boxes vs. 10.39591 MHz according to
>> Linux' calibration ( (1,000,000,000 ns * clock_event_device.mult) >>
>> clock_event_device.shift ), which is based on the PM-timer. As the rea=
l
>> frequency is higher, the APIC fires earlier than we want to. Consider,=

>> e.g., the 4 ms host tick period =3D> 5 =B5s too early! This correlates=
 with
>> my LTTng traces.
>>
>=20
> Oops. Once again, this proves that having a permanent trace facility in=

> place is key to uncover bugs.
>=20
>> I will try to fix this issue by extending the ipipe_request_tickdev
>> interface so that it returns also the frequency of the requested tick
>> device - as long as Xenomai 2.4 is not released, such an API breakage
>> should not cause any hassle IMHO.
>>
>=20
> You may want to have a look at ipipe_get_sysinfo() first, and track the=

> use of the tmfreq field in Xenomai. This may be what you want to fix,

Nope tmfreq is not involved. The problem is:

	rthal_timerfreq_arg =3D apic_read(APIC_TMICT) * HZ;

> IIUC. This would keep the older patches usable with the next Xenomai
> version, which is very desirable.

We could extend the information ipipe_get_sysinfo returns by the timer
frequency. But to play cleanly, we would have to critical_enter first,
look up the currently used clock_event_device, maybe even validate that
it was hijacked, and then return its frequency. The problem with this
API is, that it is by nature unsynchronised with ipipe_request_tickdev,
thus would not always be able to return a valid frequency.

Actually, we would only exclude a few patches when going the
ipipe_request_tickdev way: those few that were clockevent-aware up to
today. For all others (namely 2.6.20 on i386 and up to 2.6.23 on
x86_64), we would simply fall back to our current inaccurate approach. I
think this is more acceptable than an ipipe_get_sysinfo extension.

Hmm, maybe we could install a temporary API for x86_64 so that users
don't have to wait for 2.6.24 to get an accurate APIC. This would be
removed again with the first unified x86-ipipe patch.

Jan


--------------enigC32B78D2671260E560CB6EFC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHM21uniDOoMHTA+kRAsIVAJ9xsMCtkdOY7Ft3WBXdJNbXAb9vnwCfUChG
RXTX9zluVlvce27u2BH66kc=
=nC95
-----END PGP SIGNATURE-----

--------------enigC32B78D2671260E560CB6EFC--


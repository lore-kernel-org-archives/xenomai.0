Message-ID: <4AFE91AC.6080904@domain.hid>
Date: Sat, 14 Nov 2009 12:17:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AFD01D3.1070604@domain.hid> <4AFD4C7F.1000106@domain.hid>
	<4AFD6013.9020608@domain.hid> <4AFE90A8.7090403@domain.hid>
In-Reply-To: <4AFE90A8.7090403@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB7EED5793F83BD4B888AF5C0"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] What has highest priority RTcap or
	TDMA-synchronization reception?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Benjamin Biegel <biegel@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB7EED5793F83BD4B888AF5C0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Benjamin Biegel wrote:
>> Thanks Jan
>>
>> We use this setup: Two computers are RTnet-slaves synchronized to prov=
ide them common time. These two computers also have a second NIC which ta=
p a target Ethernet network using RTcap. In this way we can measure Ether=
net travel times on the target network.
>>
>> This works well. The only problem is that we don't know exactly how to=
 handle if a TDMA sync arrives at the same time as RTcap captures a frame=
 on the target network.
>>
>> We ran a test where we only read the system time from kernel space usi=
ng rt_timer_read(). This reading and saving to a file takes approximately=
 1 us. However this time increases to approx 16 us when the reading is ma=
de when a synchronization TDMA packet is being handled.
>>
>> We would like to detect when this happens so we can discard the frame =
travel times that collide with the TDMA sync.
>>
>> I hope this makes sense
>=20
> Note that the synchronization accuracy via TDMA is not in the order of =
a
> few microseconds, rather a few 10 us. That's because no clever approach=

> to compensate jitters of the reception interrupt is applied. So your
> worrying about the jitter caused by the second NIC actually has to be
> extended by worries about jitter of other host interrupts. They might b=
e
> smaller as I-pipe will suppress non-RT IRQs far more quickly, but they
> are more and can line up and cause larger jitters as well.
>=20
> If you want to get rid of most of them: use a multicore box and isolate=

> the RTnet NIC IRQ on a dedicated core. All Linux IRQs except for the
> timer IRQ can then be avoided.

Well, there are actually more unavoidable Linux IRQs: You may still see
occasional rescheduling IRQs, and some other IPIs may be unavoidable
with current Linux as well. So no perfect world here, but at least some
sources of IRQ jitters can be avoided.

Jan


--------------enigB7EED5793F83BD4B888AF5C0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkr+kawACgkQitSsb3rl5xTgFwCg2XxjBPmhALXGapy9btTEMV2j
6CsAn3mfjaQC85vuSP2cHEf3hH1fO2Zi
=2TDK
-----END PGP SIGNATURE-----

--------------enigB7EED5793F83BD4B888AF5C0--


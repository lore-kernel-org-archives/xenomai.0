Message-ID: <462DE13C.7030305@domain.hid>
Date: Tue, 24 Apr 2007 12:51:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45F68258.5040603@domain.hid>
	<460AB8FF.5060904@domain.hid>	 <460B21C0.7090200@domain.hid>
	<460B7FDF.8030100@domain.hid>	 <460BECFD.2030003@domain.hid>
	<460C0C7D.7000001@domain.hid>	
	<bc4264770704230809i9f9c554k14d67007b828971d@domain.hid>	
	<17964.64208.463335.611234@domain.hid>	
	<bc4264770704240144n74d4cfa0lafcbc84b76e06822@domain.hid>	
	<462DC874.20303@domain.hid>
	<bc4264770704240331v31f81487l32e27634e77804b4@domain.hid>
In-Reply-To: <bc4264770704240331v31f81487l32e27634e77804b4@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0A49CA7CF45294A90D687002"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Latencies due to RT-Socket-CAN register accesses
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0A49CA7CF45294A90D687002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

roland Tollenaar wrote:
> Hi
>=20
>> Two conclusions:
>>
>>  - You are running your kernel as i586 without TSC support - suboptima=
l,
>>    costs you a few micros.
> I am aware of this. For the current machine I will stick to this.
>=20

Then don't complain. :)

>=20
>>  - The reported latency perfectly matches the trace, nothing
>>    pathological there. The trace looks like this: Timer fired,
>>    measurement task woken up, two interrupts squeeze themselves betwee=
n
>>    wakeup and time stamp acquisition. All sane.
> Is it not a bit strange that a machine as fast as this one is supposed
> to be give worse latencies than much slower machines. Are the 2
> interrupts causing the latency?

Those two increase the latency of code in timed tasks, for sure. The
question is if your measurement on the slower machine also included this
scenario (timer event + 2 IRQs in a row). This definitely doesn't happen
often, and maybe timing on the slower box makes it less likely. Or there
is one potential IRQ source more on your fast box (e.g. due to IRQ
sharing on the slower one).

You see, RT system design on the edge (ie. when hunting a few 10 us) is
tricky and not easily portable from box X to box Y.

Jan


--------------enig0A49CA7CF45294A90D687002
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGLeE8niDOoMHTA+kRAmjVAJ9m0DRiVG1UsXl86TrTijUkgUa5jACbBy1w
XVy63TwA3oTA5HxKNyRCGC4=
=+mct
-----END PGP SIGNATURE-----

--------------enig0A49CA7CF45294A90D687002--


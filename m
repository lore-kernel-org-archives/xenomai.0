Message-ID: <46C2B842.1080501@domain.hid>
Date: Wed, 15 Aug 2007 10:24:34 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46C02829.9020009@domain.hid>
	<46C04384.4030805@domain.hid>	<46C05180.5090302@domain.hid>
	<46C05690.2010108@domain.hid>	<46C063E0.1010809@domain.hid>
	<46C07005.8000504@domain.hid>	<46C1B498.8060600@domain.hid>	<Pine.LNX.4.64.0708141629570.18303@domain.hid>
	<46C1EE69.3020301@domain.hid> <46C1FFDA.4070709@domain.hid>
	<46C298FD.8070300@domain.hid>
In-Reply-To: <46C298FD.8070300@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7C700EF6664DE3743541239B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [Ethercatmaster-users] EML conflict with RTCAN?
 low_level_input framebuilding failed.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: EML users <ethercatmaster-users@domain.hid>, rtnet-users <rtnet-users@domain.hid>, Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7C700EF6664DE3743541239B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Roland Tollenaar wrote:
> Hi,
>=20
>> Check the /proc output again, there should be also RTnet's stack manag=
er
>> at prio 98. Maybe that is too low for your scenario and causes prio
>> inversions (note: every incoming Ethernet frame goes through its hands=
).
>> Try lowering the prio of your rt_task1 beneath 98.
>=20
> Thanks. This seems to have made a big improvement. I have so far not
> once detected the scope to loose lock on the sawtooth when the
> index_check in eml is still disabled. Before lowering the priority of m=
y
> task (to 97) I could still invoke what I suspect to be a latency spike.=

>=20
> If the index_check is enabled I now mostly have less problems too. Ther=
e
> is a chance in start-up of the application that there is a latency spik=
e
> and then the warning kicks in. Due to the fact that the shift is
> permanent, the error is persistent and this then destabilizes the
> sawtooth a bit.

Hmm, this doesn't convince me yet. Such skews during startup may as well
be triggered by unusual load during runtime (non-RT activity or new RT
components). Did you put your system under adequate non-RT load as well
while measuring the outputs?

>=20
> I will keep the check disabled but for the EML chaps I do think this is=

> a point of interest. I would be very interested how this index shift
> occurs and why it is persistent after occurring once.
>=20
> Sorry for the pragmatic qualifications here but in the end its the
> stability of the outputs that will determine the behaviour of the
> machine so its not a bad way to assess the software. :)

A problem isn't solved until it is also understood.

>=20
>> If the problem persists (or your _really_ want to understand what
>> happens), you could try to put an xntrace_user_freeze(0, 1) before the=

>> line which emits that EML warning, turn on the I-pipe tracer, set a
>> large back_trace_points value (a few thousand), enable verbose mode, a=
nd
>> grab what /proc/ipipe/trace/frozen reports after the hick-up. See [1]
>> for more howtos.
>=20
> Done this before so it should not be a problem. Don't think it is

In that case, I would even more suggest to collect the data, maybe now
about the fragile startup case.

> necessary quite yet as the behaviour at the moment looks good.

Jan


--------------enig7C700EF6664DE3743541239B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGwrhHniDOoMHTA+kRAqFhAKCAM0ODKSNW403HHUveyogpXK/b6gCdHL2V
br9XrimVesoro/DX49oIee0=
=ea7B
-----END PGP SIGNATURE-----

--------------enig7C700EF6664DE3743541239B--


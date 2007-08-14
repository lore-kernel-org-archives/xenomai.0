Message-ID: <46C1FFDA.4070709@domain.hid>
Date: Tue, 14 Aug 2007 21:17:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46C02829.9020009@domain.hid>
	<46C04384.4030805@domain.hid>	<46C05180.5090302@domain.hid>
	<46C05690.2010108@domain.hid>	<46C063E0.1010809@domain.hid>
	<46C07005.8000504@domain.hid>	<46C1B498.8060600@domain.hid>	<Pine.LNX.4.64.0708141629570.18303@domain.hid>
	<46C1EE69.3020301@domain.hid>
In-Reply-To: <46C1EE69.3020301@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0B2FB6BD8484B8F46690C28F"
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
--------------enig0B2FB6BD8484B8F46690C28F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Roland Tollenaar wrote:
> Hi,
>=20
>> How many threads do you have sending process data, and what are there
>> priorities? (/proc/xenomai/sched IIRC)
> I have 3 rt tasks running. Only one sends and receives process data. Th=
e=20
> priorities are:
> rt_task1 99

Check the /proc output again, there should be also RTnet's stack manager
at prio 98. Maybe that is too low for your scenario and causes prio
inversions (note: every incoming Ethernet frame goes through its hands).
Try lowering the prio of your rt_task1 beneath 98.

> rt_task2 75
> rt_task3 1
>=20
> Period times are
> 1ms
> 3ms
> indefinite(holds a blocking rt_can recv call to catch any incoming CAN =

> messages)
>=20
>=20
>>> EC_Telegram::index_check() : index not the same,
>>> low_level_input() :  framebuilding failed.
>>>
>>> Or something pretty closely to that effect.
>>>
>>> Despite EML warning that the frame could not be built, the inputs (wh=
ich
>>> rely on the framebuilding being succesful pretty stringently) seem to=

>>> function perfectly. It seems as though EML is emitting a false warnin=
g.
>> What do you mean with "inputs functioning perfectly"?
>=20
> The digital inputs are packed into the frame as are the digital outputs=
=20
> and analog output process data. The outputs function as they should but=
=20
> the warning complains mainly about the retrieving part of the ethercat =

> cycle. Hence my comment that the digital inputs also function as they=20
> should that is to say the data arrives correctly and uncorrupted. AFAI =

> understand from ETG the index is not changed by the ESC's so I would=20
> expect the check always return true. But even if it does not what does =

> that mean? Can it mean that EML is losing some frames that have been=20
> transmitted? I.e. the index is incremented with every transmit and the =

> message with the same index is expected on the next read but instead it=
=20
> is only getting one later? If so, what could cause this?

If the problem persists (or your _really_ want to understand what
happens), you could try to put an xntrace_user_freeze(0, 1) before the
line which emits that EML warning, turn on the I-pipe tracer, set a
large back_trace_points value (a few thousand), enable verbose mode, and
grab what /proc/ipipe/trace/frozen reports after the hick-up. See [1]
for more howtos.

If you post the dump, we may be able to analyse what the system is doing
before the problem report, if there are long delays due to high-prio
tasks e.g.

Jan

[1] http://www.xenomai.org/index.php/I-pipe:Tracer


--------------enig0B2FB6BD8484B8F46690C28F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGwf/aniDOoMHTA+kRApWFAJ9t0oKaRjtTOinYEfkV8fvetNW0lgCfbVsh
WW2xUMGRXmOvewRKr5x1nzY=
=Svuw
-----END PGP SIGNATURE-----

--------------enig0B2FB6BD8484B8F46690C28F--


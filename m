Message-ID: <46825054.7030800@domain.hid>
Date: Wed, 27 Jun 2007 13:56:04 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>	<4668440F.7020706@domain.hid>	<20070608124927.1b789a9e@domain.hid>	<46693B6B.1010201@domain.hid>	<20070625175107.438849fa@domain.hid>	<467FF391.8020401@domain.hid>
	<20070627105726.7db7a459@domain.hid>
In-Reply-To: <20070627105726.7db7a459@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD661A79348AE1E55CB06B010"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] measuring tasks execution time
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniel Simon <Daniel.Simon@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD661A79348AE1E55CB06B010
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Daniel Simon wrote:
> On Mon, 25 Jun 2007 18:55:45 +0200
> Jan Kiszka <jan.kiszka@domain.hid> wrote:
>=20
>=20
>=20
>> My idea was to keep a persistent version the existing xnstat_runtime_t=

>> instance in xnthread (and later on also xnintr). That one shall not be=

>> reset on readout via /proc.
> Is it necessary to keep also the reset one?

Yep, at least virtually (as in my proposal): We are dumping CPU share
percentages in /proc, and those need to be calculated over the same
measurement period. Thus we restart the measurement each time the user
reads the stats.

>=20
>> Instead, you establish quite some new calculations that break
>> the existing API (the switch date is given via "start" - which was
>> misnamed so far, I just changed it to "date")=20
>=20
> ok, better fit the behaviour.
> I should better work from the last svn version?

SVN trunk would be best, indeed.

>=20
>> and increase the runtime
>> overhead in the hotpath. Why? All the information you should need is
>> already there, it just has to be saved from being vaporised when the
>> user dumps /proc/xenomai/stat.
>>
>>>  	(sched)->last_account_switch =3D start; \
>>>  } while (0)
>>>   =20
>> Let's try it like this: Change Xenomai so that it leaves the existing
>> xnthread_t::stat.account untouched when it reads /proc. Rather add
>> something like "xnstat_runtime_t last;" to xnthread_t::stat. On readou=
t
>> for /proc output,=20
> Where is this done? I've found one place in module::stat_seq_open where=
 total is
> reset to 0, is it the only one?=20

That's one spot, the other is xnpod_migrate_thread()
(xnstat_runtime_reset_stats()) IIRC.

> In fact I don't have a clear picture of the stat
> process and what it is assumed to do (and thus did not want to break so=
mething!)

Stat generation happens based on services that are provided by
nucleus/stat.h, stat dumping is concentrated in modules.c, namely
stat_seq_open. Using the cross reference [1] can help if you want to
verify this on your own.

>> do the stats now like "account-last" and then move
>> account into last. For your task exectime, you can then read
>> xnthread_t::stat.account directly, because it will always reflect the
>> full task history. Would't this work better?
>=20
>> Thanks for working on this!
> I'll try to find enough time by the end of this week to improve this...=

>=20
> 	Daniel
>=20

Looking forward.

Jan

[1] http://www.rts.uni-hannover.de/xenomai/lxr/source/?v=3DSVN-trunk


--------------enigD661A79348AE1E55CB06B010
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGglBUniDOoMHTA+kRApdEAJwPCeZ3n1TCUuul0KM0850CQzC8jwCfVBMB
BW06DgqmiTlgsqxGjBd/p90=
=uMV+
-----END PGP SIGNATURE-----

--------------enigD661A79348AE1E55CB06B010--


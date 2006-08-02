Message-ID: <44D086CB.5020603@domain.hid>
Date: Wed, 02 Aug 2006 13:04:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>	
	<200607221152.34298.bidsonux@domain.hid> <44C25DB0.50601@domain.hid>	
	<200607282317.34990.bidsonux@domain.hid>
	<44CB6EB3.5070707@domain.hid>	 <1154282619.4970.25.camel@domain.hid>
	<44CD099F.9010507@domain.hid>	 <1154294584.4970.49.camel@domain.hid>	
	<17613.60380.820599.627459@domain.hid>	
	<1154355564.5015.12.camel@domain.hid>
	<1154442627.4963.21.camel@domain.hid>	 <44CF691C.30706@domain.hid>
	<1154508768.4983.46.camel@domain.hid>
In-Reply-To: <1154508768.4983.46.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig283D37CAFA6136CA45E0D5D6"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [RFC] tame the watchdog
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig283D37CAFA6136CA45E0D5D6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Tue, 2006-08-01 at 16:45 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>>> Still, reinitializing X while the latency test runs causes
>>>> the latter to hang, albeit LOC is still flowing properly and the box=

>>>> keeps going normally.
>>> This one was due to the nucleus watchdog which triggered right after =
the
>>> graphic mode was fully initialized, due to the huge amount of
>>> unpreemptible time spent doing this; this caused the sampling task to=
 be
>>> detected as a runaway thread. So the behaviour is ok, albeit a bit
>>> frightening at first.
>>>
>> That reminds of the unfortunate characteristics of the 2.6 oom-killer:=

>> unless you set your time-critical app's oom_adj to -17, you are never
>> really safe from being killed accidentally on low-mem scenarios.
>>
>> What about introducing some mechanism to protect audited tasks against=

>> the watchdog? A simple thread flag settable via existing APIs, ignored=

>> if there is no watchdog compiled in?
>=20
> There is a fundamental difference between the OOM killer and the Xenoma=
i
> watchdog: the latter is merely a debugging tool to prevent the box to
> hang, and you can disable it completely.
>=20
> The situations reported by the watchdog are pathological ones, which
> involve more than 4 seconds of continuous real-time activity while the
> Linux kernel is being totally starved from CPU, and in such a case, you=

> really want someone to pull the brake, regardless of the consequences o=
n
> the application (which looks like basically toast anyway). IOW, if such=

> weird situation eventually ends up being considered as "normal" under
> certain circumstances, the best approach is simply to disable the
> watchdog entirely.
>=20
> Limiting the runtime quantum allotted to threads through a dedicated
> scheduling policy would be a better way to deal with CPU overconsumptio=
n
> "intelligently", i.e. on a per-thread basis.=20

For sure, e.g. round-robin scheduling including the root thread, and
this also over aperiodic timer mode.

> OTOH, the current watchdog
> implementation is aiming at being terminally dumb for the sake of debug=

> efficiency.
>=20

Yes, it's simple and it's a debugging mechanism. Nevertheless, I think
it can be improved without too much effort or costs. I would love to
demonstrate this, but for now I'm afraid this has to remain a (now
filed) idea.

Jan


--------------enig283D37CAFA6136CA45E0D5D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE0IbLniDOoMHTA+kRAhSPAJ48H6xny7PJqZcEwqySYYrvB8/khwCfUJ6i
+azu8rtG5tRH0xHfQ75paUs=
=xQVz
-----END PGP SIGNATURE-----

--------------enig283D37CAFA6136CA45E0D5D6--


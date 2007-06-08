Message-ID: <46693B6B.1010201@domain.hid>
Date: Fri, 08 Jun 2007 13:20:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>	<4668440F.7020706@domain.hid>
	<20070608124927.1b789a9e@domain.hid>
In-Reply-To: <20070608124927.1b789a9e@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3DF5D19EC59682150915658E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-help] measuring tasks execution time
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
--------------enig3DF5D19EC59682150915658E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Daniel Simon wrote:
> On Thu, 07 Jun 2007 19:44:47 +0200
> Jan Kiszka <jan.kiszka@domain.hid> wrote:
>=20
> Hello, opening a new thead forking from the one opened yesterday by Arn=
aud
> Desvages

I moved the thread to xenomai-core, hope you don't mind.

>=20
>> Hmm, the patch looks like it consequently reimplements existing runtim=
e
>> statistics instead of reusing them as a foundation...
>>
> Yes, might be simpler now. This patch has been done in urgency upon
> xenomai 2.1 and was more or less sleeping since one year. It has been w=
eakly

This explains why your changes are right below the xnstat infrastructure
code...

> tested, only on Pentium 3 cpus.
>=20
>> Anyway, I think we could discuss some API extension of Xenomai (for
>> native, probably via  ). Likely we would keep this report
>> optional, ie. make it return -1 or so if CONFIG_XENO_OPT_STATS is off.=

>> Tracking stats is not as costly as other instrumentations, but it's al=
so
>> not free. If you are interested, let us know. It won't be a one-liner,=

>> but it doesn't look like it has to be as invasive as your approach.
>=20
> Our goal is computing the accumulated cost of some selected real-time t=
asks
> to get an image of the  cpu load.
>=20
> What we need is a record of  the accumulated execution time of the
> rt_tasks (not the response time, hence the instants when the task is
> preempted or suspended must not be counted).
> This record must be accessible at any time, either from the calling
> task or by another one. =20
>=20
> Our current patch only does that for tasks running in primary mode (and=

> moreover the measure seems not correctly updated for the calling
> task record). =20
>=20
> Thus we would be very happy to get an improved instrumentation api.
> I understand that  xnstat_runtime_update() handles the measure we need?=
=20

It was designed to collect precise runtime statistics to be displayed in
/proc/xenomai/stat. We would just have to keep a total counter for each
task as dumping /proc resets the statistics ATM.

> Making it available, e.g.  via a rt_task_inquire call, would be great! =


Well, the best (=3D=3Dmost comfortable :o) ) way from my POV would be if =
you
could try rebasing your work on your own first. Questions, even on minor
details, are always welcome, review on patches will be provided. Should
be no problem to get this into Xenomai 2.4.

The rough to-do list would be:

 o add some persistent runtimer counter to xnthread::stat and maintain
   it
 o introduce an xnpod service (inline function) to obtain it (let that
   thing return [0..LONGLONG_MAX] when stats are available, -1
   otherwise)
 o export the runtime via struct rt_task_info, maybe also the task start
   time

Jan


--------------enig3DF5D19EC59682150915658E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGaTtrniDOoMHTA+kRAtXSAJ4rrQypcoMc4zLrJVqVHEqJ6eF7AgCfXaKN
yI/BFlEYDLuj+mmu1urebks=
=E8Wq
-----END PGP SIGNATURE-----

--------------enig3DF5D19EC59682150915658E--


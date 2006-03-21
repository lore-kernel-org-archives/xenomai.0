Message-ID: <441F4494.5010803@domain.hid>
Date: Tue, 21 Mar 2006 01:11:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Synchronising TSC and periodic timer
References: <44172B67.2000609@domain.hid>
	<200603201142.27591.lbocseg@domain.hid>	<441EDD9B.20708@domain.hid>
	<200603201627.54738.lbocseg@domain.hid>
In-Reply-To: <200603201627.54738.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE4174A90E63F83A43FFAE62A"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE4174A90E63F83A43FFAE62A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Em Segunda 20 Mar=E7o 2006 13:51, Philippe Gerum escreveu:
>=20
>> ...
>> I think that you should try convincing Jan that rtdm_clock_tsc() might=

>> be a good idea to provide, instead of tweaking rtdm_clock_read() in a
>> way which changes its underlying logic. ;o)
>=20
> Yes, that is exactly what I want! :)
> I don't see any reason for changing rtdm_timer_read() neither. I think =
that=20
> the most common usage of high-precision timestamps is for relative time=
=20
> cases. It doesn't need to be in sync with Xenomai's timer... It is best=
 to=20
> keep things simple.
>=20
> What do you think Jan?

We discussed a lot about how to prevent the user shooting him/herself in
the knee with inter-tick timestamps, but I still think that
rtdm_clock_read_tsc() would even be worse in this regard.

xnarch_get_cpu_tsc() and derived skin services are not supposed to
deliver consistent results across multiple CPUs, are they? While the
user could avoid such scenarios by locking tasks on a specific CPU,
drivers cannot - at least so far. So, to safely introduce such a
low-level service for RTDM, I think we need

A) CPU affinity for RTDM-registered IRQs
B) CPU affinity for RTDM kernel tasks
C) Some well written docs, explaining how to safely use TSCs at driver
level and how to provide them to the user (the latter aspect makes me
worry most)

While A) and B) might be useful for other (though rare) scenarios as
well, C) will still require a very good understanding and interface
design from the driver writer, while I don't see comparable error
dimensions with the improved rtdm_clock_read(). Comparing apples
(rtdm_clock_read()) to oranges (rt_timer_read()), there will be some
error around a tick period. But comparing apple[0]
(rtdm_clock_read_tsc() on CPU#0) to apple[1] (rtdm_clock_read_tsc() on
CPU#1), the error could become *much* larger and the design and
documentation effort to avoid this will be significant.

Ok, as a simple resolution for this problem, I could imagine introducing
a TSC timestamping service to RTDM that always fall back to that level
of accuracy which is guaranteed to be consistent - either because we run
in aperiodic mode, or on uniprocessor, or thanks to some magic
synchronisation between all CPU clocks. This would have to be decided at
build time, in the first version likely by checking for (multiprocessor
|| aperiodic) to switch to xnpod_get_time().

Jan


--------------enigE4174A90E63F83A43FFAE62A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEH0SVniDOoMHTA+kRAqr2AJ9ybpbrRcBpKOnhFLz1si+thFaoNACfTJbD
15PVCirsWJan+4e+SR4fV4c=
=EHis
-----END PGP SIGNATURE-----

--------------enigE4174A90E63F83A43FFAE62A--


Message-ID: <48236CE2.5050907@domain.hid>
Date: Thu, 08 May 2008 23:13:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4823620F.3020904@domain.hid> <482368B8.9070008@domain.hid>
	<482369FE.6070508@domain.hid>
In-Reply-To: <482369FE.6070508@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCFAECDD8576095BDF90473CC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [BUG] ipipe_sync_stage deadlock
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCFAECDD8576095BDF90473CC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>> I love KVM - not only because I'm heavily hacking on it now, also
>>> because it is so easy to trigger various kinds of guest issues with
>>> it (SMP host + threaded virtual CPUs =3D> true SMP guest - and if you=

>>> want to watch fancy things happen, just load one host core).
>>>
>>> Here is one I found that way:
>>>
>>> void fastcall __ipipe_sync_stage(unsigned long syncmask)
>>> {
>>> [ ... ]
>>> 	while ((mask =3D (ipipe_this_cpudom_var(irqpend_himask) & syncmask))=
 !=3D 0) {
>>> 		level =3D __ipipe_ffnz(mask);
>>>
>>> 		while ((submask =3D ipipe_this_cpudom_var(irqpend_lomask)[level]) !=
=3D 0) {
>>> 			rank =3D __ipipe_ffnz(submask);
>>> 			irq =3D (level << IPIPE_IRQ_ISHIFT) + rank;
>>>
>>> 			if (test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control)) {
>>> 				__clear_bit(rank, &ipipe_this_cpudom_var(irqpend_lomask)[level]);=

>> - 				continue;
>> +				goto rpm_needs_more_neurons;
>>> 			}
>>>
>>> 			__clear_bit(rank, &ipipe_this_cpudom_var(irqpend_lomask)[level]);
>>>
>> + rpm_needs_more_neurons:
>>> 			if (ipipe_this_cpudom_var(irqpend_lomask)[level] =3D=3D 0)
>>> 				__clear_bit(level, &ipipe_this_cpudom_var(irqpend_himask));
>>> [ ... ]
>>>
>=20
> Of course, I'm not saying this is the real fix, but that just points at=
 a
> possible issue. I do want those 100 points on my score card.

Well, I wasn't asking for a fix, just for spotting the gremlin - so you
won! :->

Then let us fix this for real:

---
 kernel/ipipe/core.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: b/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -957,16 +957,14 @@ void fastcall __ipipe_sync_stage(unsigne
 			rank =3D __ipipe_ffnz(submask);
 			irq =3D (level << IPIPE_IRQ_ISHIFT) + rank;
=20
-			if (test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control)) {
-				__clear_bit(rank, &ipipe_this_cpudom_var(irqpend_lomask)[level]);
-				continue;
-			}
-
 			__clear_bit(rank, &ipipe_this_cpudom_var(irqpend_lomask)[level]);
=20
 			if (ipipe_this_cpudom_var(irqpend_lomask)[level] =3D=3D 0)
 				__clear_bit(level, &ipipe_this_cpudom_var(irqpend_himask));
=20
+			if (test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control))
+				continue;
+
 			__set_bit(IPIPE_STALL_FLAG, &ipipe_this_cpudom_var(status));
=20
 			if (ipd =3D=3D ipipe_root_domain)


--------------enigCFAECDD8576095BDF90473CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFII2zlniDOoMHTA+kRAujzAJ9CO+8fm5GwfaKATOJcz54r+4Yk8QCfRz/u
QqUb1g8n8kSe9g5B+kBJCDY=
=AHJj
-----END PGP SIGNATURE-----

--------------enigCFAECDD8576095BDF90473CC--


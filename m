Message-ID: <4562E2EC.7060205@domain.hid>
Date: Tue, 21 Nov 2006 12:28:44 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b647ffbd0611111559y8e66c37m12deb64828a85d08@domain.hid>	
	<455E022D.2000306@domain.hid>	
	<b647ffbd0611190255g11b79febhfa0619a2bf768b01@domain.hid>	
	<456171C7.2090006@domain.hid>	
	<b647ffbd0611201209s9d2348bx9579b382b12c7780@domain.hid>	
	<45623D01.9000404@domain.hid>
	<b647ffbd0611210132r3002191bj2cca5df3dcd5b861@domain.hid>
In-Reply-To: <b647ffbd0611210132r3002191bj2cca5df3dcd5b861@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig640BA1E7EF7D520642B35E18"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [patch] memory barriers in intr.c ::
	xnintr_lock/unlock()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig640BA1E7EF7D520642B35E18
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
>> Ok, I'm stopping further speculations here... Back to practice, so do =
we
>> go
>> > for smp_mb__before/after_atomic_* counterparts or live it as is? I
>> guess,
>> > those would be more optimal.
>> >
>>
>> As I said, I'm still not sure if we finally need it when we may use
>> per-cpu counters for efficiency reasons on the long-term. If this will=

>> add code or - even more important - an interface (of the system layer)=

>> that will soon be removed again...
>=20
>=20
> So could you reveal your vision of per-cpu counters in this scenario (o=
r
> something in linux does use it under similar circumstances.. RCU?) At t=
he
> first glance, it doesn't seem to be much better. Although, I haven't
> elaborated more thoroughly yet...

I was thinking about some SRCU-like mechanism with clear optimisation
focus on the reader-side. See this article for SRCU:

http://lwn.net/Articles/202847/

Having per-cpu counter would let SMP readers benefit - no need for
atomic ops then.

There is currently some discussion going on about refining the
implementation:

http://www.ussg.iu.edu/hypermail/linux/kernel/0611.2/0227.html

It looks to me that we are in the comfortable situation of being able to
avoid such extensions.

Jan


--------------enig640BA1E7EF7D520642B35E18
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFYuLsniDOoMHTA+kRAtEXAJ9HrrQAQ6i7Dag5QE0o9LbqUwr7OgCfQPYa
Gapk8c9AYhp0CnVhUy8clYI=
=olf0
-----END PGP SIGNATURE-----

--------------enig640BA1E7EF7D520642B35E18--


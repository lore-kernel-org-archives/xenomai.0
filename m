Message-ID: <481F4741.4080207@domain.hid>
Date: Mon, 05 May 2008 19:43:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <481F2B6A.802@domain.hid>
	<481F3110.1050407@domain.hid>	<2ff1a98a0805050912m60cf9d03o308bec827236b10a@domain.hid>	<481F3495.2010906@domain.hid>
	<481F3B3E.700@domain.hid>
In-Reply-To: <481F3B3E.700@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3E76B0E3DA33C9362597D040"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Houston, we have a circular problem
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3E76B0E3DA33C9362597D040
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> On Mon, May 5, 2008 at 6:08 PM, Philippe Gerum <rpm@xenomai.org> wrot=
e:
>>>>  do_schedule_event() is the culprit when it reads the pending signal=
s on the
>>>>  shared queue (XNDEBUG check for rearming the timers),
>>> A stupid suggestion: if we know that the spinlock is always locked
>>> when calling do_schedule_event, maybe we can simply avoid the lock
>>> there ?
>> Would be the best solution - but I don't think so. After reading a bit=

>> more into the lockdep output, I think the issue is that _some_other_
>> task my hold the siglock and then acquire our rq_lock, but not
>> necessarily along a similar code path we took to acquire the siglock n=
ow.
>>
>=20
> Actually, this locking around the sigmask retrieval looks overkill, sin=
ce we
> only address ptracing signals here, and those should go through the sha=
red
> pending set, not through the task's private one. I.e. There should be n=
o way to
> get fooled by any asynchronous update of that mask.

This is a debug helper anyway, so we risk (if I got this right) at worst
a spurious unfreeze of the Xenomai timers. Does not really compare to
the current deadlock...

I will let my colleagues run the hunk below tomorrow (which works for me)=
 -
let's see if they manage to crash it again :P (they are experts in this!)=
=2E

Jan

Index: xenomai-2.4.x/ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai-2.4.x/ksrc/nucleus/shadow.c	(Revision 3734)
+++ xenomai-2.4.x/ksrc/nucleus/shadow.c	(Arbeitskopie)
@@ -2194,9 +2194,7 @@ static inline void do_schedule_event(str
 			if (signal_pending(next)) {
 				sigset_t pending;
=20
-				spin_lock(&wrap_sighand_lock(next));	/* Already interrupt-safe. */
 				wrap_get_sigpending(&pending, next);
-				spin_unlock(&wrap_sighand_lock(next));
=20
 				if (sigismember(&pending, SIGSTOP) ||
 				    sigismember(&pending, SIGINT))


--------------enig3E76B0E3DA33C9362597D040
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFIH0dGniDOoMHTA+kRApofAJ0ZE4FXQl81KpG1Fy5cUQxvotg7nwCeKk4T
7xjiU+kzm6P72ozI43ao19Q=
=OVp+
-----END PGP SIGNATURE-----

--------------enig3E76B0E3DA33C9362597D040--


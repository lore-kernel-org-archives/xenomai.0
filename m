Message-ID: <4C0A9960.8040609@domain.hid>
Date: Sat, 05 Jun 2010 20:37:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4C07BA95.9080402@domain.hid>
	<1275759652.18250.178.camel@domain.hid>
In-Reply-To: <1275759652.18250.178.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBF68A3C2AC9DA2F7FB61F530"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [RFC][PATCH 2/2] x86: Add support for
	ipipe_get_irq_regs
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBF68A3C2AC9DA2F7FB61F530
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2010-06-03 at 16:22 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@domain.hid>
>>
>> Implement the x86 arch bits for ipipe_get_irq_regs support. This allow=
s
>> to drop __ipipe_tick_regs and use the new service instead.
>=20
> I'm unsure whether this patch would actually replace __ipipe_tick_regs
> properly, particularly regarding how the profiling code works.

tick_regs are a "workaround", this approach appears to me way closer to
how native works.

>=20
> But I'm now convinced that we are on the wrong track, with trying to
> track the IRQ frame, for the purpose we discussed on the Xenomai mailin=
g
> list. In fact, Gilles already told us about the best approach, we did
> not pay attention enough, though:
> https://mail.gna.org/public/xenomai-help/2010-06/msg00033.html
>=20
> Basically, we want to get a hold of the register frame of a task contex=
t
> before it returns to user-space, so that we can do some fixups.
> Therefore, the best option is clearly to add a special event, that the
> pipeline would dispatch upon request, when:
>=20
> - __ipipe_grab/handle_irq is about to return to userland
> - __ipipe_syscall_root is about to do the same
>=20
> In those contexts, we do have the _real_ register frame for the context=
,
> which removes the restriction on faked IRQ frames induced by the
> deferred interrupt model.

The register frame is incomplete, but it is very real. It is what you
get when an interrupt fires right after the kernel re-enabled IRQ deliver=
y.

> We could then use that feature, not only for
> having a more graceful watchdog, but for allowing Xenomai's real-time
> signals to preempt syscall-less code as well.
>=20
> I worked on this lately, and eventually coupled that event to a
> generalized support for forcing userland to run a kernel exit. I'll pos=
t
> more info to the Xenomai list.

That said, I'm not opposed to some kind of "I-pipe user space return
notifiers", specifically as they will include the syscall path. Maybe we
can still save bits of this approach to overcome the tick_regs and
related patches of the profiling code.

Jan


--------------enigBF68A3C2AC9DA2F7FB61F530
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkwKmWUACgkQitSsb3rl5xR/LACg3DSpfsNdbJIzm+fj+HHCKeRM
q9MAnR/6biZ2qJ54s1tsceB0N2on2K2l
=KJnX
-----END PGP SIGNATURE-----

--------------enigBF68A3C2AC9DA2F7FB61F530--


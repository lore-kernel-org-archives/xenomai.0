Message-ID: <43C18CE1.5040509@domain.hid>
Date: Sun, 08 Jan 2006 23:06:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency kernel part crashes on ppc64
References: <43C12304.4040802@domain.hid>
	<43C12CEC.8070403@domain.hid>	<43C14453.3040907@domain.hid>
	<1136754149.17443.21.camel@domain.hid>
In-Reply-To: <1136754149.17443.21.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig53D9EA81B8F0DD10947F2D9B"
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
To: Stelian Pop <stelian.pop@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig53D9EA81B8F0DD10947F2D9B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stelian Pop wrote:
> Le dimanche 08 janvier 2006 =E0 18:56 +0200, Heikki Lindholm a =E9crit =
:
>=20
>=20
>>>>Some recent changes (*cough* RTDM benchmark driver *cough*) broke ker=
nel
>>>>mode benchmarking for ppc64. Previously klatency worked fine, but now=

>>>>latency -t 1 crashes somewhere in xnpod_schedule. Jan, any pending
>>>>patches a comin'?
>=20
>=20
> So it seems I'm not alone.=20
>=20
> I have done some additionnal debugging on this issue in the last days. =
I
> still haven't find the bug but I narrowed it down a bit.
>=20
>>>Nope, it should work as it is. But as Stelian also reported problems o=
n
>>>his fresh ARM port with the in-kernel test, I cannot exclude that ther=
e
>>>/might/ be a problem in the benchmark.
>>>
>>>As I don't have any ppc64 hanging around somewhere, we will have to go=

>>>through this together. Things I would like to know:
>>
>>Dammit, I hoped you'd whip up a fix just from me noting a problem. Well=
,=20
>>all right then, I'll play along...;)
>>
>>
>>> o When and how does it crash? At start-up immediately? Or after a
>>>   while?
>>
>>I inserted some serial debug prints and it gets two passes to=20
>>eval_outer_loop done (enter/exit function). After that it freezes.=20
>=20
>=20
> It freezes exactly upon the invocation of rtdm_event_pulse() which
> causes a scheduling. In xnpod_schedule, the scheduler queue has been
> corrupted and this causes the illegal accesses.

Do you mean the synch-queue inside result_event or the global run-queue?
I saw in your test that you even moved result_event out of the context
structure and turned it into a global variable. So it seems that the
timerbench itself does not overwrite it.

Does it crash on the second or already first invocation of
rtdm_event_flush()?

>=20
>=20
>>Without the debug printing it dies with kernel access of illegal memory=
=20
>>at xnpod_schedule, which btw. has been quite a common place to die.
>=20
>=20
> Same for me.
>=20
>=20
>>> o Are there any details / backtraces available with the crash?
>>
>>Becaktrace limits to xnpod_schedule if I remember right.
>=20
>=20
> Same for me. But very often I don't even get a backtrace, it just hangs=
=2E
>=20
>=20
>>> o Does -t2 work?
>>
>>Umm. Probably not. See below.
>=20
>=20
> Heikki said in a later mail that it works for him, and so it does for m=
e
> too.
>=20
>=20
>>> o What happens if your disable "rtdm_event_pulse(&ctx->result_event);=
"
>>>   in eval_outer_loop (thus no signalling of intermediate results duri=
ng
>>>   the test)? Does it still crash, maybe later during cleanup now?
>=20
>=20
>>Doesn't freeze and can be exited with ctrl-c and even re-run.
>=20
>=20
> Same for me.
>=20
> Some additionnal information: I've disabled FPU handling in Xeno and it=

> doesn't change anything, it still crashes.
>=20
> As I said before, the old klatency test does work reliably for me, with=

> the latest Xenomai.
>=20
> I tried moving the 'display' thread into the kernel, and in this
> configuration it does no longer crash.

Hmm, the RTDM kernel entry/exit path? But what evil thing should happen
there? Weird.

>=20
> I've started simplifying the code trying to get to the simplest code
> which does have the problem. The results is at
> http://www.popies.net/tmp/xenobug/bug.tgz if somebody wants to take a
> look.

Re-checked your test on x86, no problems (this was obvious, I did a lot
of tests the last week with that setup and that particular piece of code)=
=2E

>=20
> I'll be working on this again tomorrow...
>=20

When you know now what piece of memory gets corrupted, you may add
checks or outputs of the content to the code, seeing which is the
offending function. And there is also a nice switch called
CONFIG_XENO_OPT_DEBUG which may provide some hints regarding incorrect
queue usages (although such things should have been triggered on other
archs as well).

Jan


--------------enig53D9EA81B8F0DD10947F2D9B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDwYznniDOoMHTA+kRAoyBAJ4/oCX0ClMg7tlZ9cb4tfpWn4vVNACggfKQ
8bPFNuVGeYxjvHluXhkKr9Y=
=hjHJ
-----END PGP SIGNATURE-----

--------------enig53D9EA81B8F0DD10947F2D9B--


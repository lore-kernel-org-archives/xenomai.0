Message-ID: <4651C70E.8080908@domain.hid>
Date: Mon, 21 May 2007 18:21:34 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <465099CE.2010004@domain.hid> <4651AFF9.5030402@domain.hid>
	<1179763621.473.145.camel@domain.hid>
In-Reply-To: <1179763621.473.145.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5ACF6E0691ED1360EBDF78C0"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [BUG] module_put called over non-root domain
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5ACF6E0691ED1360EBDF78C0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2007-05-21 at 16:43 +0200, Jan Kiszka wrote:
>> Hi Philippe,
>>
>> Jan Kiszka wrote:
>>> Just ran into this with CONFIG_IPIPE_DEBUG_CONTEXT (maybe due to some=

>>> bug of my own):
>> Here is some code to trigger the issue reliably:
>>
>> #include <sys/mman.h>
>> #include <native/task.h>
>>
>> void task_fnct(void *arg)
>> {
>>         rt_task_delete(NULL);
>> }
>>
>> main()
>> {
>>         RT_TASK task;
>>         mlockall(MCL_CURRENT|MCL_FUTURE);
>>         rt_task_spawn(&task, "task", 0, 10, 0, task_fnct, NULL);
>> }
>>
>>
>>> [  102.616000] I-pipe: Detected illicit call from domain 'Xenomai'
>>> [  102.616000]         into a service reserved for domain 'Linux' and=
 below.
>>> [  102.616000]        c741bdc8 00000000 00000000 c8860ef8 c741bdec c0=
105683 c032c200 c13fe22c
>>> [  102.616000]        c0361f00 c741be08 c01519ed c032f5b8 c032c742 c0=
3380b3 c8885100 c78beac0
>>> [  102.616000]        c741be14 c0142ce9 c7a80b30 c741be3c c884d075 c8=
85f150 c8860ef8 c741be3c
>>> [  102.616000] Call Trace:
>>> [  102.616000]  [<c0104d9f>] show_trace_log_lvl+0x1f/0x40
>>> [  102.616000]  [<c0104e71>] show_stack_log_lvl+0xb1/0xe0
>>> [  102.616000]  [<c0105683>] show_stack+0x33/0x40
>>> [  102.616000]  [<c01519ed>] ipipe_check_context+0xad/0xc0
>>> [  102.616000]  [<c0142ce9>] module_put+0x19/0x90
>>> [  102.616000]  [<c884d075>] xnshadow_unmap+0xb5/0x130 [xeno_nucleus]=

>>> [  102.616000]  [<c8871dc5>] __shadow_delete_hook+0x25/0x30 [xeno_nat=
ive]
>>> [  102.616000]  [<c8842f78>] xnpod_schedule+0xb58/0x12f0 [xeno_nucleu=
s]
>>> [  102.616000]  [<c8844bfb>] xnpod_delete_thread+0x2cb/0x3d0 [xeno_nu=
cleus]
>>> [  102.616000]  [<c886f5bd>] rt_task_delete+0x20d/0x220 [xeno_native]=

>>>
>>> I would dare to say that module_put in xnshadow_unmap is not well pla=
ced
>>> as it can wakeup a Linux process. The module ref-counter maintenance
>>> needs some postponing, I guess.
>=20
> Mm, I should definitely read mails entirely.
>=20
>> Attached is a patch proposal. It solves the issue by postponing the
>> module_put via a new schedule_linux_call. Note that this approach issu=
es
>> LO_WAKEUP_REQ where the old test (p->state !=3D TASK_RUNNING) would no=
t
>> have done so. I don't see negative side effects yet,
>=20
> This code has to work with an awful lot of runtime situations, includin=
g
> those raised by ptracing/GDB, and thread signaling in general, so test
> harnessing is key here.

Well, what about listing those scenarios and their requirements in a
comment if this is so critical? That may make /me feel better as I could
more easily go through them and check changes like those of today
against them.

>=20
>>  and I'm furthermore
>> not sure of the old code was handling SMP scenarios safely (What if th=
e
>> thread to be unmapped was running on different CPU than xnshadow_unmap=
?
>> How to ensure test-atomicity then?).
>>
>=20
> This wakeup call is there to release emerging shadows waiting on their
> start barrier that get killed before start. Other regular cases imply
> that either the current thread is exiting - in which case this is a no
> brainer, or it has been sent a group kill signal, in which case it has
> to wake up anyway.

I didn't _removed_ cases where the wakeup takes place, I _added_ some
more my removing the test.

>=20
>> Well, this thing seems to work,
>=20
> It does, actually.
>=20
>>  but it doesn't leave me with a good
>> feeling. IMHO, there are far too many cleanup cases with all the
>> combinations of non-shadow termination, shadow self-termination,
>> termination on task exit, various SMP scenarios, etc.
>>  Moreover, quite a
>> lot of stuff is executed in atomic scheduling hooks (namely on cleanup=
).
>> At least for shadow threads, I don't think all of this is necessary.
>> Actually, deferring most of the uncritical cleanup work into Linux
>> context would make things more regular, easier to review, and likely
>> less disturbing for overall system latencies. I know that atomic
>> scheduling hooks are required to implement certain skins, but I don't
>> see why janitor work should be done there as well. And we also still
>> have that tiny uncleanness on shadow threads termination around TCB
>> release vs. hook execution.
>=20
> Talking about xnshadow_unmap, and as your patch illustrates, what you
> could postpone is basically the first part of the routine, which update=
s
> the reference counts. The rest _must_ run over the deletion hook in
> atomic context (already runs fine all Linux debug switches on). The

rpi_pop()? No chance to call it before entering the scheduler and then
the hooks?

> latency hit is certainly not seen there; the real issues are left in th=
e
> native and POSIX skin thread deletion routines (heap management and
> other housekeeping calls under nklock and so on).

That's surely true. Besides RPI manipulation, there is really no
problematic code left here latency-wise. Other hooks are trickier. But
my point is that we first need some infrastructure to provide an
alternative cleanup context before we can start moving things. My patch
today is a hack...err...workaround from this perspective.

>=20
>> As we are already at it: LO_MAX_REQUESTS is a hidden limitation that
>> may (theoretically) bite large setups when e.g. too many threads gets
>> killed from the "wrong" context. At least some overflow detection is
>> required here to warn the unfortunate user that he reached hard-coded
>> scalability limits.
>=20
> Yes.

CONFIG_XENO_OPT_DEBUG[_NUCLEUS] or unconditionally (error return code)?

Jan


--------------enig5ACF6E0691ED1360EBDF78C0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGUccOniDOoMHTA+kRAif9AJ909kujjNzF75UzBAqssZZQUlH8BQCdGik+
ZkKa7pWRRBjrNtIFxcdAA3w=
=USQh
-----END PGP SIGNATURE-----

--------------enig5ACF6E0691ED1360EBDF78C0--


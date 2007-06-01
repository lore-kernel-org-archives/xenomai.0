Message-ID: <465FC2FC.1010902@domain.hid>
Date: Fri, 01 Jun 2007 08:55:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <465ABD99.1090301@domain.hid> <1180630376.5020.131.camel@domain.hid>	
	<465F3277.1080400@domain.hid> <1180651652.5020.197.camel@domain.hid>
In-Reply-To: <1180651652.5020.197.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBD61229CDE462FB36800C35D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [ANNOUNCE] Xenomai and I-pipe patch	series,
 LTTng bits
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
--------------enigBD61229CDE462FB36800C35D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
>> ...
>>>> xeno-kill-ipipe_processor_id.patch
>>>>     Refreshed cleanup patch to remove ipipe_processor_id completely.=

>>>>
>>> The logic of this patch is flawed. rthal_processor_id() already impli=
es
>>> rawness wrt how we fetch the current CPU number, so
>>> rthal_raw_processor_id() is redundant, and xnarch_raw_current_cpu() t=
oo
>> It isn't when you take a look at the corresponding I-pipe patch as wel=
l:
>> This enables debug instrumentation of smp_processor_id to validate als=
o
>> the atomicity of Xenomai core code /wrt cpuid handling!
>>
>=20
> Nope, not for archs which do _not_ have a stack-insensitive
> smp_processor_id() and get_current() yet (if it's even possible for all=

> of them, since the in-kernel ABI would likely have to be amended for
> reserving the PDA register). Some archs even have stack-insensitive
> get_current(), but stack-sensitive current_thread_info(), so we might b=
e
> toast in a way or another.
>=20
> I'm not arguing that the I-pipe changes you suggest have no value in th=
e
> 2.6.20/x86* contexts for instance, but since they also affect the gener=
ic
> code area, they can't work for all our supported configurations right
> now. For instance, on an I-pipe setup with a non-heading Xenomai domain=

> and DEBUG_PREEMPT enabled, a kernel-based Xenomai thread calling
> smp_processor_id() from a stalled context (which would be legal) would
> _require_ preemption control macros and get_current() to be
> stack-insensitive. At that point, we would have some problem propagatin=
g
> this assumptions to the generic Xenomai core, specifically for the
> Blackfin and ARM variants, which do not have stack-insensitive accessor=
s
> here.
>=20
> Also, my point is that we don't want to change the usability of
> rthal_processor_id(). So either it does not change with this patch, and=

> the raw* forms are useless, or it changes, and this is a no-go. Keep in=

> mind that a number of external modules may rely on this aspect already;=

> so either we kill rthal_processor_id() completely to force a proper
> update in depending code, or we keep the basic assumptions about the
> usability context unchanged, but we just cannot make the situation more=

> fragile for the out of tree code by changing such a fundamental
> assumption (i.e. that rthal_processor_id() is context-agnostic).

Ok, I see it's too early. Let's put this back into the drawer until we
might solve the stack-sensitiveness issue for all archs (as we recently
started to discuss). I will rework the I-pipe patches so that we can
make use of some parts of them already now.

>=20
>>> for the same reason. Additionally, xnpod_current_sched() also implies=
 to
>>> use a raw accessor to the CPU number, so xnpod_current_raw_sched() is=

>>> pointless. For this reason, we must be extra-careful about replacing
>>> rthal_processor_id() with smp_processor_id(), because 1) we may want =
to
>>> bypass DEBUG_PREEMPT checks sometimes, 2) not all supported archs do
>>> have a stack-insensitive smp_processor_id() implementation yet
>>> (blackfin, ARM, and Linux/x86 2.4).
>> For 1) see ipipe again, but 2), granted, is a problem. Likely the cut =
is
>> too radical and we must leave the infrastructure in place. Still, maki=
ng
>> use of DEBUG_PREEMPT also for Xenomai is IMHO worth some changes that
>> will then at least have effect on a subset of archs.
>=20
> It becomes very useful precisely because ipipe_processor_id() gets
> killed.
>=20
>>> To answer the inlined question about the need to initialize the ->sch=
ed
>>> field when setting up a timer, I would say yes, we have to set this u=
p
>>> too. It might seem a bit silly, but nothing would prevent a migration=

>>> call to occur for a just initialized timer, in which case, we would n=
eed
>>> the sched pointer to reflect the current situation (i.e. at init time=
).
>> But what would be the effect of a wrong sched until the timer is
>> started?
>=20
> panic. See the code flow from xntimer_start_*periodic for instance, up
> to the point where the timer is enqueued.

With wrong I meant valid sched, but for an incorrect CPU.

>=20
>>  Anyway, if you say it does matter, my instrumentation would
>> have caught the first bug in Xenomai! That xnpod_raw_current_sched() i=
s
>> there because xntimer_init is used in non-atomic contexts (I got
>> warnings from DEBUG_PREEMPT).
>=20
> Thread migration in Xenomai only happens upon request from the migratin=
g
> thread itself, so it becomes an issue if the caller belongs to the Linu=
x
> domain (i.e. preemption in init_module, the rest is not much

=2E..or preemption during shadow thread creation. But this requires the
that Linux thread to be shadowed has no clearly defined single-CPU
affinity and might happen to be pushed around by a loadbalancer during
init. This sounds like a fatal user error /wrt RT.

> preemptible), in which case the timer might be queued on a different CP=
U
> than the thread's. But since we don't migrate timers upon
> sched_setaffinity() requests already, but only upon
> xnpod_migrate_thread() calls, this seems a non-issue. We would have an
> extra cost for managing a remote timer, but this would work, and above
> all, this would be no different from enduring such migration caused by
> sched_setaffinity() outside of xntimer_init().

Agreed. There is the risk that the timer is attached to one CPU while
the thread starts on some other, but this only means suboptimal
performance and would be due to a user mistake.

>=20
>>>> librtutils.patch
>>>>
>>>>     My original librtprint patch. I now renamed the library to
>>>>     librtutils to express that more stuff beyond rt_print may find i=
ts
>>>>     home here in the future. Hopefully acceptable now.
>>>>
>>> Will merge, but... since I'm something of a pain, I'm still pondering=

>>> whether rtutils is our best shot for picking up a name here. We alrea=
dy
>>> have src/utils, so we would add src/librtutils as yet another set of
>>> utilities; I'm not sure both belong to the same class of helpers.
>> /me hesitated as well and put the "lib" prefix into the directory name=
=2E
>> So I'm all ears for a better name!
>>
>=20
> TssTssTss... _You_ got the brain, _I_ am the cumbersome one.

But my brain needs some pointers what _you_ would be happy with. Is your
current problem only related to the clash librtutils vs. utils, or don't
you like the term "rtutils" at all? If it's the former, would moving
"utils" to "tools" raise or lower your pain?

>=20
>>>> rtsystrace-v2.patch
>>>>
>>>>     Updated proposal to add rt_print-based Xenomai syscall tracing.
>>>>     Still in early stage, and I'm lacking feedback on this approach,=
 if
>>>>     it makes sense to pursue it.
>>>>
>>> Gasp. I really don't like the idea of having tons of explicit trace
>>> points spread all over the code, this just makes the task of reading =
it
>>> a total nightmare. There are some user-space tracing infrastructure
>>> already, starting with LTTng, or maybe older ones like Ctrace, with o=
r
>>> without automatic instrumentation of the source files.
>>> We may want to get some facts about those before reinventing a square=

>>> wheel.
>> Let me elaborate about the motivation a bit more: My idea is to have a=
n
>> rt-safe replacement for strace. The latter is based on ptrace, require=
s
>> evil signals, and is far to invasive for tracing high-speed RT
>> applications IMHO (even if we had that RT-safe). But with low-impact,
>> per-process rt_printf, we have a pure user space mechanism at hand tha=
t
>> you can quickly set up for a single RT application (using your private=

>> libs e.g.). No need to have an LTTng-prepared kernel, no need to trace=

>> the whole system if you only want to know where your damn applications=

>> now hangs again, no need to disturb other RT users with your debugging=

>> stuff.
>>
>> But I agree, the source code impact on the skin libs is far from being=

>> negligible. Maybe we can find a smarter solution, something that just
>> hooks into the library calls (reminds me of --wrap...) to capture entr=
y
>> parameters and then the returned values. This will still require some
>> work (for each instrumented library function), but we might be able to=

>> do this out-of-line.
>=20
> At some point, I think we should really put some brain cycles into
> looking into Valgrind, and evaluate the actual cost of adapting it to
> our needs (for both the existing memory tracker skin, and maybe a trace=

> skin too).

Valgrind is not a replacement for strace, even if it would work for
multi-threaded strickly timed RT apps (which I doubt, I _did_ look at it
already, understood that it requires a complex and temporal invasive VM,
and also read their warnings regarding standard pthread support). This
is a widely orthogonal issue, so please let us come back to my original
point.

>=20
>>>> lttng.patch
>>>>
>>>>     Very rough patch to make LTTng work with Xenomai again. This pat=
ch
>>>>     tries to follow Jean-Olivier Villemure's original work very clos=
ely
>>>>     to get something working first. Needs more cleanups and enhancem=
ents
>>>>     as I explained earlier in the LTTng announcement.
>>>>
>>> Will merge to ease further work on this feature. xenoltt.xml might be=

>>> left in another directory than src/utils, or at least in a separate
>>> subdir, like can/.
>> Note that the patch is a big fat construction site (see the earlier
>> announcement). I'm happy to see your interest, and we should already
>> discuss details like the location of xenoltt.xml. But I think it's not=

>> yet ready for merge.
>>
>> I would like to get the structure right first (multiple probe modules)=
,
>> and I'm lacking the understanding about what the Xenomai plugin for LT=
TV
>> is actually able to do, what kind of trace point formats it needs to
>> work correctly. Well, this situation can quickly improve once we play =
a
>> bit more with it, but resources remain limited.
>>
>=20
> The decision is rather simple here: whether our current LTT
> instrumentation works and is usable with decent LTT releases, and we
> should keep it, waiting for the new LTTng support to mature out of tree=
=2E

Current LTT support is useless for a fairly long time as we had no LTT
patches for I-pipe - also for a long time. From this POV, we can happily
change the code without causing regressions (as long as it builds, of
course).

> Or, this is not the case, and we would be better off putting this patch=

> where it has a better chance to be seen and evaluated, i.e. into the
> development tree. So the basic issue here is that we might have to make=

> the patch you sent working well enough to trigger interest in improving=

> it, unless it does already. What's the situation regarding this?
>=20

Daniel indicated interest in looking at this, but he is fairly busy for
the near future. No further feedback so far.

My suggestion is to keep the patch out-of-tree for now. Everyone
interested in trying LTTng needs patching anyway (LTTV, ipipe, Xenomai).
I will keep this patch in my stack and take care that it remains applicab=
le.

In the meantime, Xenomai should align with the latest kernel again
(2.6.21/22) so that also the LTTng patches can be updated, simplifying
the patch process and maturing our own probing support (like "MARK" ->
"trace_mark"). I will look at the Xenomai side again to make it more
quickly mergeable. With ipipe_processor_id not vanishing, there remains
some work on the I-pipe side of LTTng as well (for non-x86 support).

Jan


--------------enigBD61229CDE462FB36800C35D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGX8L9niDOoMHTA+kRAlL1AJ401Ce5Mt0f+UHTL0x6oWa1J3BwiQCbBZN9
v7ZXQS2kk+y9ezztjTmcVWo=
=Mo81
-----END PGP SIGNATURE-----

--------------enigBD61229CDE462FB36800C35D--


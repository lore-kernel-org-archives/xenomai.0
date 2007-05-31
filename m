Message-ID: <465F3277.1080400@domain.hid>
Date: Thu, 31 May 2007 22:39:19 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <465ABD99.1090301@domain.hid> <1180630376.5020.131.camel@domain.hid>
In-Reply-To: <1180630376.5020.131.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3AD208D1E1949EE6F91A8A9A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [ANNOUNCE] Xenomai and I-pipe patch series,
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
--------------enig3AD208D1E1949EE6F91A8A9A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2007-05-28 at 13:31 +0200, Jan Kiszka wrote:
>> Instead of posting yet another stream of individual patches from my
>> queue, I decided to put them all into a series and upload them. See
>>
>> 	http://www.rts.uni-hannover.de/rtaddon/patches
>>
>> for my latest I-pipe, Xenomai, and LTTng enhancements and fixes. Here =
is
>> a short overview of the content:
>>
>=20
> Note to users: Those patches are all for trunk/v2.4, so don't search fo=
r
> them into the v2.3.x stable branch.

Of course, I wouldn't dare to shake the stable tree. :)

=2E..
>> fast-tsc-to-ns.patch
>>
>>     Integration of my scaled-math-based xnarch_tsc_to_ns service for
>>     i386 at least. xnarch_ns_to_tsc remains untouched in order to keep=

>>     conversion errors small. clocktest reports no significant precisio=
n
>>     regression here, and both code size and execution speed improved.
>>
>=20
> Postponed. I need some feedback from Gilles who wrote the generic
> support for the funky arithmetics we use.

Yeah, looking forward. I would also be interested to hear if/what this
approach may buy us on non-x86 architectures.

=2E..
>> xeno-kill-ipipe_processor_id.patch
>>     Refreshed cleanup patch to remove ipipe_processor_id completely.
>>
>=20
> The logic of this patch is flawed. rthal_processor_id() already implies=

> rawness wrt how we fetch the current CPU number, so
> rthal_raw_processor_id() is redundant, and xnarch_raw_current_cpu() too=


It isn't when you take a look at the corresponding I-pipe patch as well:
This enables debug instrumentation of smp_processor_id to validate also
the atomicity of Xenomai core code /wrt cpuid handling!

> for the same reason. Additionally, xnpod_current_sched() also implies t=
o
> use a raw accessor to the CPU number, so xnpod_current_raw_sched() is
> pointless. For this reason, we must be extra-careful about replacing
> rthal_processor_id() with smp_processor_id(), because 1) we may want to=

> bypass DEBUG_PREEMPT checks sometimes, 2) not all supported archs do
> have a stack-insensitive smp_processor_id() implementation yet
> (blackfin, ARM, and Linux/x86 2.4).

For 1) see ipipe again, but 2), granted, is a problem. Likely the cut is
too radical and we must leave the infrastructure in place. Still, making
use of DEBUG_PREEMPT also for Xenomai is IMHO worth some changes that
will then at least have effect on a subset of archs.

>=20
> To answer the inlined question about the need to initialize the ->sched=

> field when setting up a timer, I would say yes, we have to set this up
> too. It might seem a bit silly, but nothing would prevent a migration
> call to occur for a just initialized timer, in which case, we would nee=
d
> the sched pointer to reflect the current situation (i.e. at init time).=


But what would be the effect of a wrong sched until the timer is
started? Anyway, if you say it does matter, my instrumentation would
have caught the first bug in Xenomai! That xnpod_raw_current_sched() is
there because xntimer_init is used in non-atomic contexts (I got
warnings from DEBUG_PREEMPT).

>> librtutils.patch
>>
>>     My original librtprint patch. I now renamed the library to
>>     librtutils to express that more stuff beyond rt_print may find its=

>>     home here in the future. Hopefully acceptable now.
>>
>=20
> Will merge, but... since I'm something of a pain, I'm still pondering
> whether rtutils is our best shot for picking up a name here. We already=

> have src/utils, so we would add src/librtutils as yet another set of
> utilities; I'm not sure both belong to the same class of helpers.

/me hesitated as well and put the "lib" prefix into the directory name.
So I'm all ears for a better name!

>=20
>> rtsystrace-v2.patch
>>
>>     Updated proposal to add rt_print-based Xenomai syscall tracing.
>>     Still in early stage, and I'm lacking feedback on this approach, i=
f
>>     it makes sense to pursue it.
>>
>=20
> Gasp. I really don't like the idea of having tons of explicit trace
> points spread all over the code, this just makes the task of reading it=

> a total nightmare. There are some user-space tracing infrastructure
> already, starting with LTTng, or maybe older ones like Ctrace, with or
> without automatic instrumentation of the source files.
> We may want to get some facts about those before reinventing a square
> wheel.

Let me elaborate about the motivation a bit more: My idea is to have an
rt-safe replacement for strace. The latter is based on ptrace, requires
evil signals, and is far to invasive for tracing high-speed RT
applications IMHO (even if we had that RT-safe). But with low-impact,
per-process rt_printf, we have a pure user space mechanism at hand that
you can quickly set up for a single RT application (using your private
libs e.g.). No need to have an LTTng-prepared kernel, no need to trace
the whole system if you only want to know where your damn applications
now hangs again, no need to disturb other RT users with your debugging
stuff.

But I agree, the source code impact on the skin libs is far from being
negligible. Maybe we can find a smarter solution, something that just
hooks into the library calls (reminds me of --wrap...) to capture entry
parameters and then the returned values. This will still require some
work (for each instrumented library function), but we might be able to
do this out-of-line.

>=20
>> lttng.patch
>>
>>     Very rough patch to make LTTng work with Xenomai again. This patch=

>>     tries to follow Jean-Olivier Villemure's original work very closel=
y
>>     to get something working first. Needs more cleanups and enhancemen=
ts
>>     as I explained earlier in the LTTng announcement.
>>
>=20
> Will merge to ease further work on this feature. xenoltt.xml might be
> left in another directory than src/utils, or at least in a separate
> subdir, like can/.

Note that the patch is a big fat construction site (see the earlier
announcement). I'm happy to see your interest, and we should already
discuss details like the location of xenoltt.xml. But I think it's not
yet ready for merge.

I would like to get the structure right first (multiple probe modules),
and I'm lacking the understanding about what the Xenomai plugin for LTTV
is actually able to do, what kind of trace point formats it needs to
work correctly. Well, this situation can quickly improve once we play a
bit more with it, but resources remain limited.

Jan


--------------enig3AD208D1E1949EE6F91A8A9A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGXzJ3niDOoMHTA+kRAt8yAJ9xRdJ2xF8/kYgLnU7b6lRbP5FVrwCdEiRI
2NG0jGAHe47KufHjmMnsIdg=
=NmV3
-----END PGP SIGNATURE-----

--------------enig3AD208D1E1949EE6F91A8A9A--


Message-ID: <46C5B273.60006@domain.hid>
Date: Fri, 17 Aug 2007 16:36:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46C59855.7030902@domain.hid> <46C59C2C.201@domain.hid>
In-Reply-To: <46C59C2C.201@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4916B108FFD6097B725543E5"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] (WARNING!!! PGP with incorrect signature) Re:
 Time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dirk Eibach <eibach@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4916B108FFD6097B725543E5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dirk Eibach wrote:
> jan.kiszka@domain.hid wrote:
>> Dirk Eibach wrote:
>>> gilles.chanteperdrix@xenomai.org wrote:
>>>> On 8/17/07, Dirk Eibach <eibach@domain.hid> wrote:
>>>>> gilles.chanteperdrix@xenomai.org wrote:
>>>>>> Dirk Eibach wrote:
>>>>>>  > Hello,
>>>>>>  >
>>>>>>  > I'm wondering how long a rt_mutex_acquire is supposed to take
>>>>>> on a PPC405
>>>>>>  > platform. I'm getting times about 50 usec here, which is too
>>>>>> much for my
>>>>>>  > application. Is anything wrong in my kernel/xenomai
>>>>>> configuration or is
>>>>>>  > this time to expected?
>>>>>>
>>>>>> How do you measure this ? Are you sure the mutex is free when you
>>>>>> try to
>>>>>> acquire it ?
>>>>>>
>>>>> I prepared a small testcase. It shows about 8.300 ticks, which is
>>>>> about 30
>>>>> usec on my platform (266MHz).
>>>> Did you try to call ppc_getcounter twice in a raw to measure the
>>>> overhead of this function ?
>>> Calling ppc_getcounter twice in a raw results in 116 ticks.
>>
>> Is that service RT-safe, means does it stay in user space and issue no=

>> Linux syscall? Maybe some of the PPC gurus can comment on this as well=

>> (/me is lacking comparative numbers).
>=20
> This service should be RT-safe as it consists only of a few assembly
> commands that read the timestamp counter (which is allowed from userspa=
ce).

Blind as I am, I missed it's in your own code...

Is rt_timer_ns2ticks known to work accurately with it, or is the counter
even the same Xenomai uses?

>=20
>>
>> Besides this, you may want to try running the latency tracer on your
>> scenario. xntrace_user_start() and xntrace_user_stop(0) would frame th=
e
>> path you want to measure, /proc/ipipe/trace/frozen will show its kerne=
l
>> side. For sure, that tool will increase the latency even more, but it
>> may show better what goes on.
>=20
> Here we go (start, acquire, stop):
>=20
> I-pipe frozen back-tracing service on 2.6.18/ipipe-1.5-00
> ------------------------------------------------------------
> Freeze: 2785703857177 cycles, Trace Points: 30 (+10)
>=20
>  +--------------- Hard IRQs ('|': locked)
>  |             +- Delay flag ('+': > 1 us, '!': > 10 us)
>  |             |
>   Type     Time   Function (Parent)
> : func      -49+  xnshadow_sys_trace (hisyscall_event)
> : func      -46   ipipe_trace_frozen_reset (xnshadow_sys_trace)
> : func      -45+  __ipipe_global_path_lock (ipipe_trace_frozen_reset)
> :|begin     -44+  __ipipe_global_path_lock (ipipe_trace_frozen_reset)
> :|end       -41+  __ipipe_global_path_unlock (ipipe_trace_frozen_reset)=

> :|begin     -39+  __ipipe_dispatch_event (__ipipe_syscall_root)
> :|end       -38+  __ipipe_dispatch_event (__ipipe_syscall_root)

Here we start.

> : func      -34+  __ipipe_syscall_root (DoSyscall)
> : func      -33+  __ipipe_dispatch_event (__ipipe_syscall_root)
> :|begin     -31+  __ipipe_dispatch_event (__ipipe_syscall_root)
> :|end       -30+  __ipipe_dispatch_event (__ipipe_syscall_root)
> : func      -29+  hisyscall_event (__ipipe_dispatch_event)
> : func      -27+  __rt_mutex_acquire (hisyscall_event)
> : func      -25+  xnregistry_fetch (__rt_mutex_acquire)
> :|begin     -24+  xnregistry_fetch (__rt_mutex_acquire)
> :|func      -22+  __ipipe_restore_pipeline_head (xnregistry_fetch)
> :|end       -20+  __ipipe_restore_pipeline_head (xnregistry_fetch)
> : func      -19+  rt_mutex_acquire (__rt_mutex_acquire)
> :|begin     -17+  rt_mutex_acquire (__rt_mutex_acquire)
> :|func      -15+  __ipipe_restore_pipeline_head (rt_mutex_acquire)
> :|end       -14+  __ipipe_restore_pipeline_head (rt_mutex_acquire)
> :|begin     -12+  __ipipe_dispatch_event (__ipipe_syscall_root)
> :|end       -11+  __ipipe_dispatch_event (__ipipe_syscall_root)
> : func       -8+  __ipipe_syscall_root (DoSyscall)

And here we're done. About 26 us minus the tracer overhead, which should
cost us at least a few microseconds. You may already see a bit of this
by disabling CONFIG_IPIPE_TRACE_IRQSOFF (not needed for this measurement)=
=2E

Still not really short, but it is a full syscall in the end. Anyone with
platform experience around to comment on the numbers?

Jan


--------------enig4916B108FFD6097B725543E5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGxbJzniDOoMHTA+kRAvX2AJ9hgaU/XdDmKgNJ8C7+XIbwhwSOyQCdEAM5
V5G10Z79cayaz2lmDphgOxM=
=nlqS
-----END PGP SIGNATURE-----

--------------enig4916B108FFD6097B725543E5--


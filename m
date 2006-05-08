Message-ID: <445F332A.60907@domain.hid>
Date: Mon, 08 May 2006 14:01:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] Micro-optimisations for the libs
References: <445C59C9.8020107@domain.hid> <445C7C80.9080105@domain.hid>
	<445F22C5.7070004@domain.hid>
In-Reply-To: <445F22C5.7070004@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1F4A95FBE312451E2B69EB60"
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
To: Wolfgang Grandegger <wg@domain.hid>, Philippe Gerum <rpm@xenomai.org>
Cc: Daniel.Rossier@domain.hid, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1F4A95FBE312451E2B69EB60
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>> Hi,
>>>
>>> [Daniel, I put you in the CC as you showed some interest in this topi=
c.]
>>>
>>> as I indicated a some weeks ago, I had a closer look at the code the
>>> user space libs currently produce (on x86). The following considerati=
ons
>>> are certainly not worth noticeable microseconds on GHz boxes, but the=
y
>>> may buy us (yet another) few micros on low-end.
>>>
>>> First of all, there is some redundant code in the syscall path of eac=
h
>>> skin service. This is due to the fact that the function code is
>>> calculated based on the the skin mux id each time a service is invoke=
d.
>>> The mux id has to be shifted and masked in order to combine it with t=
he
>>> constant function code part - this could also easily happen
>>> ahead-of-time, saving code and cycles for each service entry point.
>>>
>>> Here is a commented disassembly of some simple native skin service wh=
ich
>>> only takes one argument.
>>>
>>>
>>> Function prologue:
>>>  460:   55                      push   %ebp
>>>  461:   89 e5                   mov    %esp,%ebp
>>>  463:   57                      push   %edi
>>>  464:   83 ec 10                sub    $0x10,%esp
>>>
>>> Loading the skin mux-id:
>>>  467:   a1 00 00 00 00          mov    0x0,%eax
>>>
>>> Loading the argument (here: some pointer)
>>>  46c:   8b 7d 08                mov    0x8(%ebp),%edi
>>>
>>> Calculating the function code:
>>>  46f:   c1 e0 10                shl    $0x10,%eax
>>>  472:   25 00 00 ff 00          and    $0xff0000,%eax
>>>  477:   0d 2b 02 00 08          or     $0x800022b,%eax
>>>
>>> Saving the code:
>>>  47c:   89 45 f8                mov    %eax,0xfffffff8(%ebp)
>>>
>>>  47f:   53                      push   %ebx
>>>
>>> Loading the arguments (here only one):
>>>  480:   89 fb                   mov    %edi,%ebx
>>>
>>> Restoring the code again, issuing the syscall:
>>>  482:   8b 45 f8                mov    0xfffffff8(%ebp),%eax
>>>  485:   cd 80                   int    $0x80
>>>
>>>  487:   5b                      pop    %ebx
>>>
>>> Function epilogue:
>>>  488:   83 c4 10                add    $0x10,%esp
>>>  48b:   5f                      pop    %edi
>>>  48c:   5d                      pop    %ebp
>>>  48d:   c3                      ret
>>>
>>>
>>> Looking at this code, I also started thinking about inlining short an=
d
>>> probably heavily-used functions into the user code. This would save t=
he
>>> function prologue/epilogue both in the lib and the user code itself. =
For
>>> sure, it only makes sense for time-critical functions (think of
>>> mutex_lock/unlock or rt_timer_read). But inlining could be made optio=
nal
>>
>> The best optimization for rt_timer_read() would be to do the
>> cycles-to-ns conversion in user-space from a direct TSC reading if the=

>> arch supports it (most do). Of course, this would only be possible for=

>> strictly aperiodic timing setups (i.e. CONFIG_XENO_OPT_PERIODIC_TIMING=

>> off).
>>
>> For the rt_mutex_lock()/unlock(), we still need to refrain from
>> calling the kernel for uncontended access by using some Xeno
>> equivalent of the futex approach, which would suppress most of the
>> incentive to micro-optimize the call itself.

Ack. That's a bit more complex to realise but should be put on our to-do
list as well.

>>
>>> for the user by providing both the library variant and the inlined
>>> version. The users could then select the preferred one by #defining s=
ome
>>> control switch before including the skin headers.
>>>
>>> Any thoughts on this? And, almost more important, anyone around willi=
ng
>>> to work on these optimisations and evaluate the results? I can't ATM.=

>>>
>>
>> Quite frankly, I remember that I once had to clean up the LXRT
>> inlining support in RTAI 3.0/3.1, and this was far from being fun
>> stuff to do. Basically, AFAICT, having both inline and out-of-line
>> support for library calls almost invariably ends up to a maintenance
>> nightmare of some sort, e.g. depending whether to compile with gcc's
>> optimization on or not, which might be dictated by the fact that one
>> also wants (exploitable) debug information or not, and so on. Not to
>> speak of the fact that you end up having two implementations to
>> maintain separately.
>>
>> This said, only the figures would tell us if such inlining brings
>> something significant or not to the picture performance-wise on
>> low-end hw, so I'd be interested to see those first.
>=20
> I agree! I have also doubts that using inline function will improve
> latencies. Larger code also results in more TBL misses and cache refill=
s.
>=20

I'm definitely not arguing for the aggressive inlining RTAI provides
(all or nothing). I'm rather suggesting selective optional inlining of
trivial and heavily-used stubs. Think of something like rt_sem_v() for
the library call vs. rt_sem_v_inlined() for an unrolled variant.
rt_sem_v() could simply be implemented by calling rt_sem_v_inlined(),
thus there should also be no reason why the maintenance hell might get
reopened.

I think the order I presented should be kept when looking at these
optimisations:
1. reduce the complexity of existing syscall code,
2. consider if we can provide any benefit to the user by offering /some/
functions as optional inlines.

Jan


--------------enig1F4A95FBE312451E2B69EB60
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEXzMqniDOoMHTA+kRAgDFAJ9N++e3EGQUdZA2gsx9AJLT9O5WjgCfeOZ3
aPoPuwENM4cZEaLVsGayY+U=
=+4+/
-----END PGP SIGNATURE-----

--------------enig1F4A95FBE312451E2B69EB60--


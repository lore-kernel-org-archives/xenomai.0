Message-ID: <4C078B19.3040206@domain.hid>
Date: Thu, 03 Jun 2010 12:59:37 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4C0692A9.2080806@domain.hid> <4C06953D.90003@domain.hid>	
	<4C0751FC.8050009@domain.hid>
	<1275553646.18250.65.camel@domain.hid>	
	<4C076C10.3070708@domain.hid>
	<1275558996.18250.85.camel@domain.hid>	
	<4C07815F.3010704@domain.hid>
	<1275562063.18250.97.camel@domain.hid>
In-Reply-To: <1275562063.18250.97.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5C9269250578A41B6F8FC883"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RFC] Break out of endless user space loops
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>, Tschaeche IT-Services <services@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5C9269250578A41B6F8FC883
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2010-06-03 at 12:18 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Thu, 2010-06-03 at 10:47 +0200, Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> On Thu, 2010-06-03 at 08:55 +0200, Jan Kiszka wrote:
>>>>>> Gilles Chanteperdrix wrote:
>>>>>>> Jan Kiszka wrote:
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> here is the first apparently working prototype for getting hold =
of
>>>>>>>> endless user space loops in RT threads. A simple test case of mi=
ne now
>>>>>>>> receive a SIGDEBUG even if it does "while (1);".
>>>>>>>>
>>>>>>>> The design follows Gilles' suggestion to force a SEGV on victim =
thread
>>>>>>>> but restore the patched PC before migrating the thread after thi=
s fault.
>>>>>>>> The only drawback of this approach: We need to keep track of the=

>>>>>>>> preempted register set at I-pipe level. I basically replicated w=
hat
>>>>>>>> Linux does these days as well and exported it as ipipe_get_irq_r=
egs()
>>>>>>>> (the second patch).
>>>>>>> You already have the regs in xnarch_fault_info.
>>>>>>>
>>>>>> We only pass this around for exceptions.
>>>>> And for a good reason, exceptions are always delivered synchronousl=
y
>>>>> upon receipt, not IRQs, given the deferred dispatching scheme. Your=

>>>>> ipipe_get_irq_regs interface is inherently broken for anything whic=
h is
>>>>> not a wired-mode timer IRQ, since you could pass the caller a refer=
ence
>>>>> to an unwound stack frame.
>>>> It may not work for certain deferred IRQs, true, but then it will re=
turn
>>>> NULL. The user of ipipe_get_irq_regs has to take this into account. =
And
>>>> most consumers will be wired IRQ handler anyway.
>>>>
>>>>> You have to resort to __ipipe_tick_regs, and obviously only use thi=
s in
>>>>> the context of a timer-triggered code, like the watchdog handler, w=
hich
>>>>> saves your day.
>>>> Doesn't work if the timer IRQ is not the host tick AND doesn't help =
us
>>>> modifying the return path.
>>> That is not the basic issue, copying back regs->ip to the actual fram=
e
>>> before yielding to the IRQ trampoline code would be trivial and your
>>> patch does require a deeper change in the ipipe already. The issue is=
:
>>> do not provide a service which is not 100% trustable in this area.
>> There is no use for ipipe_get_irq_regs in our case outside the call
>> stack of the triggering IRQ. If you have nested IRQs inside this stack=
,
>> ipipe_get_irq_regs account for this, if you leave the stack, it return=
s
>> NULL. This is 100% reliable.
>=20
> Try calling ipipe_get_irq_regs within a root domain IRQ handler, then,
> we'll resume this discussion right after - you may have another
> perception of the situation. You will get NULL once in a while, albeit
> you are running over an IRQ context, from a Linux POV.
>=20
> 100% reliable for a published ipipe interface means that it ought to
> work when called from _all_ domains, unless its semantics specifically
> dictates a particular context for use. By no mean ipipe_get_irq_regs
> tells anyone that it may only be used reliably on behalf of an unlocked=
,
> wired, directly dispatched IRQ.
>=20
> The only IRQ that fits this description is the pipelined hrtimer irq
> (not even the host one, the host one simply inherits this property when=

> it happens that hrtimer =3D=3D host timer for the underlying architectu=
re),
> and the only domain which may assume this safely is the invariant head,=

> which certainly restricts quite a bit the valid context for using those=

> services.
>=20
>> If you want read-only access to the preempted register set, then we ne=
ed
>> some other mechanism, something like the tick regs. But those already
>> exits, and we have no other users beyond the host tick so far.
>=20
> I agree, we do need something to ALLOWS US fixup the frame for the
> return address to be correct. I'm just asking that we do provide a clea=
n
> interface for this, since it will be there to stay.=20

Ack. I'm already looking into some way to pimp up ipipe_get_irq_regs so
that it can replace the x86 tick_regs and will never be NULL inside an
IRQ handler. The only thing that is missing is filling in the proper
context that unblocked some pipeline and triggers an IRQ replay this
way. Should be fairly simple.

Jan


--------------enig5C9269250578A41B6F8FC883
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkwHix0ACgkQitSsb3rl5xTmTACg2hqv1tC8EJ/WbITwPzY/GPDN
fjMAoIV9Je2fpVr+ImjdmqXiPWPW1Ed5
=aYuc
-----END PGP SIGNATURE-----

--------------enig5C9269250578A41B6F8FC883--


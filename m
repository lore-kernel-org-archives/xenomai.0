Message-ID: <4CC5FAE6.6010305@domain.hid>
Date: Mon, 25 Oct 2010 23:47:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20101007115728.GA24500@domain.hid>	
	<4CADBDC2.8080600@domain.hid>
	<20101008070148.GB2255@domain.hid>	
	<1286530884.13186.109.camel@domain.hid>	
	<20101013090353.GA6902@domain.hid>	
	<1286961375.1759.71.camel@domain.hid>	
	<20101013092617.GB6902@domain.hid>	
	<1286981521.1759.83.camel@domain.hid>	
	<1288025329.26618.132.camel@domain.hid> <4CC5C80E.2070004@domain.hid>	
	<1288033731.26618.161.camel@domain.hid> <4CC5D742.9080307@domain.hid>	
	<1288034435.26618.164.camel@domain.hid> <4CC5D8FF.5080109@domain.hid>	
	<1288041166.26618.182.camel@domain.hid> <4CC5F525.7040206@domain.hid>
	<1288042858.26618.204.camel@domain.hid>
In-Reply-To: <1288042858.26618.204.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3DBB099791598A77CA2DD89B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] kernel oopses when killing realtime task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3DBB099791598A77CA2DD89B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 25.10.2010 23:40, Philippe Gerum wrote:
> On Mon, 2010-10-25 at 23:22 +0200, Jan Kiszka wrote:
>> Am 25.10.2010 23:12, Philippe Gerum wrote:
>>> On Mon, 2010-10-25 at 21:22 +0200, Jan Kiszka wrote:
>>>> Am 25.10.2010 21:20, Philippe Gerum wrote:
>>>>> On Mon, 2010-10-25 at 21:15 +0200, Jan Kiszka wrote:
>>>>>> Am 25.10.2010 21:08, Philippe Gerum wrote:
>>>>>>> On Mon, 2010-10-25 at 20:10 +0200, Jan Kiszka wrote:
>>>>>>>> Am 25.10.2010 18:48, Philippe Gerum wrote:
>>>>>>>>> On Wed, 2010-10-13 at 16:52 +0200, Philippe Gerum wrote:=20
>>>>>>>>>>>
>>>>>>>>>>> Should we test IPIPE_STALL_FLAG on all but current CPUs?
>>>>>>>>>>
>>>>>>>>>> That would solve this particular issue, but we should drain th=
e pipeline
>>>>>>>>>> out of any Xenomai critical section. The way it is done now ma=
y induce a
>>>>>>>>>> deadlock (e.g. CPU0 waiting for CPU1 to acknowledge critical e=
ntry in
>>>>>>>>>> ipipe_enter_critical when getting some IPI, and CPU1 waiting h=
w IRQs off
>>>>>>>>>> for CPU0 to release the Xenomai lock that annoys us right now)=
=2E
>>>>>>>>>>
>>>>>>>>>> I'll come up with something hopefully better and tested in the=
 next
>>>>>>>>>> days.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Sorry for the lag. In case that helps, here is another approach=
, based
>>>>>>>>> on telling the pipeline to ignore the irq about to be detached,=
 so that
>>>>>>>>> it passes all further occurrences down to the next domain, with=
out
>>>>>>>>
>>>>>>>> Err, won't this irritate that next domain, ie. won't Linux dump =
warnings
>>>>>>>> about a spurious/unhandled IRQ? I think either the old handler s=
hall
>>>>>>>> receive the last event or no one.
>>>>>>>
>>>>>>> Flipping the IRQ modes within a ipipe_critical_enter/exit section=
 gives
>>>>>>> you that guarantee. You are supposed to have disabled the irq lin=
e
>>>>>>> before detaching, and critical IPIs cannot be acknowledged until =
all
>>>>>>> CPUs have re-enabled interrupts at some point. Therefore, there a=
re only
>>>>>>> two scenarii:
>>>>>>>
>>>>>>> - irq was disabled before delivery, and a pending interrupt is ma=
sked by
>>>>>>> the PIC and never delivered to the CPU.
>>>>>>>
>>>>>>> - an interrupt sneaked in before disabling, it is currently proce=
ssed by
>>>>>>> the pipeline in the low handler on some CPU, in which case interr=
upts
>>>>>>> are off, so a critical IPI could be acked yet, and the irq mode b=
its
>>>>>>> still allow dispatching to the target domain on that CPU. The ass=
umption
>>>>>>> which is happily made is that only head domains are interested in=

>>>>>>> un-virtualizing irqs, so the dispatch will happen immediately, wh=
ile the
>>>>>>> handler is still valid (actually, we are not allowed to un-virtua=
lize
>>>>>>> root irqs, and intermediate Adeos domains are already considered =
as
>>>>>>> endangered species, so this is fine).
>>>>>>>
>>>>>>>>
>>>>>>>> Why this complex solution, why not simply draining (via critical=
_enter
>>>>>>>> or whatever) - but _after_ xnintr_irq_detach, ie. while the rela=
ted
>>>>>>>> resources are still valid?
>>>>>>>>
>>>>>>>
>>>>>>> Because it's already too late. You have cleared the handler point=
er when
>>>>>>> un-virtualizing via xnarch_release_irq, and the wired irq dispatc=
her or
>>>>>>> the log syncer on another CPU could then branch to eip $0.
>>>>>>
>>>>>> Just make ipipe_virtualize_irq install a nop handler instead of NU=
LL.
>>>>>
>>>>> This does not solve the issue of the last interrupt which should be=

>>>>> processed. You don't want to miss it.
>>>>
>>>> Don't understand. No interrupt is supposed to arrive anymore on
>>>> deregistration, the last user is supposed to be down by now. We just=

>>>> need to catch though that slipped through.
>>>
>>> No, we are handling the case when an interrupt is currently handled o=
n a
>>> CPU which is not the one that unregisters the IRQ, and which managed =
to
>>> sneak in while the irq source was about to be masked in the PIC. This=
 is
>>> purely asynchronous for us in SMP, since we don't have irq descriptor=

>>> locks for the pipeline, we only have them at Xenomai level, which is =
one
>>> step too far to protected our low level Adeos handler against that ki=
nd
>>> of race. Logically speaking, there is no reason why you would accept =
to
>>> leave that irq unhandled if it is there and known from a CPU (it was
>>> actually the first point you raised).
>>
>> If that handler is already running, the IRQ will get handled, we just
>> need to wait for the handler to finish after we returned from
>> ipipe_virtualize_irq =3D> thus we need a barrier here.
>>
>=20
> So, we let ipipe_virtualize_irq clear the handler pointer any remote CP=
U
> could use in parallel, and we...synchronize on the outcome? The notion
> of "handler" may explain why we don't sync yet: I'm not taking about th=
e
> Xenomai entry for interrupts, I'm dealing with interrupts in the early
> code of ipipe_handle_irq, before you hit the wired irq dispatcher or th=
e
> sync_stage loop.=20

/me too.

>=20
>> If the handler was about to run but we deregistered it a bit quicker,
>> the IRQ need not be addressed at device level anymore. Reason: we
>> already switched off any IRQ assertions in the device before we entere=
d
>> ipipe_virtualize_irq. So no harm is caused, that IRQ line is deasserte=
d
>> already (IOW: the IRQ became a spurious one while cleaning up).
>=20
> You can attempt to disable the irq line on one CPU, and have a relevant=

> irq entering the low level pipeline handler on another one at exactly
> the same time. We have _no_ sync here.

That is not the problem here. I'm not talking about the line, I'm
talking now about the device that drives it. Silencing the IRQ there is
important, but is async /wrt to other cores and needs a barrier.

Actually, playing with the IRQ line is no driver business anyway (except
for very few special cases).


>=20
>>
>>>
>>> The proper way to fix this issue would have been to fix xnintr_detach=
 in
>>> the first place, because calling ipipe_virtualize_irq() while holding=
 a
>>> lock with irqs off is wrong. We could have then drained the pipeline
>>> from the unregistering code. I'm rather going for a decent solution
>>> which is not prone to regression for 2.x.
>>>
>>
>> Again, I see no reason for a more complex solution than avoiding that
>> NULL pointer dereference at ipipe level as I suggested and adding a ve=
ry
>> simply system wide barrier right after dropping nklock in xnintr_detac=
h.
>>
>=20
> You cannot drop that lock without rewriting the xnintr layer in rather
> touchy areas, that is the point.

I meant intrlock - we do not call xnintr_detach with nklock acquired
(your pre-detach synch would not work as well if we did).

Jan


--------------enig3DBB099791598A77CA2DD89B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzF+uYACgkQitSsb3rl5xTtsgCgpvqlVjOH5LLdMM2vQAVfPwVJ
J6IAn1rvZHN3jusYC8V9JeVg1HKW88n5
=46jx
-----END PGP SIGNATURE-----

--------------enig3DBB099791598A77CA2DD89B--


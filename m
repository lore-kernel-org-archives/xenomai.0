Message-ID: <4CC665A1.9040707@domain.hid>
Date: Tue, 26 Oct 2010 07:22:41 +0200
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
	<1288042858.26618.204.camel@domain.hid> <4CC5FAE6.6010305@domain.hid>
	<1288068231.26618.224.camel@domain.hid>
In-Reply-To: <1288068231.26618.224.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1FBEA5A2677ED89A56E194B2"
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
--------------enig1FBEA5A2677ED89A56E194B2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 26.10.2010 06:43, Philippe Gerum wrote:
> On Mon, 2010-10-25 at 23:47 +0200, Jan Kiszka wrote:
>> Am 25.10.2010 23:40, Philippe Gerum wrote:
>>> On Mon, 2010-10-25 at 23:22 +0200, Jan Kiszka wrote:
>>>> Am 25.10.2010 23:12, Philippe Gerum wrote:
>>>>> On Mon, 2010-10-25 at 21:22 +0200, Jan Kiszka wrote:
>>>>>> Am 25.10.2010 21:20, Philippe Gerum wrote:
>>>>>>> On Mon, 2010-10-25 at 21:15 +0200, Jan Kiszka wrote:
>>>>>>>> Am 25.10.2010 21:08, Philippe Gerum wrote:
>>>>>>>>> On Mon, 2010-10-25 at 20:10 +0200, Jan Kiszka wrote:
>>>>>>>>>> Am 25.10.2010 18:48, Philippe Gerum wrote:
>>>>>>>>>>> On Wed, 2010-10-13 at 16:52 +0200, Philippe Gerum wrote:=20
>>>>>>>>>>>>>
>>>>>>>>>>>>> Should we test IPIPE_STALL_FLAG on all but current CPUs?
>>>>>>>>>>>>
>>>>>>>>>>>> That would solve this particular issue, but we should drain =
the pipeline
>>>>>>>>>>>> out of any Xenomai critical section. The way it is done now =
may induce a
>>>>>>>>>>>> deadlock (e.g. CPU0 waiting for CPU1 to acknowledge critical=
 entry in
>>>>>>>>>>>> ipipe_enter_critical when getting some IPI, and CPU1 waiting=
 hw IRQs off
>>>>>>>>>>>> for CPU0 to release the Xenomai lock that annoys us right no=
w).
>>>>>>>>>>>>
>>>>>>>>>>>> I'll come up with something hopefully better and tested in t=
he next
>>>>>>>>>>>> days.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Sorry for the lag. In case that helps, here is another approa=
ch, based
>>>>>>>>>>> on telling the pipeline to ignore the irq about to be detache=
d, so that
>>>>>>>>>>> it passes all further occurrences down to the next domain, wi=
thout
>>>>>>>>>>
>>>>>>>>>> Err, won't this irritate that next domain, ie. won't Linux dum=
p warnings
>>>>>>>>>> about a spurious/unhandled IRQ? I think either the old handler=
 shall
>>>>>>>>>> receive the last event or no one.
>>>>>>>>>
>>>>>>>>> Flipping the IRQ modes within a ipipe_critical_enter/exit secti=
on gives
>>>>>>>>> you that guarantee. You are supposed to have disabled the irq l=
ine
>>>>>>>>> before detaching, and critical IPIs cannot be acknowledged unti=
l all
>>>>>>>>> CPUs have re-enabled interrupts at some point. Therefore, there=
 are only
>>>>>>>>> two scenarii:
>>>>>>>>>
>>>>>>>>> - irq was disabled before delivery, and a pending interrupt is =
masked by
>>>>>>>>> the PIC and never delivered to the CPU.
>>>>>>>>>
>>>>>>>>> - an interrupt sneaked in before disabling, it is currently pro=
cessed by
>>>>>>>>> the pipeline in the low handler on some CPU, in which case inte=
rrupts
>>>>>>>>> are off, so a critical IPI could be acked yet, and the irq mode=
 bits
>>>>>>>>> still allow dispatching to the target domain on that CPU. The a=
ssumption
>>>>>>>>> which is happily made is that only head domains are interested =
in
>>>>>>>>> un-virtualizing irqs, so the dispatch will happen immediately, =
while the
>>>>>>>>> handler is still valid (actually, we are not allowed to un-virt=
ualize
>>>>>>>>> root irqs, and intermediate Adeos domains are already considere=
d as
>>>>>>>>> endangered species, so this is fine).
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Why this complex solution, why not simply draining (via critic=
al_enter
>>>>>>>>>> or whatever) - but _after_ xnintr_irq_detach, ie. while the re=
lated
>>>>>>>>>> resources are still valid?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Because it's already too late. You have cleared the handler poi=
nter when
>>>>>>>>> un-virtualizing via xnarch_release_irq, and the wired irq dispa=
tcher or
>>>>>>>>> the log syncer on another CPU could then branch to eip $0.
>>>>>>>>
>>>>>>>> Just make ipipe_virtualize_irq install a nop handler instead of =
NULL.
>>>>>>>
>>>>>>> This does not solve the issue of the last interrupt which should =
be
>>>>>>> processed. You don't want to miss it.
>>>>>>
>>>>>> Don't understand. No interrupt is supposed to arrive anymore on
>>>>>> deregistration, the last user is supposed to be down by now. We ju=
st
>>>>>> need to catch though that slipped through.
>>>>>
>>>>> No, we are handling the case when an interrupt is currently handled=
 on a
>>>>> CPU which is not the one that unregisters the IRQ, and which manage=
d to
>>>>> sneak in while the irq source was about to be masked in the PIC. Th=
is is
>>>>> purely asynchronous for us in SMP, since we don't have irq descript=
or
>>>>> locks for the pipeline, we only have them at Xenomai level, which i=
s one
>>>>> step too far to protected our low level Adeos handler against that =
kind
>>>>> of race. Logically speaking, there is no reason why you would accep=
t to
>>>>> leave that irq unhandled if it is there and known from a CPU (it wa=
s
>>>>> actually the first point you raised).
>>>>
>>>> If that handler is already running, the IRQ will get handled, we jus=
t
>>>> need to wait for the handler to finish after we returned from
>>>> ipipe_virtualize_irq =3D> thus we need a barrier here.
>>>>
>>>
>>> So, we let ipipe_virtualize_irq clear the handler pointer any remote =
CPU
>>> could use in parallel, and we...synchronize on the outcome? The notio=
n
>>> of "handler" may explain why we don't sync yet: I'm not taking about =
the
>>> Xenomai entry for interrupts, I'm dealing with interrupts in the earl=
y
>>> code of ipipe_handle_irq, before you hit the wired irq dispatcher or =
the
>>> sync_stage loop.=20
>>
>> /me too.
>>
>>>
>>>> If the handler was about to run but we deregistered it a bit quicker=
,
>>>> the IRQ need not be addressed at device level anymore. Reason: we
>>>> already switched off any IRQ assertions in the device before we ente=
red
>>>> ipipe_virtualize_irq. So no harm is caused, that IRQ line is deasser=
ted
>>>> already (IOW: the IRQ became a spurious one while cleaning up).
>>>
>>> You can attempt to disable the irq line on one CPU, and have a releva=
nt
>>> irq entering the low level pipeline handler on another one at exactly=

>>> the same time. We have _no_ sync here.
>>
>> That is not the problem here. I'm not talking about the line, I'm
>> talking now about the device that drives it. Silencing the IRQ there i=
s
>> important, but is async /wrt to other cores and needs a barrier.
>>
>> Actually, playing with the IRQ line is no driver business anyway (exce=
pt
>> for very few special cases).
>=20
> It seems we are rehashing the same thing using different words: we have=

> a lingering interrupt, we have nothing to synchronize the
> disable-drain-unregister sequence with respect to dispatching that
> interrupt, and this code adds the missing bits. There is nothing comple=
x
> or overkill compared to the constraints we have in xnintr. So let's mov=
e
> on.
>=20
>>
>>
>>>
>>>>
>>>>>
>>>>> The proper way to fix this issue would have been to fix xnintr_deta=
ch in
>>>>> the first place, because calling ipipe_virtualize_irq() while holdi=
ng a
>>>>> lock with irqs off is wrong. We could have then drained the pipelin=
e
>>>>> from the unregistering code. I'm rather going for a decent solution=

>>>>> which is not prone to regression for 2.x.
>>>>>
>>>>
>>>> Again, I see no reason for a more complex solution than avoiding tha=
t
>>>> NULL pointer dereference at ipipe level as I suggested and adding a =
very
>>>> simply system wide barrier right after dropping nklock in xnintr_det=
ach.
>>>>
>>>
>>> You cannot drop that lock without rewriting the xnintr layer in rathe=
r
>>> touchy areas, that is the point.
>>
>> I meant intrlock - we do not call xnintr_detach with nklock acquired
>> (your pre-detach synch would not work as well if we did).
>=20
> nklock has never been in the picture, no need to bring it in. If you
> drop intrlock across the release, you will end up with a race between
> attach and detach, and you may well unvirtualize the irq which was in
> the process of being attached from another CPU. That is part of the
> "touchy areas" I was mentioning lately. xnintr locking is entangled and=

> assumes that unvirtualizing irq while holding a lock is fine, which is
> not. We have to live with it for now, and go for the solution with the
> smaller potential for regression. I will obviously welcome any update t=
o
> xnintr which would alleviate those contraints, but rather aimed at
> -forge, not 2.x.

Will come up with two patches for stable, one for I-pipe and one for
Xenomai, later today. Then we can discuss which cases I'm missing.

Jan


--------------enig1FBEA5A2677ED89A56E194B2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzGZaEACgkQitSsb3rl5xRj0wCcCy3EsgzfjxnLAkJYFrXrOQ5t
eTgAmweKfR7f31kRi0pyM7/Eg1JG4yRg
=f7s7
-----END PGP SIGNATURE-----

--------------enig1FBEA5A2677ED89A56E194B2--


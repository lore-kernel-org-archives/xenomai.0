Message-ID: <4CDD8AA1.4060407@domain.hid>
Date: Fri, 12 Nov 2010 19:42:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20101007115728.GA24500@domain.hid>	
	<1288025329.26618.132.camel@domain.hid> <4CC5C80E.2070004@domain.hid>	
	<1288033731.26618.161.camel@domain.hid> <4CC5D742.9080307@domain.hid>	
	<1288034435.26618.164.camel@domain.hid> <4CC5D8FF.5080109@domain.hid>	
	<1288041166.26618.182.camel@domain.hid> <4CC5F525.7040206@domain.hid>	
	<1288042858.26618.204.camel@domain.hid> <4CC5FAE6.6010305@domain.hid>	
	<1288068231.26618.224.camel@domain.hid>
	<4CC665A1.9040707@domain.hid>	 <4CC72D27.3010607@domain.hid>
	<1288243034.1816.14.camel@domain.hid>	 <4CC926BE.7040105@domain.hid>
	<1288251968.1816.22.camel@domain.hid>	
	<1289142959.1842.295.camel@domain.hid> <4CD6D22C.2030708@domain.hid>	
	<4CD8FFC4.5040202@domain.hid> <1289291217.1957.16.camel@domain.hid shift>	
	<4CD908AD.9000202@domain.hid> <1289295412.1957.32.camel@domain.hid>	
	<4CD948BB.4040201@domain.hid> <1289551711.1937.108.camel@domain.hid>	
	<4CDD055C.6040103@domain.hid> <1289570246.1937.422.camel@domain.hid>	
	<4CDD4F85.6030009@domain.hid> <1289583759.1937.517.camel@domain.hid>
In-Reply-To: <1289583759.1937.517.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA000A0C24A9EBE744F8A509C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] kernel oopses when killing realtime task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA000A0C24A9EBE744F8A509C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 12.11.2010 18:42, Philippe Gerum wrote:
> On Fri, 2010-11-12 at 15:30 +0100, Jan Kiszka wrote:=20
>> Am 12.11.2010 14:57, Philippe Gerum wrote:
>>> On Fri, 2010-11-12 at 10:14 +0100, Jan Kiszka wrote:
>>>> Am 12.11.2010 09:48, Philippe Gerum wrote:
>>>>> On Tue, 2010-11-09 at 14:12 +0100, Jan Kiszka wrote:
>>>>>> Am 09.11.2010 10:36, Philippe Gerum wrote:
>>>>>>> On Tue, 2010-11-09 at 09:39 +0100, Jan Kiszka wrote:
>>>>>>>> Am 09.11.2010 09:26, Philippe Gerum wrote:
>>>>>>>>> On Tue, 2010-11-09 at 09:01 +0100, Jan Kiszka wrote:
>>>>>>>>>> Am 07.11.2010 17:22, Jan Kiszka wrote:
>>>>>>>>>>> Am 07.11.2010 16:15, Philippe Gerum wrote:
>>>>>>>>>>>> The following patches implements the teardown approach. The =
basic idea
>>>>>>>>>>>> is:
>>>>>>>>>>>> - neither break nor improve old setups with legacy I-pipe pa=
tches not
>>>>>>>>>>>> providing the revised ipipe_control_irq call.
>>>>>>>>>>>> - fix the SMP race when detaching interrupts.
>>>>>>>>>>>
>>>>>>>>>>> Looks good.
>>>>>>>>>>
>>>>>>>>>> This actually causes one regression: I've just learned that pe=
ople are
>>>>>>>>>> already happily using MSIs with Xenomai in the field. This is =
perfectly
>>>>>>>>>> fine as long as you don't fiddle with rtdm_irq_disable/enable =
in
>>>>>>>>>> non-root contexts or while hard IRQs are disable. The latter r=
equirement
>>>>>>>>>> would be violated by this fix now.
>>>>>>>>>
>>>>>>>>> What we could do is handle this corner-case in the ipipe direct=
ly, going
>>>>>>>>> for a nop when IRQs are off on a per-arch basis only to please =
those
>>>>>>>>> users,
>>>>>>>>
>>>>>>>> Don't we disable hard IRQs also then the root domain is the only=

>>>>>>>> registered one? I'm worried about pushing regressions around, th=
en to
>>>>>>>> plain Linux use-cases of MSI (which are not broken in anyway - e=
xcept
>>>>>>>> for powerpc).
>>>>>>>
>>>>>>> The idea is to provide an ad hoc ipipe service for this, to be us=
ed by
>>>>>>> the HAL. A service that would check the controller for the target=
 IRQ,
>>>>>>> and handle MSI ones conditionally. For sure, we just can't put th=
ose
>>>>>>> conditionally bluntly into the chip mask handler and expect the k=
ernel
>>>>>>> to be happy.
>>>>>>>
>>>>>>> In fact, we already have __ipipe_enable/disable_irq from the inte=
rnal
>>>>>>> Adeos interface avail, but they are mostly wrappers for now. We c=
ould
>>>>>>> make them a bit more smart, and handle the MSI issue as well. We =
would
>>>>>>> then tell the HAL to switch to using those arch-agnostic helpers
>>>>>>> generally, instead of peeking directly into the chip controller s=
tructs
>>>>>>> like today.
>>>>>>
>>>>>> This belongs to I-pipe, like we already have ipipe_end, just prope=
rly
>>>>>> wrapped to avoid descriptor access. That's specifically important =
if we
>>>>>> want to emulate MSI masking in software. I've the generic I-pipe
>>>>>> infrastructure ready, but the backend, so far consisting of x86 MS=
I
>>>>>> hardening, unfortunately needs to be rewritten.
>>>>>>
>>>>>>>
>>>>>>> If that ipipe "feature" is not detected by the HAL, then we would=

>>>>>>> refrain from disabling the IRQ in xnintr_detach. In effect, this =
would
>>>>>>> leave the SMP race window open, but since we need recent ipipes t=
o get
>>>>>>> it plugged already anyway (for the revised ipipe_control_irq), we=
 would
>>>>>>> still remain in the current situation:
>>>>>>> - old patches? no SMP race fix, no regression
>>>>>>> - new patches? SMP race fix avail, no regression
>>>>>>
>>>>>> Sounds good.
>>>>>
>>>>> Now that I slept on it, I find the approach of working around pipel=
ine
>>>>> limitations this way, to be incorrect.
>>>>>
>>>>> Basically, the issue is that we still don't have 100% reliable hand=
ling
>>>>> of MSI interrupts (actually, we only have partial handling, and sol=
ely
>>>>> for x86), but this is no reason to introduce code in the pipeline
>>>>> interface which would perpetuate this fact. I see this as a "all or=

>>>>> nothing" issue: either MSI is fully handled and there shall be no
>>>>> restriction on applying common operations such as masking/unmasking=
 on
>>>>> the related IRQs, or it is not, and we should not export "condition=
ally
>>>>> working" APIs.
>>>>>
>>>>> In the latter case, the responsibility to rely on MSI support belon=
gs to
>>>>> the user, which then should know about the pending restrictions, an=
d
>>>>> decides for himself whether to use MSI. So I'm heading to this solu=
tion
>>>>> instead:
>>>>>
>>>>> - when detaching the last handler for a given IRQ, instead of forci=
bly
>>>>> disabling the IRQ line, the nucleus would just make sure that such =
IRQ
>>>>> is already in a disabled state, and bail out on error if not (proba=
bly
>>>>> with a kernel warning to make the issue obvious).
>>>>
>>>> Fiddling with the IRQ "line" state is a workaround for the missing
>>>> synchronize_irq service in Xenomai/I-pipe. If we had this, all this
>>>> disabling become unneeded.
>>>
>>> Actually, no. The synchronize irq service in the pipeline could have
>>> been introduced weeks ago in a snap, provided Xenomai did not call
>>> ipipe_virtualize_irq holding a lock with irqs off - this is in essenc=
e
>>> what my first patch to Pavel did, but could not work for the reason
>>> mentioned. That is what the patch we are discussing now is all about:=

>>> clearing issues in Xenomai first.
>>>
>>> Additionally, having an IRQ disabled is a requirement to properly
>>> synchronize that IRQ later, it is not an option. It is part of the sy=
nc
>>> protocol actually. If you don't do this, it lacks a basic guarantee, =
it
>>> can't work.
>>
>> The required pattern from driver POV is
>>  - disable IRQ at device level
>>  - flush pending IRQs
>>  - deregister handler
>>
>> Linux does the last two steps in reverse order as it synchronizes
>> descriptor changes against descriptor usage internally. I-pipe require=
s
>> the above ordering (unless my patch is used to harden
>> ipipe_virtualize_irq against NULL handlers). Still, the driver should
>> find step 2 and 3 as part of rtdm_irq_free. That's all.
>>
>=20
> It looks like you are omitting the disable IRQ line step which free_irq=

> does when no more handler is attached to the line. You don't seem to
> take into account that pipeline-wise, synchronizing an IRQ upon shutdow=
n
> requires to mask it first at PIC level, either.

Disabling at IRQ controller level is a step which is not conceptually
required to perform a safe shutdown. It is likely applied to suppress
spurious IRQs due to buggy hardware.

>=20
>> Jan=20
>>>
>>>>
>>>>>
>>>>> - track the IRQ line state from xnintr_enable/xnintr_disable routin=
es,
>>>>> so that xnintr_detach can determine whether the call is legit. Of
>>>>> course, this also means that any attempt to take sideways to
>>>>> enable/disable nucleus managed interrupts at PIC level would break =
that
>>>>> logic, but doing so would be the root bug anyway.
>>>>>
>>>>> The advantage of doing so would be three-fold:
>>>>>
>>>>> - no pipeline code to acknowledge (or even perpetuate) the fact tha=
t MSI
>>>>> support is half working, half broken. We need to fix it properly, s=
o
>>>>> that we can use it 100% reliably, from whatever context commonly al=
lowed
>>>>> for enabling/disabling IRQs (and not "from root domain with IRQs on=
"
>>>>> only). Typically, I fail to see how one would cope with such limita=
tion,
>>>>> if a real-time handler detects that some device is going wild and r=
eally
>>>>> needs to shut it down before the whole system crashes.
>>>>
>>>> MSIs are edge-triggered. Only broken hardware continuously sending b=
ogus
>>>> messages can theoretically cause troubles. In practice (ie. in absen=
ce
>>>> of broken HW), we see a single spurious IRQ at worst.
>>>>
>>>
>>> The driver should be able to work the same way whether it deals with =
MSI
>>> support, or is given pinned (level) IRQs.
>>
>> Exactly my point, thus rtdm_irq_disable in driver code is a no-go.
>>
>=20
> Since you don't have such things as shared MSIs, the only issue is with=

> non-shared handling. And disabling the interrupt line for a non-shared
> handler which is being deregistered makes sense, in all cases, MSI or
> not. The fact that MSI support is broken today for us does not mean tha=
t
> we should design a broken xnintr_detach API to cope with that -
> hopefully temporary - limitation. So, xnarch_disable_irq in
> xnintr_detach is obviously correct, even if we currently have to refrai=
n
> from doing this for non-shared handlers because of MSI.

It is not incorrect, but it must not be mandatory for proper shutdown.

>=20
>>>
>>>>>
>>>>> - we enforce the API usage requirement to disable an interrupt line=
 with
>>>>> rtdm_irq_disable(), before eventually detaching the last IRQ handle=
r for
>>>>> it, which is common sense anyway.
>>>>
>>>> That's an easy-to-get-wrong API. It would apply to non-shared IRQs o=
nly
>>>> (aka MSIs). No-go IMHO.
>>>
>>> - the software does not want to share MSIs, or something is quite wro=
ng
>>> - xnintr_detach() is broken by design in its current implementation f=
or
>>> shared handlers, because it leaves the decision to mask the IRQ line =
to
>>> the user. This could not work for multiple non-cooperating drivers
>>> sharing an IRQ, at least not in a raceless way.
>>
>> It works (minus the missing synchronize_irq) if you disable the IRQ at=

>> device level as drivers normally do.
>=20
> synchronize_irq without prior IRQ disabling does not work for the
> pipeline. So relying on synchronize_irq to only mask at device level
> without disabling the IRQ line just does not work.

It is not implemented, but it is not impossible. It takes
synchronization on hard IRQ context exits on all CPUs and waiting on
deassertion of any pending bit for that IRQ in question. That is surely
implementable if we wanted to.

>=20
>>>
>>> So the issue is not that much about MSI vs pinned-type IRQs, it is
>>> rather about shared vs non-shared interrupts. What we want is a sane =
API
>>> and behavior for both types, which happens to fit the limited support=
 we
>>> have now for MSI, not the other way around.
>>>
>>> Therefore, until the MSI issue is fixed in the pipeline:
>>>
>>> - non-shared mode users should call xnintr_disable(irq) then
>>> xnintr_detach(irq) explicitly. This is what everybody should do today=

>>> already (via rtdm_irq_disable() or whatever), since xnintr_detach() d=
oes
>>> not disable the IRQ in the current implementation.
>>
>> No one should call rtdm_irq_disable today for whatever IRQ unless in
>> very few exceptional cases. I think I should extend the documentation =
of
>> rtdm_irq_enabled/disable ASAP to clarify their exceptional nature.
>>
>=20
> rtdm_irq_enable() is required to startup the IRQ line, since Xenomai
> leaves interrupts in a disabled state at descriptor init time, so this
> one is hardly exceptionally used.

Nope it isn't. That's rtdm_irq_request business for quite a while now -
for a good reason: to avoid that driver writers introduce bugs by
calling rtdm_irq_disable on shutdown.

>=20
> rtdm_irq_disable() should be seldomly used indeed, provided the MSI
> support is fixed. Until then, xnintr_detach won't be allowed to disable=

> non-shared interrupts. But if you discourage disabling IRQs in general
> before detaching them, then you basically tell people that their driver=

> should not expect the system to help them in any way for synchronizing
> IRQs, and this is something I disagree with.

Driver writers should not bother about internals of Xenomai here.
rtdm_irq_disable before rtdm_irq_free is not required and should not
show up in properly written drivers. If that's not true today or after
upcoming fixes, Xenomai needs to be fixed.

>=20
>>>
>>> - shared mode users should only call xnintr_detach(irq), which would
>>> then decide racelessly whether to disable the line. In essence, this
>>> could never affect MSIs.
>>>
>>> When the MSI support is generally available with no limitation on
>>> masking/unmasking contexts, then xnintr_detach() could be updated to
>>> forcibly disable the detached IRQ in the non-shared case as well. At
>>> worst, the legacy code would end up calling xnintr_disable() uselessl=
y
>>> when the pipeline fix is merged.
>>>
>>> What we can do in the meantime, is 1) fixing xnintr_detach() in the
>>> shared case, 2) introducing an error check to prevent detaching
>>> non-shared IRQs that are still enabled. That won't have any impact on=

>>> the partial MSI support we have today.
>>>
>>>>
>>>>>
>>>>> - absolutely no change for people who currently rely on partial MSI=

>>>>> support, provided they duly disable IRQ lines before detaching thei=
r
>>>>> last handler via the appropriate RTDM interface.
>>>>>
>>>>> Can we deal on this?
>>>>>
>>>>
>>>> Nope, don't think so. The only option I see (besides using my origin=
al
>>>> proposal of a dummy handler for deregistering - still much simpler t=
han
>>>> the current patches) is to emulate MSI masking in the same run, thus=

>>>> providing solutions for both issues.
>>>
>>> The dummy handler solution is incomplete because it does not address =
the
>>> IRQ disabling issue in xnintr_detach() for shared IRQs. This is the g=
ist
>>> of the patch I sent, actually.
>>
>> It is complete in this regard as it does not touch the line state. It
>> actually implements the Linux pattern.
>>
>=20
> The linux pattern in free_irq(), which is semantically equivalent of
> xnintr_detach() for us does include IRQ disabling when the last handler=

> is detached. Introducing the dummy handler looks a bit like papering
> over the issue, so that weakly synchronized xnintr_detach() might be
> sufficient. I don't agree there.

Linux disables the line after removing the handler. Disabling has no
effect on ongoing interrupts that are about to pick up the action
handler. The key is: Linux does not crash on NULL action. So the dummy
handler is the same thing, just without a spinlock and a conditional bran=
ch.

>=20
>>
>>>
>>> Besides, I'm still scratching my head: how would introducing a dummy
>>> handler help dealing with that sequence?
>>>
>>> CPU0					CPU1
>>>
>>> xnintr_disable =3D> mask irq		<irq>
>>
>> No disable here, mask must be at device level
>> .
>>
>>> xnintr_detach				real-time handler
>>> 	<install dummy handler>			<touch device>
>>> 					ipipe_end_irq() =3D> unmask irq
>>
>> xnarch_synchronize_irq
>>
>=20
> No, it is too late. It assumes the driver could somehow prevent CPU1
> from touching the device before the dummy handler could be installed by=

> ipipe_virtualize_irq. But synchronizing and releasing a pipelined IRQ
> must be done in that order, and all locks dropped, with interrupts
> enabled on CPU0. I can't see how just replacing mask_irq by mask_device=

> would work any better, and prevent CPU0 from receiving an unexpected IR=
Q
> from the device it is supposed to have disabled a few instructions
> before. This is where disabling the IRQ comes into play, /me think.

Receiving that IRQ is not an issue at all. It is for us as the pipeline
crashes. Linux swallows it, and after synchronize_irq, there is no more
risk that the deregistered handler could still be in use.

>=20
>>>
>>> Then, on whichever CPU, we could receive a device IRQ as we touched t=
he
>>> hardware before leaving the handler, passing that IRQ to the root dom=
ain
>>> which has no proper handler for it:
>>>
>>> - lucky scenario: the device is in a state that won't cause it to kic=
k
>>> yet another interrupt even if the last one was not serviced, and we j=
ust
>>> end up with a nifty spurious IRQ message in the kernel log.
>>>
>>> - out of luck: we touched the device on CPU1 in a way that claims for=
 a
>>> specific action by the software, which won't be able to perform it
>>> because it is now branching to the dummy handler. Whether we have som=
e
>>> code to silence the device (and not only the IRQ line) before or afte=
r
>>> we detach the IRQ on CPU0 does not fix the issue, since we have no
>>> synchronization between the CPUs whatsoever.
>>>
>>
>> The driver is responsible for synchronizing its shutdown sequence
>> between the cleanup code and any of its in-flight IRQs. If that handle=
r
>> reenables the IRQ that the shutdown code just disabled (all at device
>> level, of course), something is seriously broken - but not on Xenomai
>> side. As I explained before: That potential in-flight IRQ becomes
>> spurious at the point the drivers starts the shutdown, thus can safely=

>> be ignored.
>=20
> For mask_device to be useful in SMP, I guess we both agree that we need=

> some kind of barrier for synchronizing in flight IRQs before they becom=
e
> not only spurious IRQs, but also deadly ones. Reading the kernel code, =
I
> can understand how this is done, both in disable_irq() and __free_irq()=
:
> first disable the device in the driver, then disable the line, then
> synchronize. The barrier mechanism is there.

The barrier is the descriptor lock (to protect against future events on
the line) and then synchronize_irq (to protect against already running
events).

>=20
> What kind of construct would you then recommend to Xenomai driver
> writers, to have the same guarantee with only the driver doing
> "disable_device" and Xenomai doing "synchronize"? This is what I'm
> likely missing.
>=20

my_device_disable_irqs();
rtdm_irq_free();

That must suffice, and Xenomai must be fixed to guarantee this. If
rtdm_irq_free also automatically disables the line is irrelevant for the
driver writer, it's an implementation detail for Xenomai - nothing I
vote against in principle once we can provide soft-IRQ masking for MSI
or whatever problematic IRQ type.

Jan


--------------enigA000A0C24A9EBE744F8A509C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzdiqgACgkQitSsb3rl5xS3kgCcD1B+hekUTDh/+qolFP8c7hQG
nYIAn3Z8n+cuXB4waudAOrRktvj8dw8S
=u2kZ
-----END PGP SIGNATURE-----

--------------enigA000A0C24A9EBE744F8A509C--


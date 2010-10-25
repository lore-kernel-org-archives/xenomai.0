Message-ID: <4CC5D742.9080307@domain.hid>
Date: Mon, 25 Oct 2010 21:15:14 +0200
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
	<1288033731.26618.161.camel@domain.hid>
In-Reply-To: <1288033731.26618.161.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig212C812974213F8BAE910D5A"
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
--------------enig212C812974213F8BAE910D5A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 25.10.2010 21:08, Philippe Gerum wrote:
> On Mon, 2010-10-25 at 20:10 +0200, Jan Kiszka wrote:
>> Am 25.10.2010 18:48, Philippe Gerum wrote:
>>> On Wed, 2010-10-13 at 16:52 +0200, Philippe Gerum wrote:=20
>>>>>
>>>>> Should we test IPIPE_STALL_FLAG on all but current CPUs?
>>>>
>>>> That would solve this particular issue, but we should drain the pipe=
line
>>>> out of any Xenomai critical section. The way it is done now may indu=
ce a
>>>> deadlock (e.g. CPU0 waiting for CPU1 to acknowledge critical entry i=
n
>>>> ipipe_enter_critical when getting some IPI, and CPU1 waiting hw IRQs=
 off
>>>> for CPU0 to release the Xenomai lock that annoys us right now).
>>>>
>>>> I'll come up with something hopefully better and tested in the next
>>>> days.
>>>>
>>>
>>> Sorry for the lag. In case that helps, here is another approach, base=
d
>>> on telling the pipeline to ignore the irq about to be detached, so th=
at
>>> it passes all further occurrences down to the next domain, without
>>
>> Err, won't this irritate that next domain, ie. won't Linux dump warnin=
gs
>> about a spurious/unhandled IRQ? I think either the old handler shall
>> receive the last event or no one.
>=20
> Flipping the IRQ modes within a ipipe_critical_enter/exit section gives=

> you that guarantee. You are supposed to have disabled the irq line
> before detaching, and critical IPIs cannot be acknowledged until all
> CPUs have re-enabled interrupts at some point. Therefore, there are onl=
y
> two scenarii:
>=20
> - irq was disabled before delivery, and a pending interrupt is masked b=
y
> the PIC and never delivered to the CPU.
>=20
> - an interrupt sneaked in before disabling, it is currently processed b=
y
> the pipeline in the low handler on some CPU, in which case interrupts
> are off, so a critical IPI could be acked yet, and the irq mode bits
> still allow dispatching to the target domain on that CPU. The assumptio=
n
> which is happily made is that only head domains are interested in
> un-virtualizing irqs, so the dispatch will happen immediately, while th=
e
> handler is still valid (actually, we are not allowed to un-virtualize
> root irqs, and intermediate Adeos domains are already considered as
> endangered species, so this is fine).
>=20
>>
>> Why this complex solution, why not simply draining (via critical_enter=

>> or whatever) - but _after_ xnintr_irq_detach, ie. while the related
>> resources are still valid?
>>
>=20
> Because it's already too late. You have cleared the handler pointer whe=
n
> un-virtualizing via xnarch_release_irq, and the wired irq dispatcher or=

> the log syncer on another CPU could then branch to eip $0.

Just make ipipe_virtualize_irq install a nop handler instead of NULL.

Jan

>=20
> And the solution is - reasonably - complex because xnintr_detach has
> quite a few inter-deps. Typically, you may not drop the lock Xenomai
> holds on the irq descriptor before calling xnarch_release_irq, to avoid=

> a race with xnintr_irq_handler in SMP (you could get a NULL cookie
> there).
>=20
> I would have preferred to have ipipe_virtualize_irq drain the
> interrupts, but you just can't rely on a critical IPI while holding a
> lock other CPUs might spin on irqs off. And you do need this code to
> happen in a critical enter section, to act as a barrier wrt IRQ
> dispatching. So the operation is unfold, the irq barrier first with irq=
s
> on, then un-virtualizing the irq (for the relevant domain) with irqs
> off.
>=20
>> Jan
>>
>=20


--------------enig212C812974213F8BAE910D5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzF10IACgkQitSsb3rl5xQoWACbBUFKemqFCauDNnXozqQPMBpn
SCMAoO/RhTyXcGy9v3VD+FLc1xOSZRT0
=DllX
-----END PGP SIGNATURE-----

--------------enig212C812974213F8BAE910D5A--


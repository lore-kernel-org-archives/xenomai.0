Message-ID: <4CC5D8FF.5080109@domain.hid>
Date: Mon, 25 Oct 2010 21:22:39 +0200
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
	<1288034435.26618.164.camel@domain.hid>
In-Reply-To: <1288034435.26618.164.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig50BD61C66AE875C49EA1CC1A"
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
--------------enig50BD61C66AE875C49EA1CC1A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 25.10.2010 21:20, Philippe Gerum wrote:
> On Mon, 2010-10-25 at 21:15 +0200, Jan Kiszka wrote:
>> Am 25.10.2010 21:08, Philippe Gerum wrote:
>>> On Mon, 2010-10-25 at 20:10 +0200, Jan Kiszka wrote:
>>>> Am 25.10.2010 18:48, Philippe Gerum wrote:
>>>>> On Wed, 2010-10-13 at 16:52 +0200, Philippe Gerum wrote:=20
>>>>>>>
>>>>>>> Should we test IPIPE_STALL_FLAG on all but current CPUs?
>>>>>>
>>>>>> That would solve this particular issue, but we should drain the pi=
peline
>>>>>> out of any Xenomai critical section. The way it is done now may in=
duce a
>>>>>> deadlock (e.g. CPU0 waiting for CPU1 to acknowledge critical entry=
 in
>>>>>> ipipe_enter_critical when getting some IPI, and CPU1 waiting hw IR=
Qs off
>>>>>> for CPU0 to release the Xenomai lock that annoys us right now).
>>>>>>
>>>>>> I'll come up with something hopefully better and tested in the nex=
t
>>>>>> days.
>>>>>>
>>>>>
>>>>> Sorry for the lag. In case that helps, here is another approach, ba=
sed
>>>>> on telling the pipeline to ignore the irq about to be detached, so =
that
>>>>> it passes all further occurrences down to the next domain, without
>>>>
>>>> Err, won't this irritate that next domain, ie. won't Linux dump warn=
ings
>>>> about a spurious/unhandled IRQ? I think either the old handler shall=

>>>> receive the last event or no one.
>>>
>>> Flipping the IRQ modes within a ipipe_critical_enter/exit section giv=
es
>>> you that guarantee. You are supposed to have disabled the irq line
>>> before detaching, and critical IPIs cannot be acknowledged until all
>>> CPUs have re-enabled interrupts at some point. Therefore, there are o=
nly
>>> two scenarii:
>>>
>>> - irq was disabled before delivery, and a pending interrupt is masked=
 by
>>> the PIC and never delivered to the CPU.
>>>
>>> - an interrupt sneaked in before disabling, it is currently processed=
 by
>>> the pipeline in the low handler on some CPU, in which case interrupts=

>>> are off, so a critical IPI could be acked yet, and the irq mode bits
>>> still allow dispatching to the target domain on that CPU. The assumpt=
ion
>>> which is happily made is that only head domains are interested in
>>> un-virtualizing irqs, so the dispatch will happen immediately, while =
the
>>> handler is still valid (actually, we are not allowed to un-virtualize=

>>> root irqs, and intermediate Adeos domains are already considered as
>>> endangered species, so this is fine).
>>>
>>>>
>>>> Why this complex solution, why not simply draining (via critical_ent=
er
>>>> or whatever) - but _after_ xnintr_irq_detach, ie. while the related
>>>> resources are still valid?
>>>>
>>>
>>> Because it's already too late. You have cleared the handler pointer w=
hen
>>> un-virtualizing via xnarch_release_irq, and the wired irq dispatcher =
or
>>> the log syncer on another CPU could then branch to eip $0.
>>
>> Just make ipipe_virtualize_irq install a nop handler instead of NULL.
>=20
> This does not solve the issue of the last interrupt which should be
> processed. You don't want to miss it.

Don't understand. No interrupt is supposed to arrive anymore on
deregistration, the last user is supposed to be down by now. We just
need to catch though that slipped through.

Jan


--------------enig50BD61C66AE875C49EA1CC1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzF2P8ACgkQitSsb3rl5xS6ugCgtl2jPobhkdel8MvrWupogsOx
noUAoJmeF7brnzKBJMUPFiezHsNF2BJS
=cYPu
-----END PGP SIGNATURE-----

--------------enig50BD61C66AE875C49EA1CC1A--


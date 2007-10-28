Message-ID: <47246A1A.7040909@domain.hid>
Date: Sun, 28 Oct 2007 11:53:14 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <e4ef24880710261838l4d1961a5s8117d116be499cee@domain.hid>	
	<e4ef24880710262040r718b58f7xa2e5f89156d9024b@domain.hid>	
	<e4ef24880710262126g658f3f7ci534ca13df32b2e0e@domain.hid>	
	<4723118D.9060807@domain.hid> <472326E6.9080103@domain.hid>	
	<47232A0C.60705@domain.hid> <47234083.4000602@domain.hid>	
	<e4ef24880710271153qb9c0b27y937f3d87e16f0922@domain.hid>	
	<47238BD7.1040501@domain.hid>
	<e4ef24880710271217y2e0f6712t331bfcaac0e2a691@domain.hid>
In-Reply-To: <e4ef24880710271217y2e0f6712t331bfcaac0e2a691@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4DCAB9532774E66C29F7D830"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [RTnet-users] RTNet in non-TDMA mode?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Robert Gubler <rgubler@domain.hid>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4DCAB9532774E66C29F7D830
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Robert Gubler wrote:
> On 10/27/07, Roland Tollenaar <rwatollenaar@domain.hid> wrote:
>> Hi Rob,
>>
>> Thanks for this response.
>>
>>>     But my question remains -purely out of interest- why non-rt devic=
es
>> and
>>>     rt devices can _fundamentally_ not share an IRQ?
>>>
>>>
>>>
>>> My understanding is adeos-ipipe/xenomai provide an interrupt abstract=
ion
>>> layer underneath Linux.  If there is more than one consumer of an
>>> interrupt it has to be copied/forwarded to all those that need it.  I=
f
>>> an IRQ is shared with an RT application, and the Linux kernel I would=

>>> imagine this would create some level of indeterministic RT software.
>=20
>=20
> IRQs are incoming (to the kernel/CPU) signals IIUC. I imagine that at
>> the end of these incoming IRQ's sit ISRs just waiting for IRQ and read=
y
>> to respond to it in whatever manner they usually do. If this
>> understanding is correct (which it probably is not) then I would not b=
e
>> able to conceive of a reason why the IRQ could not be passed on to the=

>> NON RT interrupt service routine after it has been handled by the
>> RT-ISR. But I reiterate that my understanding of these things is as
>> sketchy as my interest to improve the sketchiness is big. :)
>=20
>=20
> I think the problem is once the RT-ISR passes it to the NON-RT ISR  the=
re
> are no real guarantees for how long Linux (its device driver, most like=
ly)
> will hold on to the interrupt.  This is problematic if it is causing
> scheduling deadlines to be missed.   Its probably not an issue with sha=
red
> interrupts between multiple RT applications because (1) the RT apps usi=
ng it
> are (hopefully) written with understanding it is in a real-time context=
;
> this is good peace of mind.  And (2) there is probably some fancy inter=
rupt
> masking or priority going on between RT-shared interrupts that make it =
more
> deterministic.
>=20
> And now for the obligatory I-don't-really-know-what-I'm-talking-about
> disclaimer again:
>=20
> I am new to these packages, so hopefully I am not providing misinformat=
ion
> on its functionality.
>=20
> :)

You're providing very accurate explanations in fact! And if you or
Roland things have the impression that the related FAQ entry on
xenomai.org is not the clear, please enhance it!

One further note on why it is hard to handle cross-domain-shared IRQs:
For the non-RT user, you always need a minimal (and, of course,
deterministic) IRQ handling stub in the RT domain that shut ups the IRQ
at device level and then forward it for later handling to the non-RT
domain. We a) have no really smart way for forwarding the IRQ at the
moment (*) and we b) would then still have to maintain those
hardware-specific stubs, which we cannot do for each and every Linux
driver out there.

Jan

(*) You currently need an additional virtual IRQ. Reusing the Adeos
pipeline with the same IRQ line is a yet unimplemented idea of mine for
a smarter alternative.


--------------enig4DCAB9532774E66C29F7D830
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHJGoaniDOoMHTA+kRAshaAJ98Go9l6ywxhFeT6CKSXKjnqCxu8ACfStqx
x1/lj2kZFBNvbCXuhtcO7m4=
=mPAs
-----END PGP SIGNATURE-----

--------------enig4DCAB9532774E66C29F7D830--


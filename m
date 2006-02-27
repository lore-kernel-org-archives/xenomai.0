Message-ID: <4402B70A.4040809@domain.hid>
Date: Mon, 27 Feb 2006 09:23:38 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
References: <b647ffbd0602150939g59256b2bx@domain.hid>	<b647ffbd0602210254p19086a0au@domain.hid>	<43FAF94C.4080709@domain.hid>	<43FAFE58.5060201@domain.hid>	<b647ffbd0602210848g321ffedei@domain.hid>	<43FB480E.9020808@domain.hid>	<43FB529B.3040207@domain.hid>	<43FB6102.1070004@domain.hid>	<b647ffbd0602220445k749d630j@domain.hid>	<43FDA8E2.5010806@domain.hid>	<b647ffbd0602251214h36768b46o@domain.hid>	<4401F8B4.9090707@domain.hid>
	<4401FE4A.7010603@domain.hid> <4401FFA6.3010204@domain.hid>
	<4402B4D3.4050606@domain.hid>
In-Reply-To: <4402B4D3.4050606@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig748D1284E0A10C3433C399F6"
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
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig748D1284E0A10C3433C399F6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Anders Blomdell wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Dmitry Adamushko wrote:
>>>>
>>>>
>>>>> ...
>>>>> This said, I'm going to publish the shirq patch (after finalizing I=
SR
>>>>> return
>>>>> bits,
>>>>> where I still have some doubts) without enable/disable nesting
>>>>> support.
>>>>> It can be supported at some point of time later, if it's really
>>>>> needed.
>>>>>
>>>>
>>>>
>>>> Regarding enable/disable nesting and existing driver patterns: I
>>>> currently do the following on devices init via RTDM (and users may h=
ave
>>>> copied this):
>>>>
>>>> rtdm_irq_request(...);
>>>> <init_hardware, also clear pending IRQs of the device>
>>>> rtdm_irq_enable(...);
>>>>
>>>> But I do not disable the IRQ before rtdm_irq_free() again. Is this
>>>> unbalanced enabling still needed today? Is it even wrong these days?=

>>>
>>> Looks unsafe, since nothing says that freeing the descriptor associat=
ed
>>> with some IRQ should disable this IRQ line at hw level. However, we
>>> would be correct to assume that no IRQ could happen after we have bee=
n
>>> asked to free its associated descriptor.
>>>
>>> Is
>>>
>>>> it arch-dependent?
>>>
>>> Nope. Both APIs are arch-agnostic anyway.
>>>
>>> I think the pattern dates back in RTAI times and was
>>>
>>>> needed for so far unused IRQs. Disabling them on device closure bloc=
ked
>>>> the line for later use under Linux.
>>>>
>>>
>>> We never had this problem with Xeno, since we always relied on the
>>> standard IRQ controllers defined by Linux for managing interrupt line=
s.
>>> IOW, Linux can undo what Xenomai did wrt IRQ line enabling/disabling.=

>>>
>>
>>
>> So the enable is definitely needed and a disable on release should not=

>> cause harm anymore? If that's the case, we could start re-introducing
>> rtdm_irq_disable before rtdm_irq_free again.
> Except for interrupts shared between RT/non-RT, the don't need enable
> (since they are enabled by Linux already), and probably doesn't fare
> well with a final disable.
>=20

This does not apply to the drivers I have in mind (e.g. RTnet NIC
drivers). None of them is prepared to share the IRQ line with Linux.
There is only the scenario that a Linux driver for the same hardware
gets loaded later after removing the RT driver (e.g. switching from
RTnet to standard Linux networking).

Anyway, before changing anything here we need some tests - and counting
enable/disable. Otherwise, we will already run into troubles with shared
RT-IRQs.

Jan


--------------enig748D1284E0A10C3433C399F6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEArcKniDOoMHTA+kRArhcAJ9YbTPeXSJs4b8J8mF3t7yvNA288gCfR7Xb
LbaWFJgr84VjjnJbV78S/fQ=
=dBgV
-----END PGP SIGNATURE-----

--------------enig748D1284E0A10C3433C399F6--


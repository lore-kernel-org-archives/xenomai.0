Message-ID: <443C20D4.1090801@domain.hid>
Date: Tue, 11 Apr 2006 23:34:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: [Xenomai-core] kgdb over ipipe
References: <44377F75.9030707@domain.hid> <4438FAFA.3020105@domain.hid>
	<44397CBF.905@domain.hid> <443C0A34.70107@domain.hid>
	<443C0F80.7070600@domain.hid>
In-Reply-To: <443C0F80.7070600@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4890163F77D49D666B7C1AA2"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4890163F77D49D666B7C1AA2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Jan Kiszka wrote:
>>>>
>>>>
>>>>> Hi,
>>>>>
>>>>> this is the preliminary, though already usable result of my recent
>>>>> effort to extend the tool situation for Xenomai: A kgdb patch
>>>>> series for
>>>>> 2.6.15 on x86. It already works quite well but likely does not yet
>>>>> catch
>>>>> all fatal scenarios (e.g. page faults in the Xenomai domain).
>>>>>
>>>>
>>>>
>>>> And here comes another revision (prepare patch remains unmodified).
>>>>
>>>> It gets closer to what Philippe also just suggested in the original
>>>> thread: hook KGDB into I-pipe in favour of registering a dedicated
>>>> domain. The latter approach modifies the I-pipe state in a way which=

>>>> may
>>>> blur the picture of I-pipe itself to the debugger. This revision hoo=
ks
>>>> exception events into the I-pipe core so that they are delivered the=

>>>> normal way when the root domain is active, but get catched early for=

>>>> higher domains like Xenomai. I'm just not sure about the best way to=

>>>> handle the serial line IRQ. Philippe, do you see problems with curre=
nt
>>>> approach? Should we better hook into __ipipe_handle_irq (which would=

>>>> make things more complicated, I'm afraid)?
>>>>
>>>
>>> The current approach works fine unless a runaway thread goes wild wit=
h
>>> interrupts disabled (i.e. stall bit set) in the root stage or in any
>>> higher priority domain regardless of the root domain state, in which
>>> case the serial IRQ won't make it through the pipeline to KGDB.
>>
>>
>> But catching this would mean to change the behaviour of ipipe regardin=
g
>> the highest priority domain from hard to soft masking of IRQs. Hmm,
>> should be made at least optional to catch scenarios where this change
>> makes bugs move (away...).
>>
>> Would be the easiest way to achieve this to register a dummy domain
>> ahead of Xenomai (i.e. with higher prio)?
>=20
> This would be the theoretically "normal" way to do this, but this comes=

> with the undesirable side-effect of losing the hw masking of interrupts=

> for the Xenomai domain, since you stack another domain on top.
>=20
>  Additionally, we would have to
>> modify the IRQ pipeline in a way that, e.g., some flag makes an IRQ no=
t
>> only sticky but also "non-maskable" (I would make this also an option =
to
>> avoid overhead for non-debugging scenarios).
>>
>=20
> By non-maskable, you mean at PIC-level?

Nope, at software-level. I mean that such IRQs would always be passed
down the pipeline, even through stalled domains.

>=20
>> Well, not yet an essential feature for me, because we still have the N=
MI
>> watchdog and the option to spread breakpoints. But we should keep it i=
n
>> mind.
>>
>>
>>>> In contrast to the first version, exceptions happening in the Xenoma=
i
>>>> domain now also get reported to KGDB. Debugging mostly works fine, I=
'm
>>>> just facing unknown problems with intercepting and then continuing
>>>> kernel-only RT threads. KGDB sometimes reports "E22" back in this ca=
se,
>>>> but always locks up. Maybe it gets confused by the fact the there is=
 no
>>>> Linux task behind Xenomai kernel threads? I tested this by putting a=

>>>> breakpoint into xnpod_suspend_thread and running latency in mode 0 a=
nd
>>>> 1. 0 works fine, 1 not.
>>>>
>>>
>>> KGDB is relying on "current", so it's reading garbage over Xenomai's
>>> kernel threads.
>>>
>>
>>
>> Attached is an improved version of the kgdb-ipipe.patch that copes wit=
h
>> this situation by mapping invalid currents to init_task. Kernel thread=
s
>> are nicely debuggable now. =3D8)
>>
>=20
> Ok, queued.
>=20

As an add-on patch like the tracer?

Jan


--------------enig4890163F77D49D666B7C1AA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEPCDUniDOoMHTA+kRAgnkAJ9EVVrkI5C9DrKad7ZXPmQLfUV27gCffOu6
qx9LkR0fItUBZuwyoSzyeaw=
=rb0Z
-----END PGP SIGNATURE-----

--------------enig4890163F77D49D666B7C1AA2--


Message-ID: <4B5D48A1.6090107@domain.hid>
Date: Mon, 25 Jan 2010 08:30:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B5B02E3.8060103@domain.hid>	<4B5CCF35.2040402@domain.hid>
	<4B5D372E.2090301@domain.hid>
In-Reply-To: <4B5D372E.2090301@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD3736FBBE5F66678294363F4"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Adeos-main] [RFC][PATCH] x86: Fix root domain
 state restoring on exception return
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, adeos-main <adeos-main@gna.org>, xenomai-core <xenomai@xenomai.org>, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD3736FBBE5F66678294363F4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> If we enter __ipipe_handle_exception over a non-root domain and leave=
 it
>>> due to migration in the event handler over root, we must not restore =
the
>>> root domain state so far saved on entry. This caused subtle pipeline
>>> state corruptions. Actually, we only need to save the state if we ent=
er
>>> over the root domain and have to align its state to the hardware
>>> interrupt mask.
>>>
>>> Moreover, the x86-32 regs.eflags fix-up must happen based on the curr=
ent
>>> root domain state to avoid more spurious corruptions.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>> ---
>>>
>>> This patch is so far running fine on the x86-64 boxes of our colleagu=
es
>>> @Healthcare. It currently makes most sense to me, also for (untested)=

>>> x86-32, but maybe I'm still missing a problematic scenario.
>>>
>>>  arch/x86/kernel/ipipe.c |   64 ++++++++++++++++++++++++++-----------=
---------
>>>  1 files changed, 36 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
>>> index 4442d96..8253993 100644
>>> --- a/arch/x86/kernel/ipipe.c
>>> +++ b/arch/x86/kernel/ipipe.c
>>> @@ -702,19 +702,17 @@ static int __ipipe_xlate_signo[] =3D {
>>> =20
>>>  int __ipipe_handle_exception(struct pt_regs *regs, long error_code, =
int vector)
>>>  {
>>> -	unsigned long flags;
>>> -
>>> -	/* Pick up the root domain state of the interrupted context. */
>>> -	local_save_flags(flags);
>>> +	bool restore_flags =3D false;
>>> +	unsigned long flags =3D 0;
>>> =20
>>> -	if (ipipe_root_domain_p) {
>>> +	if (ipipe_root_domain_p && irqs_disabled_hw()) {
>> I really do not understand this hunk. It differs a lot from the curren=
t
>> situation. In the current situation __fixup_if really does something,
>> even if irqs were not masked on entry.
>>
>=20
> Ok, but on x86_64, you have:
> +	bool restore_flags =3D false;
> +	if (ipipe_root_domain_p && irqs_disabled_hw()) {
> +		restore_flags =3D true;
>  	}
> +	if (restore_flags)
> +		local_irq_restore_nosync(flags);
>=20
> Which I do not understand. local_irq_restore_nosync still has an effect=

> even if irqs were not disabled on entry.
>=20

Right, but is there any scenario remaining where we need this effect?

Jan


--------------enigD3736FBBE5F66678294363F4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAktdSKgACgkQitSsb3rl5xSaQQCgk6hsHQLud2YZW36yYThEZGxG
AGEAoKtEf1BrTLVZsW/reZC3/rlX+/Id
=Cxg/
-----END PGP SIGNATURE-----

--------------enigD3736FBBE5F66678294363F4--


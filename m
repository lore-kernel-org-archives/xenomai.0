Message-ID: <4B5CD1E3.5070809@domain.hid>
Date: Mon, 25 Jan 2010 00:04:03 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B5B02E3.8060103@domain.hid>
	<4B5CCF35.2040402@domain.hid>
In-Reply-To: <4B5CCF35.2040402@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2F7F719B0972BAE62EB12815"
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
--------------enig2F7F719B0972BAE62EB12815
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> If we enter __ipipe_handle_exception over a non-root domain and leave =
it
>> due to migration in the event handler over root, we must not restore t=
he
>> root domain state so far saved on entry. This caused subtle pipeline
>> state corruptions. Actually, we only need to save the state if we ente=
r
>> over the root domain and have to align its state to the hardware
>> interrupt mask.
>>
>> Moreover, the x86-32 regs.eflags fix-up must happen based on the curre=
nt
>> root domain state to avoid more spurious corruptions.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>> ---
>>
>> This patch is so far running fine on the x86-64 boxes of our colleague=
s
>> @Healthcare. It currently makes most sense to me, also for (untested)
>> x86-32, but maybe I'm still missing a problematic scenario.
>>
>>  arch/x86/kernel/ipipe.c |   64 ++++++++++++++++++++++++++------------=
--------
>>  1 files changed, 36 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
>> index 4442d96..8253993 100644
>> --- a/arch/x86/kernel/ipipe.c
>> +++ b/arch/x86/kernel/ipipe.c
>> @@ -702,19 +702,17 @@ static int __ipipe_xlate_signo[] =3D {
>> =20
>>  int __ipipe_handle_exception(struct pt_regs *regs, long error_code, i=
nt vector)
>>  {
>> -	unsigned long flags;
>> -
>> -	/* Pick up the root domain state of the interrupted context. */
>> -	local_save_flags(flags);
>> +	bool restore_flags =3D false;
>> +	unsigned long flags =3D 0;
>> =20
>> -	if (ipipe_root_domain_p) {
>> +	if (ipipe_root_domain_p && irqs_disabled_hw()) {
>=20
> I really do not understand this hunk. It differs a lot from the current=

> situation. In the current situation __fixup_if really does something,
> even if irqs were not masked on entry.
>=20

This hunk is no longer related to __fixup_if. The latter now picks up
the information about what to fix from root domain state _after_ the
return of the ipipe exception hook. That way we avoid leaking the wrong
root state on entry over a non-root domain after migration within the hoo=
k.

Jan


--------------enig2F7F719B0972BAE62EB12815
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAktc0eMACgkQitSsb3rl5xQ9BQCgrVmEH04FbXBLi2Ko8ULQHING
krMAoIsfkna3+6cy9Pr1uV9GGTQwAV/m
=Gu1Q
-----END PGP SIGNATURE-----

--------------enig2F7F719B0972BAE62EB12815--


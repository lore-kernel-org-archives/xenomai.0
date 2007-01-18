Message-ID: <45AFD3E2.8090200@domain.hid>
Date: Thu, 18 Jan 2007 21:09:06 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] irq conflict
References: <45ADEDDC.5060407@domain.hid> <45AEA9A7.7000001@domain.hid>
	<45AFC392.5050705@domain.hid>
In-Reply-To: <45AFC392.5050705@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAC5934EE0F33DF82D3A39E5C"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Theo Veenker <Theo.Veenker@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAC5934EE0F33DF82D3A39E5C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Theo Veenker wrote:
> Jan Kiszka wrote:
>> Theo Veenker wrote:
>>> Hi all,
>>>
>>> I need to run xenomai on a HP Compaq nc6320. I use kernel 2.6.17.14
>>> and xenomai 2.2.5. The non-realtime kernel runs fine on this laptop,
>>
>> Means the same kernel with I-pipe (and Xenomai) disabled or the same
>> kernel version and .config, but unpatched?
>=20
> The latter.
>=20
>>
>>> but the xenomai pactched kernel gives several of these messages:
>>>
>>>   IRQ routing conflict for xxxx.xx.xx.x, have irq 11, want irq 10
>>>
>>> And some things (e.g. mouse, network) then don't work, not properly
>>> anyway. The same kernel runs fine however on other systems.
>>>
>>> Any clue what I can do about it?
>>
>> Please provide bootlogs for both rt and non-rt kernel startup. And the=

>> .config.
>=20
> I 'solved' it by enabling ACPI (without processor module and others).
> Looks good. I don't see high latencies with the latency test. Under
> what conditions might ACPI affect real-time behaviour?

CONFIG_ACPI_PROCESSOR, because it allows deep sleep states with
significant wakeup latencies.

But back to your original issue: You mean your notebook booted fine
under vanilla Linux with ACPI disabled? That would mean I-pipe relies on
ACPI here without stating this anywhere. In that case /something/ needs
fixing: code, config deps, or doc.

Jan


PS: Please take care to not drop the list from CC.


--------------enigAC5934EE0F33DF82D3A39E5C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFr9PmniDOoMHTA+kRAuUzAJ9TKzyS5diuCsZD66dOc9AxIQ1UmwCePkaY
iAK2uKsKX+qObX20ztVWw6s=
=/goG
-----END PGP SIGNATURE-----

--------------enigAC5934EE0F33DF82D3A39E5C--


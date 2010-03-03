Message-ID: <4B8E281F.1040308@domain.hid>
Date: Wed, 03 Mar 2010 10:13:03 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B8E24B4.9000806@domain.hid> <4B8E260D.7070809@domain.hid>
In-Reply-To: <4B8E260D.7070809@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5F8929E07E00059078630840"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Potential heap corruption on thread cleanup
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>, xenomai-core <xenomai@xenomai.org>, Gernot Hillier <gernot.hillier@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5F8929E07E00059078630840
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Hi Gilles,
>>
>> I'm pushing your findings to the list, also as my colleagues showed
>> strong interest - this thing may explain rare corruptions for us as we=
ll.
>>
>> I thought a bit about that likely u_mode-related crash in your test ca=
se
>> and have the following theory so far: If the xeno_current_mode storage=

>> is allocated on the application heap (!HAVE_THREAD, that's also what w=
e
>> are forced to use), it is automatically freed on thread termination in=

>> the context of the dying thread. If the thread is already migrated to
>> secondary or if that happens while it is cleaned up (i.e. before calli=
ng
>> for exit into the kernel), there is no problem, Xenomai will not touch=

>> the mode storage anymore. But if the thread happens to delete the
>> storage "silently", without any migration, the final exit will trigger=

>> one further access. And that takes place against an invalid head area =
at
>> this point.
>>
>> Does this make sense?
>=20
> Yes, it is the issue we observed.
>=20
>> If that is true, all we need to do is to force a migration before
>> releasing the mode storage. Could you check this?
>=20
> No, that does not fly. Calling, for instance, __wrap_pthread_mutex_lock=

> in another TSD cleanup function is which could be called after the
> current_mode TSD cleanup is allowed and could trigger a switch to
> primary mode and a write to the u_mode.
>=20

Good point. Mmh. Another, but ABI-breaking, way would be to add a
syscall for deregistering the u_mode pointer...

Jan


--------------enig5F8929E07E00059078630840
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuOKCIACgkQitSsb3rl5xSW/wCgidtGB99HnZ5LCNRyXlH8PvMp
ZEEAoKlP99ZOwYkRlyZtVPam7ONuk6P7
=8XFt
-----END PGP SIGNATURE-----

--------------enig5F8929E07E00059078630840--


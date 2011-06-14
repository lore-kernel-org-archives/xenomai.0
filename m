Message-ID: <4DF6F87E.7000500@domain.hid>
Date: Tue, 14 Jun 2011 07:58:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4DF5EA11.5010006@domain.hid> <4DF64C3A.6080407@domain.hid>
	<4DF65FC8.1000703@domain.hid>
In-Reply-To: <4DF65FC8.1000703@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig03361B68236AC75F3EA101C0"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai on i7-870
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jakub Nowacki <j.s.nowacki@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig03361B68236AC75F3EA101C0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-06-13 21:06, Jakub Nowacki wrote:
> On 13/06/2011 18:43, Gilles Chanteperdrix wrote:
>>
>> Please post your .config.
>>
>=20
> Here you are.

Do you have the irqbalance daemon running? If yes, disable it and retry.
If it helps, you may also want to try

git://git.kiszka.org/ipipe.git queues/2.6.38-x86

If that doesn't help, try to disable CONFIG_DMAR (though it should left
off by default during boot) and CONFIG_INTR_REMAP.

Regarding CONFIG_HPET_TIMER: That's not selectable on x86-64. If you
have "enough" cores, the kernel will run out of HPET timers and won't
select them as clock events. With 8 cores, you should be safe, but
better check the kernel boot messages for "hpet" or the state of
/proc/timer_list regarding "Clock Event Device" when booting the same
kernel without Xenomai support.

Jan


--------------enig03361B68236AC75F3EA101C0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk32+IIACgkQitSsb3rl5xQflwCfdcJQAuyCpmGpCLrqO9P+0Ua6
tbgAn3LtW5uBkBNrwPt77BNWLKa51jrI
=AcfE
-----END PGP SIGNATURE-----

--------------enig03361B68236AC75F3EA101C0--


Message-ID: <4BA8F900.5000602@domain.hid>
Date: Tue, 23 Mar 2010 18:23:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BA39C3D.1040802@domain.hid>
	<4BA4EF75.7010202@domain.hid>	<4BA74820.2090401@domain.hid>
	<4BA8752E.8090407@domain.hid>	<4BA8C15E.5050707@domain.hid>
	<4BA8F517.3060705@domain.hid> <4BA8F732.10206@domain.hid>
In-Reply-To: <4BA8F732.10206@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAC25C7D063040F117DD50A31"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] crash after termination
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAC25C7D063040F117DD50A31
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Stefan Kisdaroczi wrote:
>>> Hi Jan,
>>>
>>> Only user space using the native skin. Some additional notes:
>>> I'm using the freepascal compiler and link against libnative, i dont =
use gcc.
>>> There is one process starting the other ten processes using fork() & =
execl().
>>> The tasks do a lot of mode switching between primary/secondary.
>>> The stacksize for the tasks is 1MB. We only use between 4K-16K of sta=
ck in our
>>> applications. So there should be still a bit less than 1 MB for socke=
t calls
>>> and printf, is this to low ?
>> Also stack overflows must not crash the kernel, they may only cause
>> application crashes.
>>
>>> I rebuilt the kernel without arcnet and isdn and disabled smp too, us=
ing 2.5.1.
>>> It still crashes every time on termination. If I pull the network con=
nector,
>>> I could start and shutdown the applications 5 times without problem. =
If the
>>> network is connected, as soon as there is some network activity like =
ssh/samba
>>> on termination the box crashes. Sometimes it gets even back to the pr=
ompt before
>>> crashing. Its a rtl8139 network card, but happens in a virtualbox-vm =
with a pcnet
>>> card too. In the traces is always a "do_IRQ+0x...", so I think the pr=
oblem is
>>> related to IRQ-handling.
>> That sounds promising! If you can provide your test case to us (or me
>> privately), we could try to reproduce - inside a proper hypervisor whi=
ch
>> has proper debugging facilities. :)
>=20
> I do not know if this could be related, but you have two drivers we 813=
9
> in their name. Could there be a conflict?
>=20

I would say only the 8139cp gets hold of all the hardware - unless there
cards plugged that only the 8139too supported. Otherwise, that 8139too
should simply remain unused.

Jan


--------------enigAC25C7D063040F117DD50A31
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuo+QQACgkQitSsb3rl5xRtrwCfYR7wtclD41MEYlMKrUMRFTqn
rIcAn3StcDqR1HYZvdJu/AaEyUuJU8ZA
=/EOA
-----END PGP SIGNATURE-----

--------------enigAC25C7D063040F117DD50A31--


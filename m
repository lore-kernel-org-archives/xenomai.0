Message-ID: <4B16310E.1080306@domain.hid>
Date: Wed, 02 Dec 2009 10:19:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B15AFC0.6020805@domain.hid> <4B1627DC.30300@domain.hid>
In-Reply-To: <4B1627DC.30300@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAFCD845BDCADEB96B10A4914"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [pull request] Signals support.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAFCD845BDCADEB96B10A4914
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Hi,
>>
>> here come the pull request for user-space signals support. The simple =

>> solution; handling signals upon system call return, has been implement=
ed
>> since the other solution (handling signals upon any return to=20
>> user-space) required to change the I-pipe patch, and so made the=20
>> upcoming 2.5 only compatible with newer patches.
>>
>> We pass to kernel-space a sixth argument which is a pointer where=20
>> information about received signals is stored by kernel.
>>
>> The only architecture for which the implementation is peculiar is=20
>> x86_32, because the register used as sixth argument is ebp, also used =

>> for the libc backtrace function implementation, so I tried to find a=20
>> solution which makes backtracing still possible (otherwise we would ha=
ve
>> said bye-bye to involuntary mode changes chasing with SIGXCPU) without=
=20
>> breaking too many things.
>=20
> I'm still digging through the code. A few minor remarks regarding the
> user space side so far:
>=20
> XENOMAI_DO_SYSCALL becomes quite "bloated" now, and it's inlined. Did
> you check that the fast path (ie. no signal) only contains one
> conditional branch when the compiler is done with optimizing? If not (I=

> suspect so), the code should be refactored to look more like
>=20
> restart:
> 	do_syscall
> 	if unlikely(sigs.nsigs)
> 		res =3D handle_signals
> 		if res =3D=3D -ERESTART
> 			goto restart
>=20
> Moreover, the inner while loop over sigs.remaining should be moved into=

> a shared function as well. I don't see why it should be instantiated at=

> each and every syscall invocation site.
>=20
> Am I right, there is no skin (except the test skin) using this feature
> so far?

Next question: The signal delivery latency is naturally affected by the
syscall invocation frequency of the target thread, right? Ie. no
syscall, no signal. Once we offer "RT" signals via the skin, this
limitation should be prominently documented.

Jan


--------------enigAFCD845BDCADEB96B10A4914
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAksWMREACgkQitSsb3rl5xT0hwCeIBcdTfCveD8b8PlIhX4c5Q7v
jQIAnA/UpgWVRzRsjBlzKY+VhLtsRtOC
=WmVI
-----END PGP SIGNATURE-----

--------------enigAFCD845BDCADEB96B10A4914--


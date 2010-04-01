Message-ID: <4BB51A4E.7020606@domain.hid>
Date: Fri, 02 Apr 2010 00:12:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B97BA0C.9000702@domain.hid> <4B9AD0DE.4020103@domain.hid>	
	<1268472523.27899.135.camel@domain.hid>	
	<4B9BB9B1.5050003@domain.hid>	
	<1268498034.27899.167.camel@domain.hid>	
	<4B9C2100.6090806@domain.hid>	
	<1268584465.27899.197.camel@domain.hid>	
	<4BB4F857.5020906@domain.hid>	
	<1270157042.2418.406.camel@domain.hid>
	<4BB51299.7070500@domain.hid>
	<1270159176.2418.431.camel@domain.hid>
In-Reply-To: <1270159176.2418.431.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9626B0B5D1429972A49B7461"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Analogy cmd_write example explanation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9626B0B5D1429972A49B7461
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2010-04-01 at 23:39 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> __xn_exec_current is actually carrying a MASSIVE bug potential:
>>> - stick __xn_current to your favourite syscall, and implement two
>>> versions of that syscall, depending on the current calling mode for t=
he
>>> shadow thread.
>>> - let people think that they should control the current mode of that
>>> thread using rt_task_set_mode() and this freaking horror monster call=
ed
>>> T_PRIMARY, before calling the syscall in question, to get either
>>> implementation A or B.
>>> - run the stuff, and surprise, get a linux signal between
>>> rt_task_set_mode and the syscall. Your thread is now NRT. Too bad, yo=
u
>>> wanted the RT side to run. You are toast.
>> That's a non-issue if the driver gets informed about the capability of=

>> the caller to execute a service also in RT. In that case, if an RT
>> variant of the invoked service exist, the driver can simply issue the
>> well-know ENOSYS, despite the fact that it could handle the call right=

>> now in NRT as well.
>=20
> This is not the issue at stake unfortunately. The problem is with
> drivers implemented in a way that provides two _different_
> implementations of syscalls depending on the current mode. In that case=
,
> -ENOSYS and adaptive won't buy you anything. __xn_exec_current will
> cause your syscall to be routed to the wrong handler as previously
> illustrated.
>=20
> Saying that anyone writing such a driver is close to being a good
> candidate for the Darwin Awards is likely true, but as a matter of fact=
,
> those driver do exist nonetheless. And the reason why they exist, is
> because we have that eager mode switch control available to userland,
> that gives a bad signal to people regarding the semantics of the whole
> thing.
>=20
> So, to put things in the right sequence: I'm not saying that forcing
> conforming syscalls is the only option, but it's the only option that
> _guarantees_ that userland won't shoot itself in the foot in the
> presence of the T_PRIMARY crap. At the very least, any solution that
> gives more insight to drivers regarding how to manipulate the current
> mode should be mated to a converse effort to reduce the nuisance of
> T_PRIMARY.
>=20

Then it's time to signal the deprecation of T_PRIMARY & co. At least
from RTDM POV, there is no need for it anymore (once we resolved the
Analogy case). And RTDM was the only valid use case I recall.

Jan


--------------enig9626B0B5D1429972A49B7461
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAku1Gk4ACgkQitSsb3rl5xT1RgCgkgERUy4VJt/NbX8P6lwczwlM
Pf4AoOAj3gw+oOiwkGSiR8VowJjNhx6h
=Xupe
-----END PGP SIGNATURE-----

--------------enig9626B0B5D1429972A49B7461--


Message-ID: <46793E22.7070107@domain.hid>
Date: Wed, 20 Jun 2007 16:48:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <op.tt74pfqvt06gyn@domain.hid> <1182349939.6137.2.camel@domain.hid>
In-Reply-To: <1182349939.6137.2.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAAF4453766B7572C3D4A97C2"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Status Codes in /proc/xenomai/sched
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bruno Rouchouse <brouchouse@domain.hid>
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAAF4453766B7572C3D4A97C2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Wed, 2007-06-20 at 16:18 +0200, Axel Beierlein wrote:
>> Hello,
>>
>> Where can i find the meaning of the status code at the column STAT
>> in /proc/xenomai/sched ? I am a little bit confused of the Status UX.
>>
>=20
> include/nucleus/thread.h for now, until this eventually gets more
> formally documented:
>=20
>   'S' -> Forcibly suspended.
>   'w'/'W' -> Waiting for a resource, with or without timeout.
>   'D' -> Delayed (without any other wait condition).
>   'R' -> Runnable.
>   'U' -> Unstarted or dormant.
>   'X' -> Relaxed shadow.
>   'H' -> Held thread.
>   'b' -> Priority boost undergoing.
>   'T' -> Ptraced and stopped.
>   'l' -> Locks scheduler.
>   'r' -> Undergoes round-robin.
>   's' -> Interrupt shield enabled.
>   't' -> Mode switches trapped.
>   'o' -> Priority coupling off.
>   'f' -> FPU enabled (for kernel threads).
>=20

Well, I thought to remember some related stuff in the wiki. What I find
is /proc/xenomai/stat, and that is broken here:

http://www.xenomai.org/index.php/FAQs ->
http://www.xenomai.org/index.php//proc/xenomai/stat

Bruno, could you have a look if you can recover the content -- and
likely rename it then? Slashes don't appear to be a smart choice in wiki
page names...

Jan


--------------enigAAF4453766B7572C3D4A97C2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGeT4iniDOoMHTA+kRAnc3AJ4gcUdBYFGr7LA9ze80NOovJFIxrwCdHoGc
lvWKfwJOy9Rteb4javQroPs=
=/hRx
-----END PGP SIGNATURE-----

--------------enigAAF4453766B7572C3D4A97C2--


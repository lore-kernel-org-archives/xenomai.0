Message-ID: <44C9136C.7080709@domain.hid>
Date: Thu, 27 Jul 2006 21:26:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1154015872-24969.00053.00861-smmsdV2.1.4@domain.hid>
	<44C8EECE.4070209@domain.hid> <44C90CEF.9090908@domain.hid>
In-Reply-To: <44C90CEF.9090908@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBC2BFA29F20824A6D0B87DA7"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: RT_TASK_INFO status
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nathaniel Villaume <villaume@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBC2BFA29F20824A6D0B87DA7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Nathaniel Villaume wrote:
> In RT_TASK_INFO, can someone tell me what is the set of all possible
> values for status?
> I'd like to include that in the documentation.

They are defined in include/native/task.h [1], but they widely redirect
to defines in include/nucleus/thread.h [2]. Maybe you could add comments
to the native/task.h defines and include them in doxygen.

Thanks again for your effort!
Jan

[1]http://www.rts.uni-hannover.de/xenomai/lxr/source/include/native/task.=
h#L37
[2]http://www.rts.uni-hannover.de/xenomai/lxr/source/include/nucleus/thre=
ad.h#L25


--------------enigBC2BFA29F20824A6D0B87DA7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEyRNsniDOoMHTA+kRAkMcAJ9ltm3Ta0zWEBbVuyflp1nmuPFFFgCfYWHS
WwFPHqhBVVxxA3S+prcOyDM=
=PSxp
-----END PGP SIGNATURE-----

--------------enigBC2BFA29F20824A6D0B87DA7--


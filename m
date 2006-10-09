Message-ID: <452A8E22.1060404@domain.hid>
Date: Mon, 09 Oct 2006 20:00:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] 3rd party task mode switches and inquiries
References: <1160411937.6268.14.camel@domain.hid>
	<452A8C0F.2010001@domain.hid>
In-Reply-To: <452A8C0F.2010001@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig03AEBD0F89FC6D6C68BD4E9C"
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
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig03AEBD0F89FC6D6C68BD4E9C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Jeff Weber wrote:
>> I have a need for task t1 to switch task t2 to and from primary mode,
>> using the native API.  The rt_task_set_mode() API does not have an
>> argument for the target task, and assumes the current task.  How can I=

>> initiate a 3rd party task mode switch?
>=20
> Umm, could you explain why you need this? Sounds a bit weird to me.

Or do you mean more than just T_PRIMARY? Still, manipulating a remote
task that way can be fairly dangerous (T_LOCK, T_NOSIG). It's at least
as "evil" as rt_task_suspend(someone_else). ;)

Jan


--------------enig03AEBD0F89FC6D6C68BD4E9C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFKo4iniDOoMHTA+kRAoDyAJ9ikcsu2eewdkfK3QXoxrC8a8+O2gCcCI+a
S4ocQSe58vTMoyHASzq7w/I=
=unPS
-----END PGP SIGNATURE-----

--------------enig03AEBD0F89FC6D6C68BD4E9C--


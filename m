Message-ID: <44C91366.2000201@domain.hid>
Date: Thu, 27 Jul 2006 21:26:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] doc patch: RT_TASK_INFO
References: <1154015872-24969.00053.00861-smmsdV2.1.4@domain.hid>
	<44C8EECE.4070209@domain.hid> <44C9088A.20608@domain.hid>
In-Reply-To: <44C9088A.20608@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC8A3BA6D9DA093B77E00A528"
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
To: Nathaniel Villaume <villaume@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC8A3BA6D9DA093B77E00A528
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Nathaniel Villaume wrote:
> The patches were to help you out! I thought that maybe you wouldn't wan=
t
> RT_TASK documented -- users don't really need to konw about magic numbe=
r
> and flowgen, do they?  But yeah, sorry for the spamming.

Yes, I absolutely agree with you that RT_TASK and other internal
structures should not pop up in doxygen (but, of course, still have its
comments for the developers)!

>=20
> As for the comment style, the C style comments don't show up using this=

> inline method: /*!< */   -- that was part of the original problem.  One=


Mm, not convinced yet: the original code looked like this: /* !< Text */
(note the space). I think there must be a C-conforming way to document
fields.

> solution is to use the @typedef command. The only drawback here is the
> minor replication. For example:
>=20
> /*! @typedef RT_TASK
>    @brief Contains important data
>  @param  magic  Magic uniquely identifies the task's wizardry ancestry
>  @param  prio   task priority
> */
> typedef struct {
>  int magic;  // Must come first!   (comments don't HAVE to go here)
>  uint prio;  // task priority
>  /* etc */
> } RT_TASK;

No, not really beautiful. Another way is this (see also RTDM skin):

typedef struct {
	/** Some field */
	int some_field;
} my_struct;

The problem with doxygen is that you never really know what went wrong,
at least not within the first hours of experimenting with the code... :(

>=20
> What I need to know from you:
> 1) Do you care about this duplication of struct member-names (harder to=

> keep docs synchronized with code)?

I would personally prefer to avoid this.

> 2) Do you want RT_TASK member documentation to show up in
> doxygen-generated pages?  (this lets me know what to change)

See above. But I'm not the only one around here.

Jan


--------------enigC8A3BA6D9DA093B77E00A528
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEyRNmniDOoMHTA+kRAme5AJ91VIx68tWfI0O+4zwqv2MMrahq1QCfXpZz
SkU5VT2RRNJ/WU5kWnfXu/g=
=0QlT
-----END PGP SIGNATURE-----

--------------enigC8A3BA6D9DA093B77E00A528--


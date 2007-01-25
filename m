Message-ID: <45B88D14.4020909@domain.hid>
Date: Thu, 25 Jan 2007 11:57:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xenomai and CONFIG_PREEMPT_RT ?
References: <45B87D35.3070000@domain.hid>
In-Reply-To: <45B87D35.3070000@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig686B4BEDBC3E1B5120359669"
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
To: Steven Scholz <steven.scholz@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig686B4BEDBC3E1B5120359669
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Steven Scholz wrote:
> Hi all,
>=20
> is it possible (and reasonable) to use Ingo's real time patches from
> http://people.redhat.com/mingo/realtime-preempt combined with xenomai?

Starting to become a FAQ :). See also our roadmap or browse the mailing
list archive (e.g.
https://mail.gna.org/public/xenomai-help/2006-11/msg00336.html).

To repeat the essence:

 o Combining both patches is currently challenging due to both touching
   similar subsystems. Unless concrete requirements emerge, a combined
   patch may not appear before PREEMPT_RT is mainline (due to
   maintenance costs).

 o Xenomai for PREEMPT_RT is on our roadmap (also independently of
   PREEMPT_RT becoming mainline). It aims at supporting Xenomai's skins
   as-is over the PREEMPT_RT infrastructure as an alternative to the
   I-pipe/co-scheduling path, but will most probably not obsolete the
   latter.

 o There are application scenarios imaginable where the combined usage
   of both RT-technologies (I-pipe over PREEMPT_RT) would make sense and
   add value, but the common case with Xenomai will be to choose one
   base technology during system configuration.

Regarding the unavoidable question "When?": Resources are finite and
require careful schedule. So that schedule depends on users explaining
their needs for certain features, on contributors starting to commit
themselves on the development, or on sponsors pushing the work on
desired features.

Jan


--------------enig686B4BEDBC3E1B5120359669
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFuI0XniDOoMHTA+kRAie/AJ9HyD2DMQzlRbO1cfySRvT5GmRSfACePfVQ
zn9iVMe/hh/vSXSI73UFpqU=
=QC9D
-----END PGP SIGNATURE-----

--------------enig686B4BEDBC3E1B5120359669--


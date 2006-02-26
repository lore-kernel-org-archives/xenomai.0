Message-ID: <4401F8B4.9090707@domain.hid>
Date: Sun, 26 Feb 2006 19:51:32 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
References: <b647ffbd0602150939g59256b2bx@domain.hid>	<b647ffbd0602210254p19086a0au@domain.hid>	<43FAF94C.4080709@domain.hid>	<43FAFE58.5060201@domain.hid>	<b647ffbd0602210848g321ffedei@domain.hid>	<43FB480E.9020808@domain.hid>
	<43FB529B.3040207@domain.hid>	<43FB6102.1070004@domain.hid>	<b647ffbd0602220445k749d630j@domain.hid>	<43FDA8E2.5010806@domain.hid>
	<b647ffbd0602251214h36768b46o@domain.hid>
In-Reply-To: <b647ffbd0602251214h36768b46o@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB4D8B7848D427498505BCB33"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB4D8B7848D427498505BCB33
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> ...
> This said, I'm going to publish the shirq patch (after finalizing ISR r=
eturn
> bits,
> where I still have some doubts) without enable/disable nesting support.=

> It can be supported at some point of time later, if it's really needed.=

>=20

Regarding enable/disable nesting and existing driver patterns: I
currently do the following on devices init via RTDM (and users may have
copied this):

rtdm_irq_request(...);
<init_hardware, also clear pending IRQs of the device>
rtdm_irq_enable(...);

But I do not disable the IRQ before rtdm_irq_free() again. Is this
unbalanced enabling still needed today? Is it even wrong these days? Is
it arch-dependent? I think the pattern dates back in RTAI times and was
needed for so far unused IRQs. Disabling them on device closure blocked
the line for later use under Linux.

I'm asking now in case we have to change the usage: we may better do it
early (e.g. with the introduction of Xenomai 2.1), so that the number of
surprises can be kept low when the underlying mechanisms get reworked lat=
er.

Jan


--------------enigB4D8B7848D427498505BCB33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEAfi3niDOoMHTA+kRAtkIAJ9npUT/n7+IAlOjY1Y53iD7YlJRFwCfex0h
4MOQOcjsxOQ4/RqIRm/wj2k=
=ESG8
-----END PGP SIGNATURE-----

--------------enigB4D8B7848D427498505BCB33--


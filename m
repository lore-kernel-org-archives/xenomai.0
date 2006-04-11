Message-ID: <443C1D29.5020105@domain.hid>
Date: Tue, 11 Apr 2006 23:18:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [draft PATCH] nested enable/disable irq calls
References: <b647ffbd0604070805k32dc185fu4d3705906ffcbc2f@domain.hid>
In-Reply-To: <b647ffbd0604070805k32dc185fu4d3705906ffcbc2f@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig07DA81C59FEEA8AB9CE8DA67"
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig07DA81C59FEEA8AB9CE8DA67
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Dmitry Adamushko wrote:
> Hi,
>=20
> yep, this is yet another draft patch which aims at supporting the
> nested irq disable/enable calls for the primary domain.
>=20
> o  no changes on the adeos-ipipe layer, hence it's much cleaner and
> smaller that the one I have posted last time;
>=20
> o  eliminates the need for XN_ISR_NOENABLE flag;
>=20
> o  but is based on the presupposition (otherwise it's wrong) that for
> all acrhitectures that support Xenomai the following is true :
>=20
> 	pic_handler->ack :
> 	    * mask
> 	    * eoi
> =09
> 	pic_handler->end :
> 	    * unmask
> =09
> Philippe told me some time ago that this is a _must_ now for any arch
> to be compatible with adeos-ipipe.
>=20
> If so, with some minor cleanups (XN_ISR_NOENABLE should be removed all
> over the map,
> docs fixes, ...) and testing the patch may hopefully find its way into
> the codebase.
>=20
> Any feedback? =09
>=20

Yes, I do have some remarks: due to legacy issues (I think to remember),
we have a lot of unbalanced irq-enable/disable code out there. IRQs are
currently enabled after registering a handler, but are not disabled on
detach. That's because of problems with Linux when letting it take over
a disabled IRQ, and for the sake of shared-irqs. Thus, if we introduce
such a nestable enable/disable, we _must_ think about managing the side
effects in legacy code (I haven't thought about this in details yet).


Another thing I have on my mind ATM is providing an additional IRQ
model: threaded IRQs. This is certainly not the best default model, but
it could help in certain scenarios to reduce prio-inversions due to
overloaded IRQ handler jobs (like we face from time to time with devices
on the slow ISA-bus...).

I think this should be rather simple to implement with the existing
infrastructure. I'm just wondering if it should become a RTDM or a
nucleus feature. Any opinions? [I'm currently in favour of RTDM.]

A nice add-on to this model would be to capture timestamps in the hard
stub and to distribute it to the threaded handlers. That's quite
egoistic, as it would perfectly fit our needs again: low timestamp
jitter but schedulable IRQ jobs. :)

Jan


--------------enig07DA81C59FEEA8AB9CE8DA67
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEPB0pniDOoMHTA+kRAqPkAJ9UQf/PMPN9wZkHxNoKiylonAd5YQCfcdUW
7q1vkoE6SeNgjxUVsPp4DYs=
=51en
-----END PGP SIGNATURE-----

--------------enig07DA81C59FEEA8AB9CE8DA67--


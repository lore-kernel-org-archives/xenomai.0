Message-ID: <43C00A97.4020404@domain.hid>
Date: Sat, 07 Jan 2006 19:38:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [rfc] Building Linux kernel in Xenomai tree.
References: <17343.42595.626357.181448@domain.hid>
	<17344.665.154004.811426@domain.hid>
In-Reply-To: <17344.665.154004.811426@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF99B931B590AB3AAAE3842DC"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF99B931B590AB3AAAE3842DC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>  > Known limitations are:
>  > (...)
>  > - for an unknown reason, xenomai modules are built every time
>  >   prepare-kernel.sh is run ;
> 
> The reason for this limitation is that prepare-kernel.sh remove
> directories before re-creating them and before creating symbolic links.
> 

At this chance, something from my private whish list: :)

"unprepare-kernel.sh" or so, i.e. turning the kernel in its original
vanilla state again.

This is helpful when applying/reversing third-party kernel patches which
also touch the modified Makefiles. I think on some 2.4 kernel, even
reverting ipipe collides with the xeno-preparation.

> The previous patch was also incorrect when trying to cross-compile the
> Linux kernel or building it for ppc. The attached patch fixes these
> issues.
> 

Regarding your general idea, I'm just trying to imagine the new build
process: you prepare and build the kernel + the userspace stuff again in
one step?. But you still have to configure both parts separately.

The question for me is now if this simplifies the situation expecially
for beginners. So far, the separation was clearly visible, now it /may/
become blurred (but I'm not a beginner...).

Can you provide a rough comparision of the workflows? Sorry, but I'm too
lazy, I mean busy to give it a try.

Jan

--------------enigF99B931B590AB3AAAE3842DC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDwAqYniDOoMHTA+kRAsYvAJ4vwe8NaoEK4/RNwiidBj/O1pA/4wCePtga
netHp7q1aGQO8CMvbntj8Co=
=MoZe
-----END PGP SIGNATURE-----

--------------enigF99B931B590AB3AAAE3842DC--


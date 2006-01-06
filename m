Message-ID: <43BEBDC4.3020905@domain.hid>
Date: Fri, 06 Jan 2006 19:58:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Fix ppc fpu support
References: <43BEBA0D.5090708@domain.hid>
In-Reply-To: <43BEBA0D.5090708@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFE8F5322390593AD59D41B8D"
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
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFE8F5322390593AD59D41B8D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Heikki Lindholm wrote:
> Xenomai might preempt linux when linux has cleared a tasks MSR_FP, but
> not yet set last_task_used_math to NULL. As a result the tasks MSR_FP
> will get set, although it should be cleared. If the task happens to hit
> one of the codepaths that save FPU state if MSR_FP is set, the wrong FPU
> state might be saved to the task. The attached patch should fix this. I
> couldn't try it on most recent Xenomai trunk, because latency wouldn't
> build anymore. However, I see no reason it shouldn't work. All thee

Is it still broken with latest revision 376? Philippe had merged the fix
for my mess, and it worked at least for 2.6 on my box again.

> having trouble with X and Xenomai, give this a shot.
> 
> -- Heikki Lindholm
> 

Jan

--------------enigFE8F5322390593AD59D41B8D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDvr3EniDOoMHTA+kRAlf6AJ9RkXHYYhbNvTUq4SK57LJGFgt30ACfTTsU
pqo4g5JIVRRi4YEq1tRyq58=
=f8Sh
-----END PGP SIGNATURE-----

--------------enigFE8F5322390593AD59D41B8D--


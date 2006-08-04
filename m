Message-ID: <44D2E86C.4080608@domain.hid>
Date: Fri, 04 Aug 2006 08:25:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Interrupt Problem.
References: <20060803231039.7184.qmail@domain.hid>
In-Reply-To: <20060803231039.7184.qmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig781BEA860B21DDE4891BD29A"
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
To: shailesh joshi <zoshi_s@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig781BEA860B21DDE4891BD29A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

shailesh joshi wrote:
> The board is custom made, the PCI card is of the make ADLink but has no=
 Linux support. However, the same card worked for RTLinux, however, we ha=
d to drop the Idea for latency reasons.=20
>   =20
>   i am guessing i am doing something wrong while initialising the handl=
er. Like i said, the Card is generatimg the interript signal but linux is=
 not acknowledging it, aka, the code does not enter the handler....I am u=
sing a sleep function in the user application but i guess that does not a=
ffect the RT code oder?? I am a beginner so I might be sounding very stup=
id. I request you to bare with me for the time being till i sharpen up.
>   =20
>   Regards,
>   Shailesh.
>   =20
>   P.S: I am initialising the handler with rtdm_irq_request. Have also t=
ried rthal_irq_request. Any suggestions there??

rtdm_irq_request is the way to go, followed by rtdm_irq_enable. See also
the existing examples like Hannes code or irqbench. If still unsure,
post code so that we can have a look.

Jan


--------------enig781BEA860B21DDE4891BD29A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE0uhxniDOoMHTA+kRAqSLAJ9WVYy/WLDsOL7a0qfYKGuAZ6YulACfZlx7
/uOAjB2FUlc6C/AAMNKe6yY=
=ihZ/
-----END PGP SIGNATURE-----

--------------enig781BEA860B21DDE4891BD29A--


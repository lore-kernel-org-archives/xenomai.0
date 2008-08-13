Message-ID: <48A2BD34.2020601@domain.hid>
Date: Wed, 13 Aug 2008 12:53:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <001b01c8f600$0c5a5a60$09201fac@domain.hid>	<4896B492.4000404@domain.hid>	<005b01c8f615$db466930$09201fac@domain.hid>	<4896D6CC.1040103@domain.hid>
	<4896D85D.2010004@domain.hid>
In-Reply-To: <4896D85D.2010004@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7810C571F8292D8DF504707E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] Buffer over flow in /proc/xenomai/stat
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7810C571F8292D8DF504707E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Philippe Gerum wrote:
>> Atsushi-san,
>>
>> Atsushi Katagiri wrote:
>>> Yes, I actually encountered this bug and my Linux was crashed by NULL=
 pointer dereference.
>>>
>>> I think this is a very simple bug.
>>> It happens "everytime" we open /proc/xenomai/stat,
>>> because the last iter->nentries++; (line 466) surely reaches the valu=
e of the count,
>>> and the next iteration, line 449, surely overwrites zero on out of th=
e kmalloced area.
>>>
>> Please try this fix instead:
>>
>=20
> Actually, this one is better:
>=20
> --- ksrc/nucleus/module.c	(revision 4074)
> +++ ksrc/nucleus/module.c	(working copy)
> @@ -440,13 +440,13 @@
>  	/* Iterate over all IRQ numbers, ... */
>  	for (irq =3D 0; irq < XNARCH_NR_IRQS; irq++) {
>  		xnintr_t *prev =3D NULL;
> -		int cpu =3D 0;
> +		int cpu =3D 0, _cpu;
>  		int err;
>=20
>  		/* ...over all shared IRQs on all CPUs */
>  		while (1) {
>  			stat_info =3D &iter->stat_info[iter->nentries];
> -			stat_info->cpu =3D cpu;
> +			_cpu =3D cpu;
>=20
>  			err =3D xnintr_query(irq, &cpu, &prev, intr_rev,
>  					   stat_info->name,
> @@ -458,6 +458,7 @@
>  			if (err)
>  				break; /* line unused or end of chain */
>=20
> +			stat_info->cpu =3D _cpu;
>  			stat_info->pid =3D 0;
>  			stat_info->state =3D  0;
>  			stat_info->ssw =3D 0;
>=20

Good catch. But for the sake of telling variable names I would suggest:

Index: ksrc/nucleus/module.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/module.c	(Revision 4094)
+++ ksrc/nucleus/module.c	(Arbeitskopie)
@@ -444,15 +444,15 @@ static int stat_seq_open(struct inode *i
 	/* Iterate over all IRQ numbers, ... */
 	for (irq =3D 0; irq < XNARCH_NR_IRQS; irq++) {
 		xnintr_t *prev =3D NULL;
-		int cpu =3D 0, _cpu;
-		int err;
+		int next_cpu =3D 0;
+		int cpu, err;
=20
 		/* ...over all shared IRQs on all CPUs */
 		while (1) {
 			stat_info =3D &iter->stat_info[iter->nentries];
-			_cpu =3D cpu;
+			cpu =3D next_cpu;
=20
-			err =3D xnintr_query(irq, &cpu, &prev, intr_rev,
+			err =3D xnintr_query(irq, &next_cpu, &prev, intr_rev,
 					   stat_info->name,
 					   &stat_info->csw,
 					   &stat_info->exectime,
@@ -462,7 +462,7 @@ static int stat_seq_open(struct inode *i
 			if (err)
 				break; /* line unused or end of chain */
=20
-			stat_info->cpu =3D _cpu;
+			stat_info->cpu =3D cpu;
 			stat_info->pid =3D 0;
 			stat_info->state =3D  0;
 			stat_info->ssw =3D 0;


--------------enig7810C571F8292D8DF504707E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkiivTgACgkQniDOoMHTA+l5PgCfQemYIn70xXFnooUA4sfpdL7J
jZsAn2FLj5/hazhUO9einh1FN1DbQH8z
=MId1
-----END PGP SIGNATURE-----

--------------enig7810C571F8292D8DF504707E--


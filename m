Message-ID: <486E6E1D.2020209@domain.hid>
Date: Fri, 04 Jul 2008 20:38:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9923F4D3E23C249F420090E4"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] can: avoid naming conflict in 2.6.26
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9923F4D3E23C249F420090E4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Due to a global definition of 'clock' in latest 2.6.26, we now have a
problem with two rtcan drivers. Below is a fix that breaks those
drivers' user interface by rename the conflicting variable which
unfortunately also renames the module parameter name.

An alternative approach would be to add a kernel version dependent fix
to the drivers. That would be required as compat_module_param_array
cannot be extended to use a different parameter name than the related
variable is called. Maybe someone sees a third, better solution, I do
not.

Jan

Index: ksrc/drivers/can/sja1000/rtcan_isa.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/can/sja1000/rtcan_isa.c	(Revision 4017)
+++ ksrc/drivers/can/sja1000/rtcan_isa.c	(Arbeitskopie)
@@ -47,19 +47,19 @@ MODULE_LICENSE("GPL");
=20
 static u16 io[RTCAN_ISA_MAX_DEV];
 static int irq[RTCAN_ISA_MAX_DEV];
-static u32 clock[RTCAN_ISA_MAX_DEV];
+static u32 clock_freq[RTCAN_ISA_MAX_DEV];
 static u8 ocr[RTCAN_ISA_MAX_DEV];
 static u8 cdr[RTCAN_ISA_MAX_DEV];
=20
 compat_module_param_array(io, ushort, RTCAN_ISA_MAX_DEV, 0444);
 compat_module_param_array(irq, int, RTCAN_ISA_MAX_DEV, 0444);
-compat_module_param_array(clock, uint, RTCAN_ISA_MAX_DEV, 0444);
+compat_module_param_array(clock_freq, uint, RTCAN_ISA_MAX_DEV, 0444);
 compat_module_param_array(ocr, byte, RTCAN_ISA_MAX_DEV, 0444);
 compat_module_param_array(cdr, byte, RTCAN_ISA_MAX_DEV, 0444);
=20
 MODULE_PARM_DESC(io, "The io-port address");
 MODULE_PARM_DESC(irq, "The interrupt number");
-MODULE_PARM_DESC(clock, "External clock frequency (default 16 MHz)");
+MODULE_PARM_DESC(clock_freq, "External clock frequency (default 16 MHz)"=
);
 MODULE_PARM_DESC(ocr, "Value of output control register (default 0x1a)")=
;
 MODULE_PARM_DESC(cdr, "Value of clock divider register (default 0xc8");
=20
@@ -116,8 +116,8 @@ int __init rtcan_isa_init_one(int idx)
 	}
=20
 	/* Clock frequency in Hz */
-	if (clock[idx])
-		dev->can_sys_clock =3D clock[idx] / 2;
+	if (clock_freq[idx])
+		dev->can_sys_clock =3D clock_freq[idx] / 2;
 	else
 		dev->can_sys_clock =3D 8000000; /* 16/2 MHz */
=20
Index: ksrc/drivers/can/sja1000/rtcan_mem.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/can/sja1000/rtcan_mem.c	(Revision 4017)
+++ ksrc/drivers/can/sja1000/rtcan_mem.c	(Arbeitskopie)
@@ -55,19 +55,19 @@ MODULE_LICENSE("GPL");
=20
 static u32 mem[RTCAN_MEM_MAX_DEV];
 static int irq[RTCAN_MEM_MAX_DEV];
-static u32 clock[RTCAN_MEM_MAX_DEV];
+static u32 clock_freq[RTCAN_MEM_MAX_DEV];
 static u8 ocr[RTCAN_MEM_MAX_DEV];
 static u8 cdr[RTCAN_MEM_MAX_DEV];
=20
 compat_module_param_array(mem, uint, RTCAN_MEM_MAX_DEV, 0444);
 compat_module_param_array(irq, int, RTCAN_MEM_MAX_DEV, 0444);
-compat_module_param_array(clock, uint, RTCAN_MEM_MAX_DEV, 0444);
+compat_module_param_array(clock_freq, uint, RTCAN_MEM_MAX_DEV, 0444);
 compat_module_param_array(ocr, byte, RTCAN_MEM_MAX_DEV, 0444);
 compat_module_param_array(cdr, byte, RTCAN_MEM_MAX_DEV, 0444);
=20
 MODULE_PARM_DESC(mem, "The io-memory address");
 MODULE_PARM_DESC(irq, "The interrupt number");
-MODULE_PARM_DESC(clock, "External clock frequency (default 16 MHz)");
+MODULE_PARM_DESC(clock_freq, "External clock frequency (default 16 MHz)"=
);
 MODULE_PARM_DESC(ocr, "Value of output control register (default 0x1a)")=
;
 MODULE_PARM_DESC(cdr, "Value of clock divider register (default 0xc8");
=20
@@ -125,8 +125,8 @@ int __init rtcan_mem_init_one(int idx)
 	}
=20
 	/* Clock frequency in Hz */
-	if (clock[idx])
-		dev->can_sys_clock =3D clock[idx] / 2;
+	if (clock_freq[idx])
+		dev->can_sys_clock =3D clock_freq[idx] / 2;
 	else
 		dev->can_sys_clock =3D 8000000; /* 16/2 MHz */
=20


--------------enig9923F4D3E23C249F420090E4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkhubiIACgkQniDOoMHTA+kwPACbBXvydeQmVJRQBd+XuRM+Bas3
sX0An0radqhxovGtXMyLWwfKu7ToKTsb
=mCXt
-----END PGP SIGNATURE-----

--------------enig9923F4D3E23C249F420090E4--


Date: Fri, 27 Feb 2009 22:23:31 +0100
From: "gwenhael.goavec" <gwen@domain.hid>
Message-ID: <20090227222331.676b8ca3@domain.hid>
In-Reply-To: <49A6C448.7090906@domain.hid>
References: <d7143fa7afb9637a602a432e52eb35b4@domain.hid>
	<49A54246.60404@domain.hid>
	<1aedae1f462bc98ca512e1e6f0f18a43@domain.hid>
	<49A56043.7000009@domain.hid> <49A6C448.7090906@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Adeos-main] [PATCH] ipipe i.MXL freeze's boot
Reply-To: adeos-main@gna.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

On Thu, 26 Feb 2009 17:33:12 +0100
Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
wrote:
> >=20
>=20
> Hi Gwenha=EBl,
>=20
> any news about this issue ?
>=20
> Regards.
>=20
> --=20
>                                                  Gilles.
>=20

Yes,
I'm sorry for the late.
This patch seem correct for the Adeos i'MXL support.
The first part is only usefull for 2.6.27 and 2.6.28.
The second part is for 2.6.2{6,7,8}

Regards

Gwenha=EBl

Signed-off-by: gwenhael.goavec-merou@domain.hid

diff -ru a/arch/arm/mach-imx/irq.c b/arch/arm/mach-imx/irq.c
--- a/arch/arm/mach-imx/irq.c    2009-02-17 11:32:52.000000000 +0100
+++ b/arch/arm/mach-imx/irq.c       2009-02-23 14:12:43.000000000 +0100
@@ -35,7 +35,7 @@
 #include <asm/io.h>
=20
 #include <asm/mach/irq.h>
-#include <asm/arch/imx-regs.h>
+#include <mach/imx-regs.h>
=20
=20
 /* Used for IMX INTERRUPT priority: Still Experimental */=20
diff -ru a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
--- a/arch/arm/mach-imx/time.c	2009-02-25 17:03:34.000000000 +0100
+++ b/arch/arm/mach-imx/time.c	2009-02-25 16:36:16.000000000 +0100
@@ -294,6 +294,8 @@
 #ifdef CONFIG_IPIPE
 void __ipipe_mach_acktimer(void)
 {
+	uint32_t tstat;
+	tstat =3D IMX_TSTAT(TIMER_BASE);
 	IMX_TSTAT(TIMER_BASE) =3D 0;
 }
=20

=20


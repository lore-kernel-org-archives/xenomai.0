Message-ID: <4A96F641.30303@domain.hid>
Date: Thu, 27 Aug 2009 23:10:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2f7260f50908260246jed2b885q9c67375b19343920@domain.hid>	<4A9566C9.7000805@domain.hid>
	<2f7260f50908270146h4e80b012q22d00219e62233be@domain.hid>
In-Reply-To: <2f7260f50908270146h4e80b012q22d00219e62233be@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problem with PXA320 and xenomai 2.4.9
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?SW1hbm9sIE1hcnTDrW5leg==?= <imanolmc@domain.hid>
Cc: xenomai@xenomai.org

Imanol Mart=C3=ADnez wrote:
>>Please check that when starting from the configuration where you have
>>the bug, if you disable Xenomai (CONFIG_XENOMAI) and the interrupt
>>pipeline (CONFIG_IPIPE), the system works.
>=20
> This way it works, but when applying the patch it still does not work, =
I
> get the same error...

Ok. And with this one?

diff --git a/arch/arm/plat-pxa/gpio.c b/arch/arm/plat-pxa/gpio.c
index 9bb16fe..51b136e 100644
--- a/arch/arm/plat-pxa/gpio.c
+++ b/arch/arm/plat-pxa/gpio.c
@@ -253,7 +253,8 @@ void __ipipe_mach_demux_irq(unsigned irq, struct pt_r=
egs *re
                        while (n < BITS_PER_LONG) {
                                loop =3D 1;

-                               __ipipe_handle_irq(gpio_base + n, regs);
+                               __ipipe_handle_irq(
+                                       gpio_to_irq(gpio_base + n), regs)=
;
                                n =3D find_next_bit(&gedr, BITS_PER_LONG,=
 n + 1);
                        }
                }

--=20
					    Gilles.



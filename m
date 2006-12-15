Message-ID: <45827471.8000606@domain.hid>
Date: Fri, 15 Dec 2006 11:09:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Registering Interrupt Handler [Scanned]
References: <45814504.7050905@domain.hid> <4581526A.7010304@domain.hid>
	<45825668.3030703@domain.hid>
In-Reply-To: <45825668.3030703@domain.hid>
Content-Type: multipart/mixed; boundary="------------010702000209090109080707"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Niklaus Burren <niklaus.burren@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------010702000209090109080707
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Niklaus Burren wrote:
> Hello Gilles
> 
> Thank you for your tip. I use now this makro in the rt_intr_create() 
> function. Unfortunately it has no effect. The function int_handler() is 
> never called when I put a square signal to the correct GPIO pin.
> 
> Is there anything else I had to do?

Could you try applying the following patch and tell me what gets printed
when you put the square signal on the GPIO pin ?

-- 
                                                 Gilles Chanteperdrix

--------------010702000209090109080707
Content-Type: text/x-patch;
 name="ipipe-trace-pxa-irq-demux.diff"
Content-Disposition: inline;
 filename="ipipe-trace-pxa-irq-demux.diff"
Content-Transfer-Encoding: quoted-printable

Index: arch/arm/mach-pxa/irq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-pxa/irq.c	(r=C3=A9vision 2407)
+++ arch/arm/mach-pxa/irq.c	(copie de travail)
@@ -236,10 +236,14 @@
 		i =3D 4;
 #endif /* PXA_LAST_GPIO >=3D 96 */
 		for (; i; i--) {
+			printk("mask[%d] =3D 0x%08x\n", i - 1, mask[i - 1]);
 			loop |=3D mask[i - 1];
 			while (mask[i - 1]) {
 				irq =3D fls(mask[i - 1]) - 1;
 				mask[i - 1] &=3D ~(1 << irq);
+				printk("demux irq IRQ_GPIO(%d): %d\n",
+				       (i - 1) * 32 + irq,
+				       IRQ_GPIO((i - 1) * 32 + irq));
 				irq =3D IRQ_GPIO((i - 1) * 32 + irq);
=20
 				__ipipe_handle_irq(irq, regs);

--------------010702000209090109080707--


From: "George Pontis" <GPontis@z9.com>
Date: Mon, 4 Jun 2012 18:35:10 -0700
Message-ID: <008b01cd42bb$724478e0$56cd6aa0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: [Xenomai] adeos-ipipe-3.0.13-arm-1.18-09.patch broken
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This recently released patch appears to be broken with regard to patching
arch/arm/mach-at91/at91sam9g45.c.

The first section of the patch should be applied to around line 32 in
similar fashion to the patch for the other micros in the family. However, it
is being applied to an entirely different structure around line 320. The
resulting file fails to compile. I doctored up this section of the patch so
it would be applied in the correct place, and the kernel builds. The
incorrect section of the patch is at line 5146. The following edit can be a
useful patch to the patch, until officially re-released:

--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -32,6 +32,13 @@ .pfn		= __phys_to_pfn(AT91_BASE_SYS),
		.length		= SZ_16K,
		.type		= MT_DEVICE,
 	}, {
+#ifdef CONFIG_IPIPE
+		.virtual	= AT91_VA_BASE_TCB0,
+		.pfn		= __phys_to_pfn(AT91_BASE_TCB0),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+#endif /* CONFIG_IPIPE */
		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9G45_SRAM_SIZE,
		.pfn		= __phys_to_pfn(AT91SAM9G45_SRAM_BASE),
		.length		= AT91SAM9G45_SRAM_SIZE,

George




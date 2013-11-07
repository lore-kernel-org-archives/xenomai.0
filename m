From: Robert Berger <gmane@reliableembeddedsystems.com>
Date: Thu, 07 Nov 2013 18:29:13 -0200
Message-ID: <527BF819.6040505@reliableembeddedsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] XENO 2.6.3, ipipe 3.8.13, imx28 compile failure
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

Just as a heads up you might want to add this to latest and greatest
Xenomai version.

export XENOMAI_KERNEL_VER="v3.8.13"
export XENOMAI_USERLAND_VER="v2.6.3"
export IPIPE_PATCH="ipipe-core-3.8.13-arm-3.patch"

# patch needed:
v3.8.13/after-ipipe-patches/0001-implicit_declaration_of-ipipe_handle_demuxed_irq.patch

Index: linux-stable-xenomai/drivers/gpio/gpio-mxs.c
===================================================================
--- linux-stable-xenomai.orig/drivers/gpio/gpio-mxs.c   2013-11-06
00:58:18.737556529 +0200
+++ linux-stable-xenomai/drivers/gpio/gpio-mxs.c        2013-11-06
00:59:47.865555018 +0200
@@ -33,6 +33,7 @@
 #include <linux/slab.h>
 #include <linux/basic_mmio_gpio.h>
 #include <linux/module.h>
+#include <linux/ipipe.h>

 #define MXS_SET                0x4
 #define MXS_CLR                0x8

Regards,

Robert...Imagine if every Thursday your shoes exploded if you tied them
the usual way. This happens to us all the time with computers, and
nobody thinks of complaining.

My public pgp key is available,at:
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x90320BF1




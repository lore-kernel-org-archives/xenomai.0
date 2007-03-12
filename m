Subject: Re: [Adeos-main] Kernel 2.6.20.2
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <560b19a70703121502w10bedeb8o27114ccdcd7b57c@domain.hid>
References: <560b19a70703121100x2a4a751dt4fc87b0176c3d587@domain.hid>
	<17909.47427.625596.896918@domain.hid>
	<560b19a70703121502w10bedeb8o27114ccdcd7b57c@domain.hid>
Content-Type: text/plain
Date: Tue, 13 Mar 2007 00:04:46 +0100
Message-Id: <1173740686.15636.37.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Ze Manel <zemanel@domain.hid>
Cc: adeos-main@gna.org

On Mon, 2007-03-12 at 22:02 +0000, Ze Manel wrote:
> Sorry I didn't post it a second time, I patched kernel 2.6.20 and got
> the error and then got the 2.6.20.2 (the latest stable version) I
> thought it could have something to do, and got the same error, it was
> not a repost, more like a clarification of the problem, or an update
> on the problem. 
> Sorry if it didn't seem so.

This patch fixes the issue.

diff --git a/arch/i386/mach-generic/bigsmp.c b/arch/i386/mach-generic/bigsmp.c
index 8a210fa..5eeefc8 100644
--- a/arch/i386/mach-generic/bigsmp.c
+++ b/arch/i386/mach-generic/bigsmp.c
@@ -14,6 +14,7 @@
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/dmi.h>
+#include <linux/ipipe.h>
 #include <asm/mach-bigsmp/mach_apic.h>
 #include <asm/mach-bigsmp/mach_apicdef.h>
 #include <asm/mach-bigsmp/mach_ipi.h>
diff --git a/arch/i386/mach-generic/default.c b/arch/i386/mach-generic/default.c
index 8685208..bf9ceae 100644
--- a/arch/i386/mach-generic/default.c
+++ b/arch/i386/mach-generic/default.c
@@ -13,6 +13,7 @@
 #include <linux/string.h>
 #include <linux/smp.h>
 #include <linux/init.h>
+#include <linux/ipipe.h>
 #include <asm/mach-default/mach_apic.h>
 #include <asm/mach-default/mach_ipi.h>
 #include <asm/mach-default/mach_mpparse.h>
diff --git a/arch/i386/mach-generic/es7000.c b/arch/i386/mach-generic/es7000.c
index b8963a5..2fb7e7e 100644
--- a/arch/i386/mach-generic/es7000.c
+++ b/arch/i386/mach-generic/es7000.c
@@ -13,6 +13,7 @@
 #include <linux/string.h>
 #include <linux/smp.h>
 #include <linux/init.h>
+#include <linux/ipipe.h>
 #include <asm/mach-es7000/mach_apicdef.h>
 #include <asm/mach-es7000/mach_apic.h>
 #include <asm/mach-es7000/mach_ipi.h>
diff --git a/arch/i386/mach-generic/summit.c b/arch/i386/mach-generic/summit.c
index 74883cc..80f3dfd 100644
--- a/arch/i386/mach-generic/summit.c
+++ b/arch/i386/mach-generic/summit.c
@@ -13,6 +13,7 @@
 #include <linux/string.h>
 #include <linux/smp.h>
 #include <linux/init.h>
+#include <linux/ipipe.h>
 #include <asm/mach-summit/mach_apic.h>
 #include <asm/mach-summit/mach_apicdef.h>
 #include <asm/mach-summit/mach_ipi.h>

-- 
Philippe.




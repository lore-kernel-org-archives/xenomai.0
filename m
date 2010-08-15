Message-ID: <4C680219.6020600@domain.hid>
Date: Sun, 15 Aug 2010 17:04:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Xenomai for x86_32 UP on linux 2.6.34.4
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>


Hi,

for those who would like to build a linux 2.6.34.4 kernel for an
uniprocessor 32 bits x86, there is a compilation error fixed by the
following patch:

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index dfdb4db..79cbd1a 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -21,6 +21,7 @@
  *
  */

+#include <linux/jiffies.h>
 #include <linux/dmi.h>
 #include <linux/module.h>
 #include <asm/div64.h>

Regards.

-- 
					    Gilles.


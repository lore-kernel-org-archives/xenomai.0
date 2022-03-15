Message-ID: <2a90b47a-43ea-5754-aed4-56966388ddc9@siemens.com>
Date: Tue, 15 Mar 2022 20:00:23 +0100
MIME-Version: 1.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] arm64: ipipe: Fix section mismatch of __ipipe_tsc_register
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

The kernel warns:

The function dw_apb_clocksource_register() references
the function __init __ipipe_tsc_register().
This is often because dw_apb_clocksource_register lacks a __init
annotation or the annotation of __ipipe_tsc_register is wrong.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Developed for 5.4 but probably also 4.19 material.

 arch/arm64/kernel/ipipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ipipe.c b/arch/arm64/kernel/ipipe.c
index 9dcb54c636395..a60787230fd84 100644
--- a/arch/arm64/kernel/ipipe.c
+++ b/arch/arm64/kernel/ipipe.c
@@ -228,7 +228,7 @@ void __ipipe_root_sync(void)
 
 static struct __ipipe_tscinfo tsc_info;
 
-void __init __ipipe_tsc_register(struct __ipipe_tscinfo *info)
+void __ipipe_tsc_register(struct __ipipe_tscinfo *info)
 {
 	tsc_info = *info;
 	__ipipe_hrclock_freq = info->freq;
-- 
2.34.1


-- 
Siemens AG, Technology
Competence Center Embedded Linux


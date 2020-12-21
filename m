MIME-Version: 1.0
From: Bart Vissers <bvissers@e2mtechnologies.eu>
Date: Mon, 21 Dec 2020 10:49:21 +0100
Message-ID: <CAB+DZ3mffahwSUD_9vADZMQQek0LdhdVuO9ZL29vk-7SoDEn2Q@mail.gmail.com>
Subject: [PATCH] pipe_base.h: use tsc_khz for tsc-to-nanoseconds calculations
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This fixes a clock drift issue that is measurable with clocktest. The
change was suggested by Jan a while ago [0], I tested it again on 4.19.89.

[0] https://www.xenomai.org/pipermail/xenomai/2019-May/040929.html

Signed-off-by: Bart Vissers <bvissers@e2mtechnologies.eu>
---
 arch/x86/include/asm/ipipe_base.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/ipipe_base.h
b/arch/x86/include/asm/ipipe_base.h
index c09697b1f20c..ea2876aa62b9 100644
--- a/arch/x86/include/asm/ipipe_base.h
+++ b/arch/x86/include/asm/ipipe_base.h
@@ -58,14 +58,14 @@

 #include <asm/apicdef.h>

-extern unsigned int cpu_khz;
+extern unsigned int tsc_khz;

 static inline const char *ipipe_clock_name(void)
 {
     return "tsc";
 }

-#define __ipipe_cpu_freq    ({ u64 __freq = 1000ULL * cpu_khz; __freq; })
+#define __ipipe_cpu_freq    ({ u64 __freq = 1000ULL * tsc_khz; __freq; })
 #define __ipipe_hrclock_freq    __ipipe_cpu_freq

 #ifdef CONFIG_X86_32
-- 
2.20.1

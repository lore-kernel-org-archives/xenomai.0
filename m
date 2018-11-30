From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH][4.14] arm/ipipe: Fix section mismatch of __ipipe_tsc_register
Message-ID: <ba569ba8-d084-d2f0-ead5-995423c1baa7@siemens.com>
Date: Fri, 30 Nov 2018 21:09:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

CONFIG_DEBUG_SECTION_MISMATCH=y reports:

The function dw_apb_clocksource_register() references
the function __init __ipipe_tsc_register().

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/kernel/ipipe_tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/ipipe_tsc.c b/arch/arm/kernel/ipipe_tsc.c
index 0a8f79a0f24f..82107616e5c5 100644
--- a/arch/arm/kernel/ipipe_tsc.c
+++ b/arch/arm/kernel/ipipe_tsc.c
@@ -49,7 +49,7 @@ static void __ipipe_tsc_update_fn(unsigned long cookie)
 	add_timer(&ipipe_tsc_update_timer);
 }
 
-void __init __ipipe_tsc_register(struct __ipipe_tscinfo *info)
+void __ipipe_tsc_register(struct __ipipe_tscinfo *info)
 {
 	struct ipipe_tsc_value_t *vector_tsc_value;
 	unsigned long long wrap_ms;
-- 
2.16.4


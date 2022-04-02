From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 2/4] ARM: dovetail: fix up arch_dovetail_switch_finish()
 signature
Date: Sat,  2 Apr 2022 16:21:25 +0200
Message-Id: <20220402142127.944138-2-rpm@xenomai.org>
In-Reply-To: <20220402142127.944138-1-rpm@xenomai.org>
References: <20220402142127.944138-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 arch/arm/include/asm/dovetail.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/dovetail.h b/arch/arm/include/asm/dovetail.h
index 8f3a09391d06..ff754ff4d2db 100644
--- a/arch/arm/include/asm/dovetail.h
+++ b/arch/arm/include/asm/dovetail.h
@@ -25,7 +25,8 @@ static inline void arch_dovetail_exec_prepare(void)
 static inline void arch_dovetail_switch_prepare(bool leave_inband)
 { }
 
-static inline void arch_dovetail_switch_finish(bool enter_inband)
+static inline void arch_dovetail_switch_finish(bool enter_inband,
+					       unsigned int ti_work)
 { }
 
 #endif
-- 
2.34.1



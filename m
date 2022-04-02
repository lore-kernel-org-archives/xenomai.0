From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 3/4] arm64: dovetail: fix up arch_dovetail_switch_finish()
 signature
Date: Sat,  2 Apr 2022 16:21:26 +0200
Message-Id: <20220402142127.944138-3-rpm@xenomai.org>
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
 arch/arm64/include/asm/dovetail.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/dovetail.h b/arch/arm64/include/asm/dovetail.h
index 668679399406..f1c6605972cf 100644
--- a/arch/arm64/include/asm/dovetail.h
+++ b/arch/arm64/include/asm/dovetail.h
@@ -27,7 +27,8 @@ static inline void arch_dovetail_exec_prepare(void)
 static inline void arch_dovetail_switch_prepare(bool leave_inband)
 { }
 
-static inline void arch_dovetail_switch_finish(bool enter_inband)
+static inline void arch_dovetail_switch_finish(bool enter_inband,
+					       unsigned int ti_work)
 {
 	fpsimd_restore_current_oob();
 }
-- 
2.34.1



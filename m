From: Romain Naour <romain.naour@gmail.com>
Date: Fri, 14 Apr 2017 15:08:01 +0200
Message-Id: <20170414130801.16915-1-romain.naour@gmail.com>
Subject: [Xenomai] [PATCH] arm: enable armv5tej support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

armv5tej are not detected in lib/cobalt/arch/arm/include/asm/xenomai/features.h

Apply the same patch from xenomai-2.6:
https://git.xenomai.org/xenomai-2.6.git/commit/?id=ebc2779baa222db4a5936c3d3022803355585b8c

Signed-off-by: Romain Naour <romain.naour@gmail.com>
---
 lib/cobalt/arch/arm/include/asm/xenomai/features.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/features.h b/lib/cobalt/arch/arm/include/asm/xenomai/features.h
index 10bd0c7..e84b809 100644
--- a/lib/cobalt/arch/arm/include/asm/xenomai/features.h
+++ b/lib/cobalt/arch/arm/include/asm/xenomai/features.h
@@ -34,7 +34,8 @@
 #endif /* armv4 */
 
 #if defined(__ARM_ARCH_5__) || defined(__ARM_ARCH_5T__) \
-	|| defined(__ARM_ARCH_5E__) || defined(__ARM_ARCH_5TE__)
+	|| defined(__ARM_ARCH_5E__) || defined(__ARM_ARCH_5TE__) \
+	|| defined(__ARM_ARCH_5TEJ__)
 #define __LINUX_ARM_ARCH__ 5
 #endif /* armv5 */
 
-- 
2.9.3



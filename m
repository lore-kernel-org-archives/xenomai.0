From: Romain Naour <romain.naour@openwide.fr>
Date: Sat, 28 Dec 2013 13:31:14 +0100
Message-Id: <1388233874-6599-2-git-send-email-romain.naour@openwide.fr>
In-Reply-To: <1388233874-6599-1-git-send-email-romain.naour@openwide.fr>
References: <1388233874-6599-1-git-send-email-romain.naour@openwide.fr>
Subject: [Xenomai] [PATCH 1/1] arm: enable armv5tej support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

armv5tej are not detected in include/asm-arm/features.h

fixes: http://autobuild.buildroot.net/results/e3b/e3b534dafb6dd7d788b0c3629ccc0b25702790f0/build-end.log

Signed-off-by: Romain Naour <romain.naour@openwide.fr>
---
 include/asm-arm/features.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/asm-arm/features.h b/include/asm-arm/features.h
index b83ac2c..45aaf2c 100644
--- a/include/asm-arm/features.h
+++ b/include/asm-arm/features.h
@@ -57,7 +57,8 @@
 #endif /* armv4 */
 
 #if defined(__ARM_ARCH_5__) || defined(__ARM_ARCH_5T__) \
-	|| defined(__ARM_ARCH_5E__) || defined(__ARM_ARCH_5TE__)
+	|| defined(__ARM_ARCH_5E__) || defined(__ARM_ARCH_5TE__) \
+	|| defined(__ARM_ARCH_5TEJ__)
 #define __LINUX_ARM_ARCH__ 5
 #endif /* armv5 */
 
-- 
1.8.1.4



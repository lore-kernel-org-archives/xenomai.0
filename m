From: Philippe Gerum <rpm@xenomai.org>
Date: Wed, 5 Sep 2018 17:21:58 +0200
Message-Id: <E1fxZtO-0005u2-2j@xenomai.org>
Subject: [Xenomai] [I-PIPE][PATCH 2/7] arm64: context_tracking: disable if
 CONFIG_IPIPE
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dmitriy Cherkasov <dmitriy@oss-tech.org>
Cc: xenomai@xenomai.org

Context tracking does not cope well with interrupt pipelining
currently: disable the former for now.
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 2533e99232b0..0a5e8dfd8df9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -82,7 +82,7 @@ config ARM64
 	select HAVE_CC_STACKPROTECTOR
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
-	select HAVE_CONTEXT_TRACKING
+	select HAVE_CONTEXT_TRACKING if !IPIPE
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_API_DEBUG
-- 
2.14.4



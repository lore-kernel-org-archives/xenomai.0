From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:38:09 +0200
Message-Id: <20180925103809.4932-33-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 32/32] x86: ipipe: disable 32bit support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 81a5afe38b18..4d5443084069 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -145,7 +145,7 @@ config X86
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK	if X86_64
 	select HAVE_IRQ_TIME_ACCOUNTING
-	select HAVE_IPIPE_SUPPORT
+	select HAVE_IPIPE_SUPPORT		if X86_64
 	select HAVE_IPIPE_TRACER_SUPPORT
 	select IPIPE_HAVE_SAFE_THREAD_INFO if IPIPE
 	select IPIPE_WANT_PTE_PINNING if IPIPE
-- 
2.14.4



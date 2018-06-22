From: Abel Vesa <abel.vesa@nxp.com>
Date: Fri, 22 Jun 2018 10:47:42 +0300
Message-Id: <1529653662-25891-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Xenomai]  arm: Kconfig: make LOCKDEP depend on !IPIPE
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

LOCKDEP is not yet supported on arm. By disabling LOCKDEP when IPIPE is enabled
we get rid of the LOCKDEP warnings.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 11ddea6..1814aab 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -168,6 +168,7 @@ config HAVE_LATENCYTOP_SUPPORT
 
 config LOCKDEP_SUPPORT
 	bool
+	depends on !IPIPE
 	default y
 
 config TRACE_IRQFLAGS_SUPPORT
-- 
2.7.4



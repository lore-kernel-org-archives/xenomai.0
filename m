From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 13/13] cobalt/assert: pipeline: add TODO() marker
Date: Sun, 31 Jan 2021 15:45:40 +0100
Message-Id: <20210131144540.243363-13-rpm@xenomai.org>
In-Reply-To: <20210131144540.243363-1-rpm@xenomai.org>
References: <20210131144540.243363-1-rpm@xenomai.org>
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

As its name suggests, TODO() can be added to the code in order to
highlight a place where some implementation bits are known to be
missing. Turning on CONFIG_XENO_TODO reveals the places where such
markers might linger by triggering a build time assertion, so that
they don't go unnoticed.

We may drop this helper when the port to Dovetail is complete.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/assert.h | 2 ++
 kernel/cobalt/Kconfig          | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/cobalt/kernel/assert.h b/include/cobalt/kernel/assert.h
index 7d9433abc..8d004476b 100644
--- a/include/cobalt/kernel/assert.h
+++ b/include/cobalt/kernel/assert.h
@@ -58,6 +58,8 @@
 	do { } while (0)
 #endif
 
+#define TODO()    BUILD_BUG_ON(IS_ENABLED(CONFIG_XENO_TODO))
+
 #define primary_mode_only()	XENO_BUG_ON(CONTEXT, is_secondary_domain())
 #define secondary_mode_only()	XENO_BUG_ON(CONTEXT, !is_secondary_domain())
 #define interrupt_only()	XENO_BUG_ON(CONTEXT, !xnsched_interrupt_p())
diff --git a/kernel/cobalt/Kconfig b/kernel/cobalt/Kconfig
index ead4740c1..a266011d4 100644
--- a/kernel/cobalt/Kconfig
+++ b/kernel/cobalt/Kconfig
@@ -485,3 +485,9 @@ config XENO_OPT_WATCHDOG_TIMEOUT
 	  Watchdog timeout value (in seconds).
 
 endif # XENO_OPT_DEBUG
+
+config XENO_TODO
+	bool "Reveal TODO places"
+	help
+	  This option causes a build time assertion to trigger
+	  when the TODO() marker is found in the compiled code.
-- 
2.26.2



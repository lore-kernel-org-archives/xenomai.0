From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH Dovetail 08/13] cobalt/build: pipeline: select IPIPE layer
 only if present
Date: Sat,  2 Jan 2021 10:33:48 +0100
Message-Id: <20210102093353.3195090-9-rpm@xenomai.org>
In-Reply-To: <20210102093353.3195090-1-rpm@xenomai.org>
References: <20210102093353.3195090-1-rpm@xenomai.org>
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

We may be able to build against a Dovetail-enabled kernel at some
point, so do not force-enable CONFIG_IPIPE, it might not be there.

At this chance, remove obsolete internal switches and conditions. All
I-pipe implementations depend on the GENERIC_CLOCKEVENTS framework,
and support for the legacy I-pipe V1 API is long gone.

No functional change is introduced.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 scripts/Kconfig.frag | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/scripts/Kconfig.frag b/scripts/Kconfig.frag
index f2e89a896..319683369 100644
--- a/scripts/Kconfig.frag
+++ b/scripts/Kconfig.frag
@@ -1,8 +1,8 @@
 menuconfig XENOMAI
 	depends on X86_TSC || !X86
 	bool "Xenomai/cobalt"
-	select IPIPE
-	select IPIPE_WANT_APIREV_2
+	select IPIPE if HAVE_IPIPE_SUPPORT
+	select IPIPE_WANT_APIREV_2 if IPIPE
 	default y
 	help
 	  Xenomai's Cobalt core is a real-time extension to the Linux
@@ -30,10 +30,6 @@ comment "or CPU idle features is enabled. Any of these options may"
 comment "cause troubles with Xenomai. You should disable them."
 endif
 
-if !GENERIC_CLOCKEVENTS
-comment "NOTE: Xenomai 3.x requires CONFIG_GENERIC_CLOCKEVENTS"
-endif
-
 config XENO_VERSION_MAJOR
        int
        default @VERSION_MAJOR@
-- 
2.26.2



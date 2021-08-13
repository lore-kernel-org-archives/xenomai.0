From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH] linux-xenomai: Add tracing support to arm64
Date: Fri, 13 Aug 2021 13:36:44 +0200
Message-Id: <20210813113644.49755-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The tracing support was disabled on arm64 but enabled on all other
targets we support. Taking the trace configuration from armhf to be able
to trace on arm64 as well.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 recipes-kernel/linux/files/arm64_defconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/files/arm64_defconfig b/recipes-kernel/linux/files/arm64_defconfig
index a010c30..9bacb82 100644
--- a/recipes-kernel/linux/files/arm64_defconfig
+++ b/recipes-kernel/linux/files/arm64_defconfig
@@ -6000,7 +6000,10 @@ CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
 CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
 CONFIG_HAVE_C_RECORDMCOUNT=y
 CONFIG_TRACING_SUPPORT=y
-# CONFIG_FTRACE is not set
+CONFIG_EVENT_TRACING=y
+CONFIG_CONTEXT_SWITCH_TRACER=y
+CONFIG_TRACING=y
+CONFIG_FTRACE=y
 # CONFIG_DMA_API_DEBUG is not set
 
 #
-- 
2.30.2



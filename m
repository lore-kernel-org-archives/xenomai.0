From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 4/9] cobalt/posix: Add required FORCE makefile rule
Date: Wed, 13 Oct 2021 13:55:48 +0200
Message-Id: <de29cc6c97f25b8f13897afb1d4fd89521527eaf.1634126152.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1634126152.git.jan.kiszka@siemens.com>
References: <cover.1634126152.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Enforced by recent kernels.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/posix/Makefile b/kernel/cobalt/posix/Makefile
index e941b50114..5b4f3214a0 100644
--- a/kernel/cobalt/posix/Makefile
+++ b/kernel/cobalt/posix/Makefile
@@ -26,9 +26,9 @@ xenomai-y :=		\
 syscall_entries := $(srctree)/$(src)/gen-syscall-entries.sh
 
 quiet_cmd_syscall_entries = GEN     $@
-      cmd_syscall_entries = $(CONFIG_SHELL) '$(syscall_entries)' $^ > $@
+      cmd_syscall_entries = $(CONFIG_SHELL) '$(syscall_entries)' $(filter-out FORCE,$^) > $@
 
-$(obj)/syscall_entries.h: $(syscall_entries) $(wildcard $(srctree)/$(src)/*.c)
+$(obj)/syscall_entries.h: $(syscall_entries) $(wildcard $(srctree)/$(src)/*.c) FORCE
 	$(call if_changed,syscall_entries)
 
 target += syscall_entries.h
-- 
2.31.1



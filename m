From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] dovetail: Adjust EXIT_SYSCALL_* values to avoid clash with
 seccomp
Message-ID: <35bbd40e-b5ea-a2e4-c01b-282850b84eee@siemens.com>
Date: Thu, 11 Nov 2021 19:57:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>, Ando Yuta <andouyuuta@yamaha-motor.co.jp>

From: Jan Kiszka <jan.kiszka@siemens.com>

__secure_computing, called by syscall_trace_enter, returns -1 when a
call should be skipped. We must avoid that this is interpreted as
EXIT_SYSCALL_OOB in the dovetail case.

Fixes, e.g., crashes of Chrome in sandbox mode.

Reported-by: Ando Yuta <andouyuuta@yamaha-motor.co.jp>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

"Fixes" is my observation - Yuta-san, please confirm also for your setup.

 include/linux/entry-common.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 2a08b00632b9..43cf846111d9 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -66,8 +66,8 @@
  * Status codes of syscall entry when Dovetail is enabled. Must not
  * conflict with valid syscall numbers.
  */
-#define EXIT_SYSCALL_OOB	(-1)
-#define EXIT_SYSCALL_TAIL	(-2)
+#define EXIT_SYSCALL_OOB	(-2)
+#define EXIT_SYSCALL_TAIL	(-3)
 
 /**
  * arch_check_user_regs - Architecture specific sanity check for user mode regs
-- 
2.31.1


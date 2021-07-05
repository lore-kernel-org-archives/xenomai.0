From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 7/9] cobalt/posix/syscall32: Mark compat clock_nanosleep
 restartable
Date: Mon,  5 Jul 2021 09:36:39 +0200
Message-Id: <ffca672400c0f151dc0ee3b25c12f1cad06c033d.1625470600.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1625470600.git.jan.kiszka@siemens.com>
References: <cover.1625470600.git.jan.kiszka@siemens.com>
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

Commit 36132cdb21cd forgot to align this with the native syscall.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/syscall32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 5a6de285f9..c298f38f5a 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -229,7 +229,7 @@ COBALT_SYSCALL32emu(clock_adjtime64, current,
 }
 
 
-COBALT_SYSCALL32emu(clock_nanosleep, nonrestartable,
+COBALT_SYSCALL32emu(clock_nanosleep, primary,
 		    (clockid_t clock_id, int flags,
 		     const struct old_timespec32 __user *u_rqt,
 		     struct old_timespec32 __user *u_rmt))
-- 
2.26.2



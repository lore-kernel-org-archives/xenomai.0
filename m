From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 2/9] cobalt/posix/io: Avoid err variable shadowing
Date: Mon,  5 Jul 2021 09:36:34 +0200
Message-Id: <b2729f9f5358ffc6fbac9ad0b30dc98c584c4262.1625470600.git.jan.kiszka@siemens.com>
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

It worked, but it is not nice to read.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/io.c        | 8 ++++----
 kernel/cobalt/posix/syscall32.c | 7 ++++---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index 49191cda8d..70dd3c9c55 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -291,11 +291,11 @@ COBALT_SYSCALL(select, primary,
 
 	do {
 		err = xnselect(selector, out_fds, in_fds, nfds, timeout, mode);
-
 		if (err == -ECHRNG) {
-			int err = __cobalt_select_bind_all(selector, out_fds, nfds);
-			if (err)
-				return err;
+			int bind_err = __cobalt_select_bind_all(selector,
+								out_fds, nfds);
+			if (bind_err)
+				return bind_err;
 		}
 	} while (err == -ECHRNG);
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 29c99bd05a..98b9218a81 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -814,9 +814,10 @@ COBALT_SYSCALL32emu(select, nonrestartable,
 	do {
 		err = xnselect(selector, out_fds, in_fds, nfds, timeout, mode);
 		if (err == -ECHRNG) {
-			int err = __cobalt_select_bind_all(selector, out_fds, nfds);
-			if (err)
-				return err;
+			int bind_err = __cobalt_select_bind_all(selector,
+								out_fds, nfds);
+			if (bind_err)
+				return bind_err;
 		}
 	} while (err == -ECHRNG);
 
-- 
2.26.2



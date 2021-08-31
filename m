From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 1/5] dovetail: add out-of-band open mode (O_OOB)
Date: Tue, 31 Aug 2021 10:27:05 +0200
Message-Id: <20210831082709.1296249-2-rpm@xenomai.org>
In-Reply-To: <20210831082709.1296249-1-rpm@xenomai.org>
References: <20210831082709.1296249-1-rpm@xenomai.org>
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

We need a specific open mode denoting a user request for enabling
out-of-band capabilities (if supported). This enables regular in-band
drivers to be extended with such capabilities, turning them on upon
user request for the files they manage.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 fs/fcntl.c                       | 2 +-
 include/linux/fcntl.h            | 2 +-
 include/uapi/asm-generic/fcntl.h | 8 ++++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 05b36b28f2e87fb..6bf8e931cfd394e 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1035,7 +1035,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC | __FMODE_NONOTIFY));
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 921e750843e660c..1866384312f6daf 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -10,7 +10,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_OOB)
 
 /* List of all valid flags for the how->upgrade_mask argument: */
 #define VALID_UPGRADE_FLAGS \
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 9dc0bf0c5a6ee89..346529426f91720 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -89,6 +89,14 @@
 #define __O_TMPFILE	020000000
 #endif
 
+/*
+ * Tells the open call that out-of-band operations should be enabled
+ * for the file (if supported).
+ */
+#ifndef O_OOB
+#define O_OOB		010000000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 #define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)      
-- 
2.31.1



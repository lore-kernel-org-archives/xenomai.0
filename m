From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 4/9] cobalt/rtdm/fd: Fix error code documentation of
 rtdm_fd_select
Date: Mon,  5 Jul 2021 09:36:36 +0200
Message-Id: <8b9e18e10d42f1c54a9d4889b5b8be8ab5fd1085.1625470600.git.jan.kiszka@siemens.com>
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

It also returns -EADV since 2db562ad62ec - causing troubles in select.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/rtdm/fd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index cbaece1327..e5e0c02376 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -938,7 +938,11 @@ int rtdm_fd_valid_p(int ufd)
  *
  * @return 0 on success, otherwise:
  *
- * - -EBADF is returned if the file descriptor @a ufd cannot be resolved.
+ * - -EADV is returned if the file descriptor @a ufd cannot be resolved.
+ *
+ * - -EBADF is returned if the underlying device is being torn down at the time
+ *   of the call.
+ *
  * - -EINVAL is returned if @a type is invalid.
  *
  * @coretags{task-unrestricted}
-- 
2.26.2



From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/9] cobalt/posix/io: Remove unneeded special case of
 select_bind_one
Date: Mon,  5 Jul 2021 09:36:33 +0200
Message-Id: <50c0367ddc4794e868c1d59258a3971c14aaec39.1625470600.git.jan.kiszka@siemens.com>
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

Already at the time of introduction (8ac3db811d21), -ENOENT was not
returned by any sane function behind rtdm_fd_select(). Today
rtdm_fd_select() officially only returns -EBADF or -EINVAL. By now it
also returns -EADV, via rtdm_fd_get() or a default select handler. The
only remaining possibility for -ENOENT is a select handler. In-tree,
a4l_rt_select actually has such a case, but for no sane reason this or
any out-of-tree driver case should receive special handling here.

Remove this case, these is also no need for the select_bind_one wrapper
anymore.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/io.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index 97a1f6afcd..49191cda8d 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -180,17 +180,6 @@ int __cobalt_first_fd_valid_p(fd_set *fds[XNSELECT_MAX_TYPES], int nfds)
 	return 1;
 }
 
-static int select_bind_one(struct xnselector *selector, unsigned type, int fd)
-{
-	int rc;
-
-	rc = rtdm_fd_select(fd, selector, type);
-	if (rc != -ENOENT)
-		return rc;
-
-	return -EBADF;
-}
-
 int __cobalt_select_bind_all(struct xnselector *selector,
 			     fd_set *fds[XNSELECT_MAX_TYPES], int nfds)
 {
@@ -203,7 +192,7 @@ int __cobalt_select_bind_all(struct xnselector *selector,
 			for (fd = find_first_bit(set->fds_bits, nfds);
 			     fd < nfds;
 			     fd = find_next_bit(set->fds_bits, nfds, fd + 1)) {
-				err = select_bind_one(selector, type, fd);
+				err = rtdm_fd_select(fd, selector, type);
 				if (err)
 					return err;
 			}
-- 
2.26.2



From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 3/9] cobalt/rtdm/fd: Fix comment typo
Date: Mon,  5 Jul 2021 09:36:35 +0200
Message-Id: <69fd5cb30e5fec6d1d60266fa4f535b9b47d4e20.1625470600.git.jan.kiszka@siemens.com>
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/rtdm/fd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index 151884a240..cbaece1327 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -223,7 +223,7 @@ int rtdm_device_new_fd(struct rtdm_fd *fd, int ufd,
  * - ERR_PTR(-EADV) if the use-space handle is either invalid, or not
  * managed by RTDM.
  *
- * - ERR_PTR(-EBADF) if the underlying device is being torned down at
+ * - ERR_PTR(-EBADF) if the underlying device is being torn down at
  * the time of the call.
  *
  * @note The file descriptor returned must be later released by a call
-- 
2.26.2



From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 3/4] cobalt/syscall: use raw_printk() for serial debug output
Date: Sat,  5 Dec 2020 13:00:13 +0100
Message-Id: <20201205120014.2754097-4-rpm@xenomai.org>
In-Reply-To: <20201205120014.2754097-1-rpm@xenomai.org>
References: <20201205120014.2754097-1-rpm@xenomai.org>
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

__ipipe_serial_debug() is a legacy wrapper to the current raw_printk()
service. Drop the last in-tree reference to this obsolete call.

No functional change is introduced.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/posix/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index a9c979903..0a09322be 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -262,7 +262,7 @@ static COBALT_SYSCALL(serialdbg, current,
 			n = sizeof(buf);
 		if (cobalt_copy_from_user(buf, u_msg, n))
 			return -EFAULT;
-		__ipipe_serial_debug("%.*s", n, buf);
+		raw_printk("%.*s", n, buf);
 		u_msg += n;
 		len -= n;
 	}
-- 
2.26.2



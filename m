From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 1/8] lib/cobalt: init: fix misleading message
Date: Sat,  1 Jun 2019 17:14:55 +0200
Message-Id: <20190601151502.27216-2-rpm@xenomai.org>
In-Reply-To: <20190601151502.27216-1-rpm@xenomai.org>
References: <20190601151502.27216-1-rpm@xenomai.org>
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 lib/cobalt/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/cobalt/init.c b/lib/cobalt/init.c
index 7d19c6c31..02a99c569 100644
--- a/lib/cobalt/init.c
+++ b/lib/cobalt/init.c
@@ -163,7 +163,7 @@ static void low_init(void)
 		early_panic("ABI mismatch: required r%lu, provided r%lu",
 			    XENOMAI_ABI_REV, f->feat_abirev);
 	case -EAGAIN:
-		early_panic("Cobalt core present but disabled "
+		early_panic("Cobalt core present but stopped "
 			    "(use corectl --start)");
 	case -ENOSYS:
 		early_panic("Cobalt core not enabled in kernel");
-- 
2.20.1



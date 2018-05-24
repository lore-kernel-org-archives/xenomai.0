From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Thu, 24 May 2018 19:44:52 +0200
Message-Id: <3426c8aa475b8c006b7a38f685a98e3dd40cc98c.1527183892.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1527183892.git.jan.kiszka@siemens.com>
References: <cover.1527183892.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1527183892.git.jan.kiszka@siemens.com>
References: <cover.1527183892.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 1/2] cobalt/posix/sem: Fix semaphore leak on
	failing xnmalloc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Properly destroy the semaphore in case we cannot allocate a
cobalt_named_sem struct.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/nsem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/posix/nsem.c b/kernel/cobalt/posix/nsem.c
index 0cc686088..bf2157d35 100644
--- a/kernel/cobalt/posix/nsem.c
+++ b/kernel/cobalt/posix/nsem.c
@@ -125,8 +125,10 @@ sem_open(struct cobalt_process *process,
 	}
 
 	u = xnmalloc(sizeof(*u));
-	if (u == NULL)
+	if (u == NULL) {
+		__cobalt_sem_destroy(handle);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	u->sem = sem;
 	u->usem = ushadow;
-- 
2.13.6



From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 3/3] vxworks/mempart: fix error status upon failure to create
 partition
Date: Wed, 14 Nov 2018 11:41:52 +0100
Message-Id: <20181114104152.11627-3-rpm@xenomai.org>
In-Reply-To: <20181114104152.11627-1-rpm@xenomai.org>
References: <20181114104152.11627-1-rpm@xenomai.org>
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
 lib/vxworks/memPartLib.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/vxworks/memPartLib.c b/lib/vxworks/memPartLib.c
index 22d77bdcf..c8eeb3617 100644
--- a/lib/vxworks/memPartLib.c
+++ b/lib/vxworks/memPartLib.c
@@ -48,17 +48,21 @@ PART_ID memPartCreate(char *pPool, unsigned int poolSize)
 	pthread_mutexattr_t mattr;
 	struct wind_mempart *mp;
 	struct service svc;
+	int ret;
 
 	CANCEL_DEFER(svc);
 
 	mp = xnmalloc(sizeof(*mp));
-	if (mp == NULL)
+	if (mp == NULL) {
+		errno = S_memLib_NOT_ENOUGH_MEMORY;
 		goto fail;
+	}
 
-	if (__heapobj_init(&mp->hobj, NULL, poolSize, pPool)) {
+	ret = __heapobj_init(&mp->hobj, NULL, poolSize, pPool);
+	if (ret) {
 		xnfree(mp);
+		errno = S_memLib_INVALID_NBYTES;
 	fail:
-		errno = S_memLib_NOT_ENOUGH_MEMORY;
 		CANCEL_RESTORE(svc);
 		return (PART_ID)0;
 	}
-- 
2.17.2



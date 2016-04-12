From: Jeffrey Melville <jmelville@mitre.org>
Date: Tue, 12 Apr 2016 17:51:10 -0400
Message-ID: <1460497870-26014-1-git-send-email-jmelville@mitre.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Xenomai] [PATCH] posix: fix pthread_mutex_timedlock for recursive
	mutexes.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Fix erroneous returns of -EBUSY when calling pthread_mutex_timedlock on
a recursive mutex already locked by the calling thread.

Signed-off-by: Jeffrey Melville <jmelville@mitre.org>
---
 src/skins/posix/mutex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/skins/posix/mutex.c b/src/skins/posix/mutex.c
index 0cf2d8b..0323fe0 100644
--- a/src/skins/posix/mutex.c
+++ b/src/skins/posix/mutex.c
@@ -265,6 +265,7 @@ int __wrap_pthread_mutex_timedlock(pthread_mutex_t *mutex,
 			}
 
 			++shadow->lockcnt;
+			err = 0;
 			goto out;
 		}
 
-- 
1.9.1



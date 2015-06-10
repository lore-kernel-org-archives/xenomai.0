From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 10 Jun 2015 16:39:25 -0400
Message-ID: <20150610203925.GA11561@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] [PATCH] ksrc: Fix pthread_create return value sign when
 xnthread_register fails
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Len Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

xnthread_register returns negative errors, but pthread_create returns
positive errors, so the return value has to be negated before being
passed on, otherwise the caller of pthread_create will use the return
value as a valid thread id.

Signed-off-by: Len Sorensen <lsorense@csclub.uwaterloo.ca>
---
 ksrc/skins/posix/thread.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ksrc/skins/posix/thread.c b/ksrc/skins/posix/thread.c
index f1a96f7..05ccf63 100644
--- a/ksrc/skins/posix/thread.c
+++ b/ksrc/skins/posix/thread.c
@@ -258,7 +258,7 @@ int pthread_create(pthread_t *tid,
 	ret = xnthread_register(&thread->threadbase, "");
 	if (ret) {
 		thread_destroy(thread);
-		return ret;
+		return -ret;
 	}
 
 	*tid = thread;		/* Must be done before the thread is started. */
-- 
1.7.10.4


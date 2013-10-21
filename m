Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <c63fca9992458b6b8711.1382364572@devws164.be.alcatel-lucent.com>
In-Reply-To: <patchbomb.1382364570@devws164.be.alcatel-lucent.com>
References: <patchbomb.1382364570@devws164.be.alcatel-lucent.com>
Date: Mon, 21 Oct 2013 16:09:32 +0200
From: Kim De Mey <kim.demey@gmail.com>
Subject: [Xenomai] [PATCH 2 of 3 v2] Xenomai-forge notifier_init: warning on
	failed pipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Give a warning if one of the pipe() system calls fails. To indicate that there
is an underlying problem. Also add an assert on the notifier_init return
value in threadobj_setup_coresp.

Signed-off-by: Kim De Mey <kim.demey@gmail.com>

---

 lib/copperplate/notifier.c  |  5 ++++-
 lib/copperplate/threadobj.c |  3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/copperplate/notifier.c b/lib/copperplate/notifier.c
--- a/lib/copperplate/notifier.c
+++ b/lib/copperplate/notifier.c
@@ -143,10 +143,13 @@ int notifier_init(struct notifier *nf,
 	sigset_t oset;
 	int fd;
 
-	if (pipe(nf->psfd) < 0)
+	if (pipe(nf->psfd) < 0) {
+		warning("failed to create file descriptors");
 		return __bt(-errno);
+	}
 
 	if (pipe(nf->pwfd) < 0) {
+		warning("failed to create file descriptors");
 		__STD(close(nf->psfd[0]));
 		__STD(close(nf->psfd[1]));
 		return __bt(-errno);
diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
--- a/lib/copperplate/threadobj.c
+++ b/lib/copperplate/threadobj.c
@@ -449,7 +449,8 @@ static inline int threadobj_setup_coresp
 	int ret;
 
 	prctl(PR_SET_NAME, (unsigned long)thobj->name, 0, 0, 0);
-	notifier_init(&thobj->core.notifier, notifier_callback, 1);
+	ret = notifier_init(&thobj->core.notifier, notifier_callback, 1);
+	assert(ret == 0);
 	thobj->core.period = 0;
 
 	/*


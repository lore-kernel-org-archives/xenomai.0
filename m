Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <8ad2934f0bf0d4009511.1382100608@devws164.be.alcatel-lucent.com>
In-Reply-To: <patchbomb.1382100607@devws164.be.alcatel-lucent.com>
References: <patchbomb.1382100607@devws164.be.alcatel-lucent.com>
Date: Fri, 18 Oct 2013 14:50:08 +0200
From: Kim De Mey <kim.demey@gmail.com>
Subject: [Xenomai] [PATCH 1 of 2] Xenomai-forge thread_obj: unset
 __THREAD_S_SAFE when not needed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

unset __THREAD_S_SAFE for thobj->status when the priority of the
task is lower than then priority of the current task.

Signed-off-by: Kim De Mey <kim.demey@gmail.com>

---

 lib/copperplate/threadobj.c |  4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
--- a/lib/copperplate/threadobj.c
+++ b/lib/copperplate/threadobj.c
@@ -929,8 +929,10 @@ int threadobj_start(struct threadobj *th
 	thobj->status |= __THREAD_S_STARTED|__THREAD_S_SAFE;
 	__RT(pthread_cond_signal(&thobj->barrier));
 
-	if (current && thobj->priority <= current->priority)
+	if (current && thobj->priority <= current->priority) {
+		thobj->status &= ~__THREAD_S_SAFE;
 		return 0;
+	}
 
 	/*
 	 * Caller needs synchronization with the thread being started,


Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <49466BAA.8020800@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 15 Dec 2008 15:34:36 +0100
Message-ID: <20081215143436.15493.20810.stgit@domain.hid>
In-Reply-To: <20081215143435.15493.94798.stgit@domain.hid>
References: <20081215143435.15493.94798.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 2/6] POSIX: Fix initialization of SCHED_RR
	threads
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Passing SCHED_RR as policy to pthread_create has currently not the
desired effect. The kernel part expects that user space adjusts the
policy and prio via __pse51_thread_setschedparam after setting up the
shadow. And this is what the patch does by calling the wrapped
pthread_setschedparam instead of the real one.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 src/skins/posix/thread.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/skins/posix/thread.c b/src/skins/posix/thread.c
index 1544291..2ecb64f 100644
--- a/src/skins/posix/thread.c
+++ b/src/skins/posix/thread.c
@@ -162,7 +162,7 @@ static void *__pthread_trampoline(void *arg)
 		/* Broken pthread libs ignore some of the thread attribute specs
 		   passed to pthread_create(3), so we force the scheduling policy
 		   once again here. */
-		__real_pthread_setschedparam(tid, policy, &param);
+		__wrap_pthread_setschedparam(tid, policy, &param);
 
 		/* If the thread running pthread_create runs with the same
 		   priority as us, we should leave it running, as if there never



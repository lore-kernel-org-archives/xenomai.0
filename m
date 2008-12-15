Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <49466BAA.3000205@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 15 Dec 2008 15:34:36 +0100
Message-ID: <20081215143436.15493.65646.stgit@domain.hid>
In-Reply-To: <20081215143435.15493.94798.stgit@domain.hid>
References: <20081215143435.15493.94798.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 3/6] POSIX: Optimize pthread_setschedparam
	fast path
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

Optimize __wrap_pthread_setschedparam without HAVE___THREAD for the case
that an already mapped shadow is modifying its own scheduling
parameters.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 src/skins/posix/thread.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/skins/posix/thread.c b/src/skins/posix/thread.c
index 2ecb64f..d2839c6 100644
--- a/src/skins/posix/thread.c
+++ b/src/skins/posix/thread.c
@@ -37,11 +37,10 @@ static int linuxthreads;
 int __wrap_pthread_setschedparam(pthread_t thread,
 				 int policy, const struct sched_param *param)
 {
-	pthread_t myself = pthread_self();
 	unsigned long *mode_buf = NULL;
 	int err, promoted;
 
-	if (thread == myself) {
+	if (xeno_current != XN_NO_HANDLE && thread == pthread_self()) {
 #ifdef HAVE___THREAD
 		mode_buf = xeno_init_current_mode();
 #else /* !HAVE___THREAD */



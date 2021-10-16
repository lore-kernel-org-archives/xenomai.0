From: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH 2/3] lib/boilerplate: Convert pthread_mutexattr_setrobust_np
 stub into inline function
Date: Sat, 16 Oct 2021 20:31:24 +0200
Message-Id: <4787b2d82610f3e8382b06085d7caa644fab1dbb.1634409085.git.jan.kiszka@web.de>
In-Reply-To: <cover.1634409085.git.jan.kiszka@web.de>
References: <cover.1634409085.git.jan.kiszka@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Recent glibc (at leasst 2.34) triggers

  CC       libposix_fork_a-posix-fork.o
In file included from posix-fork.c:11:
../../../include/boilerplate/libc.h:248:10: error: expected identifier or =
'(' before '{' token
  248 |         ({ ENOSYS; })
      |          ^

So switch to a static inline, like for all the other stubs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 include/boilerplate/libc.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/boilerplate/libc.h b/include/boilerplate/libc.h
index 75e2d1da43..41b2eb91bb 100644
=2D-- a/include/boilerplate/libc.h
+++ b/include/boilerplate/libc.h
@@ -244,8 +244,12 @@ __weak int shm_unlink(const char *name)
 #endif	/* !HAVE_SHM_UNLINK */

 #ifndef HAVE_PTHREAD_MUTEXATTR_SETROBUST_NP
-#define pthread_mutexattr_setrobust_np(__attr, __robust)	\
-	({ ENOSYS; })
+static inline
+int pthread_mutexattr_setrobust_np(const pthread_mutexattr_t *attr,
+				   int *robustness)
+{
+	return ENOSYS;
+}
 #endif /* !HAVE_PTHREAD_MUTEXATTR_SETROBUST_NP */

 #if !defined(HAVE_PTHREAD_SETNAME_NP) && defined(CONFIG_XENO_MERCURY)
=2D-
2.31.1



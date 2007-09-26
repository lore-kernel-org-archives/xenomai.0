Message-ID: <46FA44C9.8050506@domain.hid>
Date: Wed, 26 Sep 2007 13:38:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020704070108050106060801"
Subject: [Xenomai-core] [PATCH] Fix attribute reference in
	__wrap_pthread_create
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-core@domain.hid

This is a multi-part message in MIME format.
--------------020704070108050106060801
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gilles,

my rt-cap changes to the posix lib caused another regression. I don't 
understand what my intention of changing the attribute reference once 
was (probably an intermediate change), but it was wrong. The attached 
patch now makes all programs happy that create pthreads without 
attributes (clocktest e.g.).

Patch against 2.3.x, should be applied to trunk as well.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------020704070108050106060801
Content-Type: text/x-patch;
 name="fix-pthread-attr-reference.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-pthread-attr-reference.patch"

---
 ChangeLog                |    5 +++++
 src/skins/posix/thread.c |    2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

Index: xenomai-2.3.x/ChangeLog
===================================================================
--- xenomai-2.3.x.orig/ChangeLog
+++ xenomai-2.3.x/ChangeLog
@@ -1,3 +1,8 @@
+2007-09-26  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* src/skins/posix/thread.c (__wrap_pthread_create): Use the correct
+	attribute reference when creating the real pthread.
+
 2007-09-16  Philippe Gerum  <rpm@xenomai.org>
 
 	* RELEASE: Xenomai 2.3.4 (Cool #9)
Index: xenomai-2.3.x/src/skins/posix/thread.c
===================================================================
--- xenomai-2.3.x.orig/src/skins/posix/thread.c
+++ xenomai-2.3.x/src/skins/posix/thread.c
@@ -170,7 +170,7 @@ int __wrap_pthread_create(pthread_t *tid
 	iargs.ret = EAGAIN;
 	__real_sem_init(&iargs.sync, 0, 0);
 
-	err = __real_pthread_create(&ltid, &iattr, &__pthread_trampoline, &iargs);
+	err = __real_pthread_create(&ltid, attr, &__pthread_trampoline, &iargs);
 	if (!err)
 		while (__real_sem_wait(&iargs.sync) && errno == EINTR) ;
 	__real_sem_destroy(&iargs.sync);

--------------020704070108050106060801--


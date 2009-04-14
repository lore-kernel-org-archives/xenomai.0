Message-ID: <49E50741.2070205@domain.hid>
Date: Tue, 14 Apr 2009 23:59:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB7EF157B3CAF46691C3405C8"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] posix: Add missing __real prototypes
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB7EF157B3CAF46691C3405C8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

=2E..and clean up a duplicate wrapping.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/posix/pthread.h        |   36 ++++++++++++++++++++++++++++++++++=
++
 include/posix/semaphore.h      |    6 ++++++
 src/skins/posix/posix.wrappers |    1 -
 3 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/include/posix/pthread.h b/include/posix/pthread.h
index 10176ad..94788c3 100644
--- a/include/posix/pthread.h
+++ b/include/posix/pthread.h
@@ -477,6 +477,27 @@ int __real_pthread_setschedparam(pthread_t thread,
 				 const struct sched_param *param);
 int __real_pthread_yield(void);
=20
+int __real_pthread_mutexattr_init(pthread_mutexattr_t *attr);
+
+int __real_pthread_mutexattr_destroy(pthread_mutexattr_t *attr);
+
+int __real_pthread_mutexattr_gettype(const pthread_mutexattr_t *attr,
+				     int *type);
+
+int __real_pthread_mutexattr_settype(pthread_mutexattr_t *attr, int type=
);
+
+int __real_pthread_mutexattr_getprotocol(const pthread_mutexattr_t *attr=
,
+					 int *proto);
+
+int __real_pthread_mutexattr_setprotocol(pthread_mutexattr_t *attr,
+					 int proto);
+
+int __real_pthread_mutexattr_getpshared(const pthread_mutexattr_t *attr,=

+					int *pshared);
+
+int __real_pthread_mutexattr_setpshared(pthread_mutexattr_t *attr,
+					int pshared);
+
 int __real_pthread_mutex_init(pthread_mutex_t *mutex,
 			      const pthread_mutexattr_t *attr);
=20
@@ -491,6 +512,21 @@ int __real_pthread_mutex_trylock(pthread_mutex_t *mu=
tex);
=20
 int __real_pthread_mutex_unlock(pthread_mutex_t *mutex);
=20
+int __real_pthread_condattr_init(pthread_condattr_t *attr);
+
+int __real_pthread_condattr_destroy(pthread_condattr_t *attr);
+
+int __real_pthread_condattr_getclock(const pthread_condattr_t *attr,
+				     clockid_t *clk_id);
+
+int __real_pthread_condattr_setclock(pthread_condattr_t *attr,
+			      clockid_t clk_id);
+
+int __real_pthread_condattr_getpshared(const pthread_condattr_t *attr,
+				       int *pshared);
+
+int __real_pthread_condattr_setpshared(pthread_condattr_t *attr, int psh=
ared);
+
 int __real_pthread_cond_init (pthread_cond_t *cond,
 			      const pthread_condattr_t *attr);
=20
diff --git a/include/posix/semaphore.h b/include/posix/semaphore.h
index 8532112..fc27d50 100644
--- a/include/posix/semaphore.h
+++ b/include/posix/semaphore.h
@@ -121,6 +121,12 @@ int __real_sem_post(sem_t *sem);
=20
 int __real_sem_wait(sem_t *sem);
=20
+int __real_sem_timedwait(sem_t *sem, const struct timespec *abs_timeout)=
;
+
+int __real_sem_trywait(sem_t *sem);
+
+int __real_sem_getvalue(sem_t *sem, int *value);
+
 sem_t *__real_sem_open(const char *name, int oflags, ...);
=20
 int __real_sem_close(sem_t *sem);
diff --git a/src/skins/posix/posix.wrappers b/src/skins/posix/posix.wrapp=
ers
index ddfe0d7..776c5d5 100644
--- a/src/skins/posix/posix.wrappers
+++ b/src/skins/posix/posix.wrappers
@@ -83,7 +83,6 @@
 --wrap timer_gettime
 --wrap ftruncate
 --wrap ftruncate64
---wrap close
 --wrap shm_open
 --wrap shm_unlink
 --wrap mmap


--------------enigB7EF157B3CAF46691C3405C8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAknlB08ACgkQniDOoMHTA+k4nACdHTtyN+XLl9HIvxGHC54JQQxr
gB8AnA0Pl4kruNVOtUlPffckIju51cq9
=4vH1
-----END PGP SIGNATURE-----

--------------enigB7EF157B3CAF46691C3405C8--


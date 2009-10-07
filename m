Message-ID: <4ACC890C.501@domain.hid>
Date: Wed, 07 Oct 2009 14:26:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [pull request] librtdk: Mark __wrap_clock_gettime as
	weak symbol
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

The following changes since commit cd669afa1b220242c157de74b9e3cd86c37b8433:
  Philippe Gerum (1):
        x86: upgrade I-pipe support to 2.6.30.8-x86-2.4-06, 2.6.31.1-x86-2.4-06

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (1):
      librtdk: Mark __wrap_clock_gettime as weak symbol

 src/rtdk/assert_context.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

---

>From 4a2cb7b817cefc16a3840a2406f4f7031bdfd534 Mon Sep 17 00:00:00 2001
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Wed, 7 Oct 2009 13:53:27 +0200
Subject: [PATCH] librtdk: Mark __wrap_clock_gettime as weak symbol

This ensures that, in case both librtdk and libpthread_rt are used, the
POSIX skin will be able to provide its Xenomai version of clock_gettime.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 src/rtdk/assert_context.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/rtdk/assert_context.c b/src/rtdk/assert_context.c
index 2176db3..f67bcd8 100644
--- a/src/rtdk/assert_context.c
+++ b/src/rtdk/assert_context.c
@@ -66,6 +66,7 @@ int __wrap_gettimeofday(struct timeval *tv, struct timezone *tz)
 	return __real_gettimeofday(tv, tz);
 }
 
+__attribute__ ((weak))
 int __wrap_clock_gettime(clockid_t clk_id, struct timespec *tp)
 {
 	assert_nrt();
-- 
1.6.0.2


Message-ID: <475FBEED.6070900@domain.hid>
Date: Wed, 12 Dec 2007 11:58:53 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070102020708070906040705"
Subject: [Xenomai-core] [PATCH] add missing __real_pthread_kill
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

This is a multi-part message in MIME format.
--------------070102020708070906040705
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Gilles,

the attached patch adds the missing function __real_pthread_kill to
src/skins/posix/wrappers.c.

Wolfgang.



--------------070102020708070906040705
Content-Type: text/x-patch;
 name="xeno-real-pthread-kill.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xeno-real-pthread-kill.patch"

+ diff -u xenomai-2.3.2/src/skins/posix/wrappers.c.ORIG xenomai-2.3.2/src/skins/posix/wrappers.c
--- xenomai-2.3.2/src/skins/posix/wrappers.c.ORIG	2006-12-26 19:39:00.000000000 +0100
+++ xenomai-2.3.2/src/skins/posix/wrappers.c	2007-12-12 11:41:54.000000000 +0100
@@ -44,6 +44,11 @@
 	return pthread_getschedparam(thread, policy, param);
 }
 
+int __real_pthread_kill(pthread_t thread, int sig)
+{
+	return pthread_kill(thread, sig);
+}
+
 int __real_sched_yield(void)
 {
 	return sched_yield();

--------------070102020708070906040705--


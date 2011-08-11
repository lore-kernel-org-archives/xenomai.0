Message-ID: <4E440FAC.5020107@domain.hid>
Date: Thu, 11 Aug 2011 19:21:48 +0200
From: Roland Stigge <stigge@domain.hid>
MIME-Version: 1.0
References: <4E43B5FE.4040402@domain.hid>
	<4E43B7E8.5000302@domain.hid>	<4E43C056.9040007@domain.hid>
	<4E43EBC6.10808@domain.hid>
In-Reply-To: <4E43EBC6.10808@domain.hid>
Content-Type: multipart/mixed; boundary="------------060705030006040104020909"
Subject: Re: [Xenomai-core] gcc-4.6 issue
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: 637425@domain.hid

This is a multi-part message in MIME format.
--------------060705030006040104020909
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 08/11/2011 04:48 PM, Daniele Nicolodi wrote:
> I compiled linux 2.6.38.8 and xenomai-head with gcc-4.6. The obtained
> kernel boots fine but xenomai services do not: latency hangs right after
> the sched_setscheduler system call. With the same kernel I compiled user
> space with gcc-4.4 and xenomia services work just fine.

I can confirm this now for Debian. Sorry for the delay.

Will use gcc-4.4 for building the Debian package for now.

Attached is a patch you might like to integrate into the GIT repository
for the build environment. BTW: You further don't need all the
Makefile.in's under revision control when there's also a Makefile.am.
Similarly regarding aclocal.m4 and configure.

bye,
  Roland

--------------060705030006040104020909
Content-Type: text/x-patch;
 name="xenomai.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="xenomai.patch"

diff --git a/include/nucleus/Makefile.am b/include/nucleus/Makefile.am
index 5fc1c21..7af212a 100644
--- a/include/nucleus/Makefile.am
+++ b/include/nucleus/Makefile.am
@@ -37,4 +37,5 @@ includesub_HEADERS = \
 	vdso.h \
 	seqlock.h \
 	version.h \
-	xenomai.h
+	xenomai.h \
+	vfile.h
diff --git a/src/skins/common/Makefile.am b/src/skins/common/Makefile.am
index 2156165..888bc5b 100644
--- a/src/skins/common/Makefile.am
+++ b/src/skins/common/Makefile.am
@@ -1,5 +1,7 @@
 lib_LTLIBRARIES = libxenomai.la
-noinst_HEADERS = sem_heap.h
+noinst_HEADERS = \
+	sem_heap.h \
+	internal.h
 
 libxenomai_la_SOURCES = \
 	assert_context.c \
diff --git a/src/testsuite/xeno-test/Makefile.am b/src/testsuite/xeno-test/Makefile.am
index 1d082de..1c8280c 100644
--- a/src/testsuite/xeno-test/Makefile.am
+++ b/src/testsuite/xeno-test/Makefile.am
@@ -9,4 +9,4 @@ xeno_test_run_CPPFLAGS = -DTESTDIR=\"$(testdir)\"
 xeno-test: $(srcdir)/xeno-test.in Makefile
 	sed "s,@testdir@domain.hid)," $< > $@
 
-EXTRA_DIST = $(test_SCRIPTS)
+EXTRA_DIST = $(test_SCRIPTS) xeno-test.in

--------------060705030006040104020909--


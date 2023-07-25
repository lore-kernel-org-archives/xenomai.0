Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD7214ABA
	for <xenomai@lists.linux.dev>; Tue, 25 Jul 2023 08:30:06 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-98e011f45ffso773659366b.3
        for <xenomai@lists.linux.dev>; Tue, 25 Jul 2023 01:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1690273805; x=1690878605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wm5HDB09cUndJsrDMeSAAvkj1KR0Lv7U8ii+PnT490o=;
        b=uEMsDpuzvQdSaERdU7Ju+yJLRb9lwegmxb0cHEkcpX+P8vkmGo3JI14wVy7v7RmwHp
         FS0VENbM6UtOveatECI9b/ekJhfDRbAjDhajhMRQzLeesSSB0Q5B16zElDx4Tfwf6gvt
         KotaqNPF+SiIskwneddmLdEMTOj/C2k6HyRaZluTan0Q7QoUgUK3iRHeIDiaadv5U85B
         LWw+EmT98SsgJLhkrP46Zl9yf3QqAD7BwVOu0mcR+J7shqAzk84psWzpmbF0VUAr6M9h
         AaKC3s57YBKpXKb339G/pLTeBIejibIdGWzMIAreey8rvTndkeMvFKgMcO3CHGfma1oc
         z3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690273805; x=1690878605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wm5HDB09cUndJsrDMeSAAvkj1KR0Lv7U8ii+PnT490o=;
        b=l8nYJaGVuG523kueq6pHzerKQk8c4NHWJ1sqFq+2TC+STDm3ugEUvLz7dEv9usXLqa
         XOaeRMTajNyK4iL5Qy6U6ole4fjxdNuIyB5TJuaimx2bumGx/a2I0KGuLVuoBXajU/WY
         ddX9NgiyzVLrJMFgnGSXHp8cbCh3kev3sS/jC/mzrb9CElP0IPMM02dQ0cV5f0bzHOAa
         rBiE8jbbc6TPSiOVcDHkg9DOnso+i0dQOFHR8KKQjjwXGgUdryuydXwqzXNMj0JEcNNR
         doi9qUFzNV63BUrw509fGapil47GhUBTxVWfH1AcYlxRjALYP+2SdbTPLYHAJvDSBbBG
         VMNA==
X-Gm-Message-State: ABy/qLYwOWslWznCQF23kGqt5uRIP7/6NAn54tXw7GDowCfjPV1jQQj4
	/PjDIs+vfg25Tp27t4z97AJ4E1eNbW/cJ83G0Aw=
X-Google-Smtp-Source: APBJJlElyQWULM8sQcN7VDfs9MrevfpVE7vzntEmlshhlgK7T0YOlg62HWc8vt3oDMBEJDiwHjvraw==
X-Received: by 2002:a17:906:3f1e:b0:992:4d30:dc4a with SMTP id c30-20020a1709063f1e00b009924d30dc4amr11319398ejj.74.1690273805222;
        Tue, 25 Jul 2023 01:30:05 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id l2-20020a170906230200b00997e52cb30bsm7752080eja.121.2023.07.25.01.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:30:05 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 03/10] testsuite: Fully integrate vwworkstests into smokey
Date: Tue, 25 Jul 2023 10:29:52 +0200
Message-Id: <20230725082959.5144-4-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230725082959.5144-1-aaron@sigma-star.at>
References: <1753829974.221010.1690209596711.JavaMail.zimbra@nod.at>
 <20230725082959.5144-1-aaron@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Same as for alchemytests and psostests.

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 configure.ac                                  |  2 +-
 lib/vxworks/testsuite/Makefile                | 43 ---------
 testsuite/Makefile.am                         |  6 +-
 testsuite/smokey/Makefile.am                  |  3 +
 testsuite/smokey/vxworkstests/Makefile.am     | 94 +++++++++++++++++++
 .../smokey/vxworkstests}/lst-1.c              |  1 +
 .../smokey/vxworkstests}/msgQ-1.c             |  1 +
 .../smokey/vxworkstests}/msgQ-2.c             |  1 +
 .../smokey/vxworkstests}/msgQ-3.c             |  1 +
 .../smokey/vxworkstests}/rng-1.c              |  1 +
 .../smokey/vxworkstests}/sem-1.c              |  1 +
 .../smokey/vxworkstests}/sem-2.c              |  1 +
 .../smokey/vxworkstests}/sem-3.c              |  1 +
 .../smokey/vxworkstests}/sem-4.c              |  1 +
 .../smokey/vxworkstests}/task-1.c             |  1 +
 .../smokey/vxworkstests}/task-2.c             |  1 +
 testsuite/smokey/vxworkstests/vxworkstests.c  | 46 +++++++++
 .../smokey/vxworkstests/vxworkstests_driver.c | 33 +++++++
 .../smokey/vxworkstests}/wd-1.c               |  1 +
 19 files changed, 191 insertions(+), 48 deletions(-)
 delete mode 100644 lib/vxworks/testsuite/Makefile
 create mode 100644 testsuite/smokey/vxworkstests/Makefile.am
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/lst-1.c (99%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-1.c (98%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-2.c (98%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-3.c (98%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/rng-1.c (99%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-1.c (98%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-2.c (98%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-3.c (97%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-4.c (98%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/task-1.c (96%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/task-2.c (98%)
 create mode 100644 testsuite/smokey/vxworkstests/vxworkstests.c
 create mode 100644 testsuite/smokey/vxworkstests/vxworkstests_driver.c
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/wd-1.c (97%)

diff --git a/configure.ac b/configure.ac
index 9db5438eb..a601f94cd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1045,9 +1045,9 @@ AC_CONFIG_FILES([ \
 	testsuite/smokey/x86io/Makefile \
 	testsuite/smokey/alchemytests/Makefile \
 	testsuite/smokey/psostests/Makefile \
+	testsuite/smokey/vxworkstests/Makefile \
 	testsuite/clocktest/Makefile \
 	testsuite/xeno-test/Makefile \
-	testsuite/vxworkstests/Makefile \
 	utils/Makefile \
 	utils/hdb/Makefile \
 	utils/can/Makefile \
diff --git a/lib/vxworks/testsuite/Makefile b/lib/vxworks/testsuite/Makefile
deleted file mode 100644
index 648c9be90..000000000
--- a/lib/vxworks/testsuite/Makefile
+++ /dev/null
@@ -1,43 +0,0 @@
-ifeq ($(DESTDIR),)
-XENO_CONFIG=xeno-config
-else
-XENO_CONFIG=$(DESTDIR)/bin/xeno-config
-endif
-
-prefix := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --prefix)
-solibs := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --libdir)
-
-ifeq ($(prefix),)
-$(error Please add <xenomai-install-path>/bin to your PATH variable or specify DESTDIR)
-endif
-
-TESTS := task-1 task-2 msgQ-1 msgQ-2 msgQ-3 wd-1 sem-1 sem-2 sem-3 sem-4 lst-1 rng-1
-
-CFLAGS := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --skin=vxworks --cflags) -g
-LDFLAGS := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --skin=vxworks --ldflags)
-CC = $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --cc)
-
-all: $(TESTS)
-
-%: %.c
-	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
-
-install: all
-	install -d $(prefix)/testsuite/vxworks
-	install -t $(prefix)/testsuite/vxworks $(TESTS)
-
-clean:
-	$(RM) $(TESTS) *~
-
-# Run the test suite. We pin all tests to CPU #0, so that SMP does not
-# alter the execution sequence we expect from them.
-test: all
-	@for t in $(TESTS); do \
-		echo -n $$t...; \
-		sudo LD_LIBRARY_PATH=$(solibs) $(VALGRIND) ./$$t --cpu-affinity=0 --silent && echo ok || echo BAD; \
-	done
-
-test/%: %
-	sudo LD_LIBRARY_PATH=$(solibs) $(VALGRIND) ./$(@F) --cpu-affinity=0 --silent && echo ok || echo BAD
-
-.PHONY: clean test
diff --git a/testsuite/Makefile.am b/testsuite/Makefile.am
index bb94f6ba6..4932f6d33 100644
--- a/testsuite/Makefile.am
+++ b/testsuite/Makefile.am
@@ -7,8 +7,7 @@ SUBDIRS += 		\
 	gpiotest	\
 	spitest		\
 	switchtest	\
-	xeno-test	\
-	vxworkstests
+	xeno-test
 endif
 
 DIST_SUBDIRS =		\
@@ -19,5 +18,4 @@ DIST_SUBDIRS =		\
 	smokey		\
 	spitest		\
 	switchtest	\
-	xeno-test	\
-	vxworkstests
+	xeno-test
diff --git a/testsuite/smokey/Makefile.am b/testsuite/smokey/Makefile.am
index 457e22a84..888e83b1c 100644
--- a/testsuite/smokey/Makefile.am
+++ b/testsuite/smokey/Makefile.am
@@ -42,6 +42,7 @@ COBALT_SUBDIRS = 	\
 	xddp		\
 	y2038 \
 	alchemytests \
+	vxworkstests \
 	psostests
 
 MERCURY_SUBDIRS =	\
@@ -49,6 +50,7 @@ MERCURY_SUBDIRS =	\
 	memory-tlsf	\
 	memcheck \
 	alchemytests \
+	vxworkstests \
 	psostests
 
 DIST_SUBDIRS = 		\
@@ -86,6 +88,7 @@ DIST_SUBDIRS = 		\
 	xddp		\
 	y2038 \
 	alchemytests \
+	vxworkstests \
 	psostests
 
 if XENO_X86
diff --git a/testsuite/smokey/vxworkstests/Makefile.am b/testsuite/smokey/vxworkstests/Makefile.am
new file mode 100644
index 000000000..ba942c455
--- /dev/null
+++ b/testsuite/smokey/vxworkstests/Makefile.am
@@ -0,0 +1,94 @@
+testdir = @XENO_TEST_DIR@
+noinst_LIBRARIES = libvxworkstests.a
+
+libvxworkstests_a_SOURCES = vxworkstests.c
+libvxworkstests_a_CPPFLAGS = 		\
+	@XENO_USER_CFLAGS@	\
+	-I$(top_srcdir)		\
+	-I$(top_srcdir)/include \
+	-DXENO_TEST_DIR='"$(XENO_TEST_DIR)"'
+
+CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+test_PROGRAMS = \
+		vxworkstests \
+		vxworkstests_lst1	\
+		vxworkstests_msgQ1	\
+		vxworkstests_msgQ2	\
+		vxworkstests_msgQ3	\
+		vxworkstests_rng1	\
+		vxworkstests_sem1	\
+		vxworkstests_sem2	\
+		vxworkstests_sem3	\
+		vxworkstests_sem4	\
+		vxworkstests_wd1	\
+		vxworkstests_task1	\
+		vxworkstests_task2
+
+vxworkscppflags = 				\
+	$(XENO_USER_CFLAGS)		\
+	-I$(top_srcdir)/include
+
+vxworksldadd = 					\
+	../../../lib/vxworks/libvxworks@CORE@.la		\
+	../../../lib/copperplate/libcopperplate@CORE@.la	\
+	@XENO_CORE_LDADD@ 			\
+	@XENO_USER_LDADD@			\
+	-lpthread -lrt -lm
+
+vxworkstests_SOURCES = vxworkstests_driver.c
+vxworkstests_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_LDADD =			\
+	../../../lib/smokey/libsmokey@CORE@.la	\
+	-lpthread -lrt
+
+vxworkstests_lst1_SOURCES = lst-1.c
+vxworkstests_lst1_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_lst1_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+vxworkstests_lst1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_task1_SOURCES = task-1.c
+vxworkstests_task1_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_task1_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+vxworkstests_task1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_task2_SOURCES = task-2.c
+vxworkstests_task2_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_task2_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+vxworkstests_task2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_msgQ1_SOURCES = msgQ-1.c
+vxworkstests_msgQ1_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_msgQ1_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+vxworkstests_msgQ1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_msgQ2_SOURCES = msgQ-2.c
+vxworkstests_msgQ2_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_msgQ2_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+vxworkstests_msgQ2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_msgQ3_SOURCES = msgQ-3.c
+vxworkstests_msgQ3_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_msgQ3_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+vxworkstests_msgQ3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_rng1_SOURCES = rng-1.c
+vxworkstests_rng1_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_rng1_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+vxworkstests_rng1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_sem1_SOURCES = sem-1.c
+vxworkstests_sem1_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_sem1_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+vxworkstests_sem1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_sem2_SOURCES = sem-2.c
+vxworkstests_sem2_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_sem2_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+vxworkstests_sem2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_sem3_SOURCES = sem-3.c
+vxworkstests_sem3_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_sem3_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+vxworkstests_sem3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_sem4_SOURCES = sem-4.c
+vxworkstests_sem4_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_sem4_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+vxworkstests_sem4_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_wd1_SOURCES = wd-1.c
+vxworkstests_wd1_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_wd1_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+vxworkstests_wd1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
diff --git a/lib/vxworks/testsuite/lst-1.c b/testsuite/smokey/vxworkstests/lst-1.c
similarity index 99%
rename from lib/vxworks/testsuite/lst-1.c
rename to testsuite/smokey/vxworkstests/lst-1.c
index 03dec367d..878f32c90 100644
--- a/lib/vxworks/testsuite/lst-1.c
+++ b/testsuite/smokey/vxworkstests/lst-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/vxworks/testsuite/msgQ-1.c b/testsuite/smokey/vxworkstests/msgQ-1.c
similarity index 98%
rename from lib/vxworks/testsuite/msgQ-1.c
rename to testsuite/smokey/vxworkstests/msgQ-1.c
index fd15e1ddd..71eedd44f 100644
--- a/lib/vxworks/testsuite/msgQ-1.c
+++ b/testsuite/smokey/vxworkstests/msgQ-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/vxworks/testsuite/msgQ-2.c b/testsuite/smokey/vxworkstests/msgQ-2.c
similarity index 98%
rename from lib/vxworks/testsuite/msgQ-2.c
rename to testsuite/smokey/vxworkstests/msgQ-2.c
index 58f11e3a1..d3ee1397c 100644
--- a/lib/vxworks/testsuite/msgQ-2.c
+++ b/testsuite/smokey/vxworkstests/msgQ-2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/vxworks/testsuite/msgQ-3.c b/testsuite/smokey/vxworkstests/msgQ-3.c
similarity index 98%
rename from lib/vxworks/testsuite/msgQ-3.c
rename to testsuite/smokey/vxworkstests/msgQ-3.c
index 1a4e20d26..a23d5c3d0 100644
--- a/lib/vxworks/testsuite/msgQ-3.c
+++ b/testsuite/smokey/vxworkstests/msgQ-3.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/vxworks/testsuite/rng-1.c b/testsuite/smokey/vxworkstests/rng-1.c
similarity index 99%
rename from lib/vxworks/testsuite/rng-1.c
rename to testsuite/smokey/vxworkstests/rng-1.c
index dd944a58a..1e179c6f6 100644
--- a/lib/vxworks/testsuite/rng-1.c
+++ b/testsuite/smokey/vxworkstests/rng-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
diff --git a/lib/vxworks/testsuite/sem-1.c b/testsuite/smokey/vxworkstests/sem-1.c
similarity index 98%
rename from lib/vxworks/testsuite/sem-1.c
rename to testsuite/smokey/vxworkstests/sem-1.c
index 245eb5c48..b64aba3b8 100644
--- a/lib/vxworks/testsuite/sem-1.c
+++ b/testsuite/smokey/vxworkstests/sem-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/vxworks/testsuite/sem-2.c b/testsuite/smokey/vxworkstests/sem-2.c
similarity index 98%
rename from lib/vxworks/testsuite/sem-2.c
rename to testsuite/smokey/vxworkstests/sem-2.c
index c9befc4d9..67caf2924 100644
--- a/lib/vxworks/testsuite/sem-2.c
+++ b/testsuite/smokey/vxworkstests/sem-2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/vxworks/testsuite/sem-3.c b/testsuite/smokey/vxworkstests/sem-3.c
similarity index 97%
rename from lib/vxworks/testsuite/sem-3.c
rename to testsuite/smokey/vxworkstests/sem-3.c
index 1041d25b0..1f4252e3d 100644
--- a/lib/vxworks/testsuite/sem-3.c
+++ b/testsuite/smokey/vxworkstests/sem-3.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/vxworks/testsuite/sem-4.c b/testsuite/smokey/vxworkstests/sem-4.c
similarity index 98%
rename from lib/vxworks/testsuite/sem-4.c
rename to testsuite/smokey/vxworkstests/sem-4.c
index 5c82169e1..0a8daedb1 100644
--- a/lib/vxworks/testsuite/sem-4.c
+++ b/testsuite/smokey/vxworkstests/sem-4.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/vxworks/testsuite/task-1.c b/testsuite/smokey/vxworkstests/task-1.c
similarity index 96%
rename from lib/vxworks/testsuite/task-1.c
rename to testsuite/smokey/vxworkstests/task-1.c
index 3cf5f3806..a07d643c3 100644
--- a/lib/vxworks/testsuite/task-1.c
+++ b/testsuite/smokey/vxworkstests/task-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/vxworks/testsuite/task-2.c b/testsuite/smokey/vxworkstests/task-2.c
similarity index 98%
rename from lib/vxworks/testsuite/task-2.c
rename to testsuite/smokey/vxworkstests/task-2.c
index 46d99a266..7f9f0f002 100644
--- a/lib/vxworks/testsuite/task-2.c
+++ b/testsuite/smokey/vxworkstests/task-2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/testsuite/smokey/vxworkstests/vxworkstests.c b/testsuite/smokey/vxworkstests/vxworkstests.c
new file mode 100644
index 000000000..e244c4d98
--- /dev/null
+++ b/testsuite/smokey/vxworkstests/vxworkstests.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <error.h>
+#include <libgen.h>
+#include <smokey/smokey.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#define TEST(name)								   \
+	smokey_test_plugin(name, SMOKEY_NOARGS, "Run external test");		   \
+	static int run_##name(struct smokey_test *t, int argc, char *const argv[]) \
+	{									   \
+		return __run_extprog(t, argc, argv);				   \
+	}
+
+static int __run_extprog(struct smokey_test *t, int argc, char *const argv[])
+{
+	int ret;
+	char *tst_path;
+
+	ret = asprintf(&tst_path, "%s/%s --cpu-affinity=0", XENO_TEST_DIR, t->name);
+	if (ret == -1)
+		return -ENOMEM;
+
+	ret = system(tst_path);
+	free(tst_path);
+
+	return ret;
+}
+
+TEST(vxworkstests)
+TEST(vxworkstests_lst1)
+TEST(vxworkstests_msgQ1)
+TEST(vxworkstests_msgQ2)
+TEST(vxworkstests_msgQ3)
+TEST(vxworkstests_rng1)
+TEST(vxworkstests_sem1)
+TEST(vxworkstests_sem2)
+TEST(vxworkstests_sem3)
+TEST(vxworkstests_sem4)
+TEST(vxworkstests_wd1)
+TEST(vxworkstests_task1)
+TEST(vxworkstests_task2)
+
diff --git a/testsuite/smokey/vxworkstests/vxworkstests_driver.c b/testsuite/smokey/vxworkstests/vxworkstests_driver.c
new file mode 100644
index 000000000..7cacbb399
--- /dev/null
+++ b/testsuite/smokey/vxworkstests/vxworkstests_driver.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <error.h>
+#include <libgen.h>
+#include <smokey/smokey.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+int main(int argc, char *const argv[])
+{
+	struct smokey_test *t;
+	int ret, fails = 0;
+
+	if (pvlist_empty(&smokey_test_list))
+		return 0;
+
+	for_each_smokey_test(t) {
+		ret = t->run(t, argc, argv);
+		if (ret) {
+			fails++;
+			if (smokey_keep_going)
+				continue;
+			if (smokey_verbose_mode)
+				error(1, -ret, "test %s failed", t->name);
+			return 1;
+		}
+		smokey_note("%s OK", t->name);
+	}
+
+	return fails != 0;
+}
diff --git a/lib/vxworks/testsuite/wd-1.c b/testsuite/smokey/vxworkstests/wd-1.c
similarity index 97%
rename from lib/vxworks/testsuite/wd-1.c
rename to testsuite/smokey/vxworkstests/wd-1.c
index b557545e8..7da5d4dcb 100644
--- a/lib/vxworks/testsuite/wd-1.c
+++ b/testsuite/smokey/vxworkstests/wd-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
-- 
2.35.3


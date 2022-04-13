From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 4/9] Remove old alchemy tests Makefile
Date: Wed, 13 Apr 2022 23:58:14 +0200
Message-Id: <20220413215819.22954-5-richard@nod.at>
In-Reply-To: <20220413215819.22954-1-richard@nod.at>
References: <20220413215819.22954-1-richard@nod.at>
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
Cc: Richard Weinberger <richard@nod.at>

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 lib/alchemy/testsuite/Makefile | 70 ----------------------------------
 1 file changed, 70 deletions(-)
 delete mode 100644 lib/alchemy/testsuite/Makefile

diff --git a/lib/alchemy/testsuite/Makefile b/lib/alchemy/testsuite/Makef=
ile
deleted file mode 100644
index a831c999e..000000000
--- a/lib/alchemy/testsuite/Makefile
+++ /dev/null
@@ -1,70 +0,0 @@
-ifeq ($(DESTDIR),)
-XENO_CONFIG=3Dxeno-config
-else
-XENO_CONFIG=3D$(DESTDIR)/bin/xeno-config
-endif
-
-prefix :=3D $(shell DESTDIR=3D$(DESTDIR) $(XENO_CONFIG) --prefix)
-solibs :=3D $(shell DESTDIR=3D$(DESTDIR) $(XENO_CONFIG) --libdir)
-core :=3D $(shell DESTDIR=3D$(DESTDIR) $(XENO_CONFIG) --core)
-
-ifeq ($(prefix),)
-$(error Please add <xenomai-install-path>/bin to your PATH variable or s=
pecify DESTDIR)
-endif
-
-cobalt-only :=3D pipe-1
-mercury-only :=3D
-core-specific =3D $($(core)-only)
-
-TESTS :=3D		\
-	task-1		\
-	task-2		\
-	task-3		\
-	task-4		\
-	task-5		\
-	task-6		\
-	task-7		\
-	task-8		\
-	task-9		\
-	task-10		\
-	mq-1		\
-	mq-2		\
-	mq-3		\
-	alarm-1		\
-	sem-1		\
-	sem-2		\
-	mutex-1		\
-	event-1		\
-	heap-1		\
-	heap-2		\
-	buffer-1	\
-	$(core-specific)
-
-CFLAGS :=3D $(shell DESTDIR=3D$(DESTDIR) $(XENO_CONFIG) --skin=3Dalchemy=
 --cflags) -g
-LDFLAGS :=3D $(shell DESTDIR=3D$(DESTDIR) $(XENO_CONFIG) --skin=3Dalchem=
y --ldflags)
-CC =3D $(shell DESTDIR=3D$(DESTDIR) $(XENO_CONFIG) --cc)
-
-all: $(TESTS)
-
-%: %.c
-	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
-
-install: all
-	install -d $(prefix)/testsuite/alchemy
-	install -t $(prefix)/testsuite/alchemy $(TESTS)
-
-clean:
-	$(RM) $(TESTS) *~
-
-# Run the test suite. We pin all tests to CPU #0, so that SMP does not
-# alter the execution sequence we expect from them.
-test: all
-	@for t in $(TESTS); do \
-		echo -n $$t...; \
-		sudo LD_LIBRARY_PATH=3D$(solibs) $(VALGRIND) ./$$t --cpu-affinity=3D0 =
--silent && echo ok || echo BAD; \
-	done
-
-test/%: %
-	sudo LD_LIBRARY_PATH=3D$(solibs) $(VALGRIND) ./$(@F) --cpu-affinity=3D0=
 --silent && echo ok || echo BAD
-
-.PHONY: clean test
--=20
2.34.1



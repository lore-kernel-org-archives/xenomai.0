From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 2/8] doc: do not discard pdflatex output
Date: Fri, 31 Jan 2020 16:27:07 +0100
Message-Id: <20200131152713.1811748-3-rpm@xenomai.org>
In-Reply-To: <20200131152713.1811748-1-rpm@xenomai.org>
References: <20200131152713.1811748-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

We need this information for debugging purpose when latex stop mode is
enabled (--enable-verbose-latex=yes).

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 configure.ac            | 2 +-
 doc/doxygen/Makefile.am | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 14ddd4a78..29fefab30 100644
--- a/configure.ac
+++ b/configure.ac
@@ -447,7 +447,7 @@ LATEX_BATCHMODE=YES
 LATEX_MODE=batch
 AC_MSG_CHECKING(for LaTeX mode)
 AC_ARG_ENABLE(verbose-latex,
-	AS_HELP_STRING([--enable-nonstop-latex], [Use LaTeX non-stop mode]),
+	AS_HELP_STRING([--enable-verbose-latex], [Disable LaTeX non-stop mode]),
 	[case "$enableval" in
 	y | yes)
 	   LATEX_BATCHMODE=NO
diff --git a/doc/doxygen/Makefile.am b/doc/doxygen/Makefile.am
index 963785150..964dfdf44 100644
--- a/doc/doxygen/Makefile.am
+++ b/doc/doxygen/Makefile.am
@@ -20,7 +20,7 @@ html/xeno3prm latex/xeno3prm: FORCE
 	$(DOXYGEN) $(@F)-$(@D).conf
 
 %.pdf: latex/%
-	$(MAKE) -C $< refman.pdf > /dev/null
+	$(MAKE) -C $< refman.pdf
 	mv $</refman.pdf $@
 
 distclean-local:
-- 
2.24.1



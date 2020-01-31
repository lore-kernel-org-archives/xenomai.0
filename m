From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 4/8] doc: fix asciidoc generation
Date: Fri, 31 Jan 2020 16:27:09 +0100
Message-Id: <20200131152713.1811748-5-rpm@xenomai.org>
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

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 doc/asciidoc/Makefile.am | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/asciidoc/Makefile.am b/doc/asciidoc/Makefile.am
index f88e19391..9d06e7798 100644
--- a/doc/asciidoc/Makefile.am
+++ b/doc/asciidoc/Makefile.am
@@ -105,10 +105,10 @@ $(tmpdir)/%.txt: %.adoc Makefile plaintext.conf plaintext.xsl
 	awk -f $(srcdir)/plaintext_postproc.awk $(tmpdir)/$*.txt > $@
 
 html/asciidoc-icons:
-	@$(RM) -R asciidoc-icons
-	@test -d /usr/share/asciidoc/images && \
-	cp -a /usr/share/asciidoc/images/icons html/asciidoc-icons || \
-	cp -a /usr/share/asciidoc/icons html/asciidoc-icons
+	$(RM) -R asciidoc-icons
+	@test -d /usr/share/doc/asciidoc/images/ && \
+	cp -a /usr/share/doc/asciidoc/images/icons/ html/asciidoc-icons || \
+	cp -a /usr/share/asciidoc/images/icons/ html/asciidoc-icons
 
 html/asciidoc-icons/callouts: html/asciidoc-icons
 
-- 
2.24.1



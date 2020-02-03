From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] doc: Look for asciidoc images also in /etc
Message-ID: <f127bed2-8fca-adc7-0750-2eb7be39d868@siemens.com>
Date: Mon, 3 Feb 2020 19:26:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This is where OpenSUSE puts them, maybe others as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 doc/asciidoc/Makefile.am | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/doc/asciidoc/Makefile.am b/doc/asciidoc/Makefile.am
index 9d06e77987..8e33c72814 100644
--- a/doc/asciidoc/Makefile.am
+++ b/doc/asciidoc/Makefile.am
@@ -106,9 +106,13 @@ $(tmpdir)/%.txt: %.adoc Makefile plaintext.conf plaintext.xsl
 
 html/asciidoc-icons:
 	$(RM) -R asciidoc-icons
-	@test -d /usr/share/doc/asciidoc/images/ && \
-	cp -a /usr/share/doc/asciidoc/images/icons/ html/asciidoc-icons || \
-	cp -a /usr/share/asciidoc/images/icons/ html/asciidoc-icons
+	@if test -d /usr/share/doc/asciidoc/images/; then \
+		cp -a /usr/share/doc/asciidoc/images/icons/ html/asciidoc-icons; \
+	elif test -d /usr/share/asciidoc/images/icons/; then \
+		cp -a /usr/share/asciidoc/images/icons/ html/asciidoc-icons; \
+	else \
+		cp -a /etc/asciidoc/images/icons/ html/asciidoc-icons; \
+	fi
 
 html/asciidoc-icons/callouts: html/asciidoc-icons
 
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


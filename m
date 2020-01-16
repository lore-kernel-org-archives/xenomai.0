From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] Uninstall udev files
Message-ID: <ab85da62-8424-4130-532d-3e076b115267@siemens.com>
Date: Thu, 16 Jan 2020 17:52:57 +0100
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

At least the copied-in files can and should be removed on uninstall, but
we do not make any efforts to remove us again from a pre-existing
udev.rules.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Makefile.am | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 37143dc709..ec1d0a07ec 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -50,4 +50,12 @@ install-user: install
 
 install-exec-local: udev-rules
 
+uninstall-local:
+if XENO_COBALT
+	cd $(srcdir)/kernel/cobalt/udev ; \
+	for f in *.rules ; do \
+	    $(RM) $(DESTDIR)$(sysconfdir)/udev/rules.d/$$f ; \
+	done
+endif
+
 .PHONY: FORCE
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


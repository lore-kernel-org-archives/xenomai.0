From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] build: Restore install-user target
Message-ID: <f6fa4822-5ae8-21eb-ad9f-d7d8d58dd692@siemens.com>
Date: Wed, 28 Nov 2018 20:08:12 +0100
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

This helps users that may still expect it to exist. One example is
buildroot.

While at it, remove the now unused SUDO variable.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Makefile.am | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index ef78bee898..37143dc709 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,7 +1,5 @@
 ACLOCAL_AMFLAGS=-I config
 
-SUDO=sudo
-
 SUBDIRS = 		\
 	doc		\
 	lib 		\
@@ -47,6 +45,9 @@ if XENO_COBALT
 	fi
 endif
 
+# legacy alias
+install-user: install
+
 install-exec-local: udev-rules
 
 .PHONY: FORCE
-- 
2.16.4


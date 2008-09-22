From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Mon, 22 Sep 2008 21:51:46 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809222151.46401.niklaus.giger@domain.hid>
Subject: [Xenomai-core] [PATCH] Adding some .gitignore
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

After a ./configure in my git clone, git status cluttered my screen withe a lot 
of uninteresting files. In order to get rid of them I created the attached 
.gitignore files.

Signed-off-by: Niklaus Giger <niklaus.giger@domain.hid>

---
 .gitignore                   |   47 
++++++++++++++++++++++++++++++++++++++++++
 base/.gitignore              |    8 +++++++
 config/.gitignore            |    9 ++++++++
 include/.gitignore           |    8 +++++++
 include/psos/.gitignore      |    8 +++++++
 include/vxworks/.gitignore   |    8 +++++++
 include/xenomai/.gitignore   |    8 +++++++
 psos/.gitignore              |    8 +++++++
 scripts/.gitignore           |    9 ++++++++
 vxworks/.gitignore           |    8 +++++++
 vxworks/testsuite/.gitignore |   10 +++++++++
 11 files changed, 131 insertions(+), 0 deletions(-)
 create mode 100644 .gitignore
 create mode 100644 base/.gitignore
 create mode 100644 config/.gitignore
 create mode 100644 include/.gitignore
 create mode 100644 include/psos/.gitignore
 create mode 100644 include/vxworks/.gitignore
 create mode 100644 include/xenomai/.gitignore
 create mode 100644 psos/.gitignore
 create mode 100644 scripts/.gitignore
 create mode 100644 vxworks/.gitignore
 create mode 100644 vxworks/testsuite/.gitignore

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..af911eb
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,47 @@
+#
+# NOTE! Don't add files that are generated in specific
+# subdirectories here. Add them in the ".gitignore" file
+# in that subdirectory instead.
+#
+# Normal rules
+#
+
+*.rej
+*.orig
+*.a
+*.o
+*~
+*.la
+*.lo
+
+#
+# Top-level generic files
+#
+
+#
+# Generated files
+#
+/conf2*
+*.depend
+.deps
+.libs
+*.lineno
+libtool
+config.log
+/Makefile
+stamp-h1
+xeno_config.h
+config.status
+
+# for output of format-patch
+00*
+
+# stgit generated dirs
+patches-*
+
+# quilt's files
+patches
+series
+
+# cscope files
+cscope.*
diff --git a/base/.gitignore b/base/.gitignore
new file mode 100644
index 0000000..13daaa8
--- /dev/null
+++ b/base/.gitignore
@@ -0,0 +1,8 @@
+#
+# NOTE! Don't add files that are generated in specific
+# subdirectories here. Add them in the ".gitignore" file
+# in that subdirectory instead.
+#
+# Generated files
+#
+/Makefile
diff --git a/config/.gitignore b/config/.gitignore
new file mode 100644
index 0000000..e96352c
--- /dev/null
+++ b/config/.gitignore
@@ -0,0 +1,9 @@
+#
+# NOTE! Don't add files that are generated in specific
+# subdirectories here. Add them in the ".gitignore" file
+# in that subdirectory instead.
+#
+# Generated files
+#
+/Makefile
+*.lineno
diff --git a/include/.gitignore b/include/.gitignore
new file mode 100644
index 0000000..13daaa8
--- /dev/null
+++ b/include/.gitignore
@@ -0,0 +1,8 @@
+#
+# NOTE! Don't add files that are generated in specific
+# subdirectories here. Add them in the ".gitignore" file
+# in that subdirectory instead.
+#
+# Generated files
+#
+/Makefile
diff --git a/include/psos/.gitignore b/include/psos/.gitignore
new file mode 100644
index 0000000..13daaa8
--- /dev/null
+++ b/include/psos/.gitignore
@@ -0,0 +1,8 @@
+#
+# NOTE! Don't add files that are generated in specific
+# subdirectories here. Add them in the ".gitignore" file
+# in that subdirectory instead.
+#
+# Generated files
+#
+/Makefile
diff --git a/include/vxworks/.gitignore b/include/vxworks/.gitignore
new file mode 100644
index 0000000..13daaa8
--- /dev/null
+++ b/include/vxworks/.gitignore
@@ -0,0 +1,8 @@
+#
+# NOTE! Don't add files that are generated in specific
+# subdirectories here. Add them in the ".gitignore" file
+# in that subdirectory instead.
+#
+# Generated files
+#
+/Makefile
diff --git a/include/xenomai/.gitignore b/include/xenomai/.gitignore
new file mode 100644
index 0000000..13daaa8
--- /dev/null
+++ b/include/xenomai/.gitignore
@@ -0,0 +1,8 @@
+#
+# NOTE! Don't add files that are generated in specific
+# subdirectories here. Add them in the ".gitignore" file
+# in that subdirectory instead.
+#
+# Generated files
+#
+/Makefile
diff --git a/psos/.gitignore b/psos/.gitignore
new file mode 100644
index 0000000..13daaa8
--- /dev/null
+++ b/psos/.gitignore
@@ -0,0 +1,8 @@
+#
+# NOTE! Don't add files that are generated in specific
+# subdirectories here. Add them in the ".gitignore" file
+# in that subdirectory instead.
+#
+# Generated files
+#
+/Makefile
diff --git a/scripts/.gitignore b/scripts/.gitignore
new file mode 100644
index 0000000..d618ccb
--- /dev/null
+++ b/scripts/.gitignore
@@ -0,0 +1,9 @@
+#
+# NOTE! Don't add files that are generated in specific
+# subdirectories here. Add them in the ".gitignore" file
+# in that subdirectory instead.
+#
+# Generated files
+#
+/Makefile
+xeno-config
diff --git a/vxworks/.gitignore b/vxworks/.gitignore
new file mode 100644
index 0000000..13daaa8
--- /dev/null
+++ b/vxworks/.gitignore
@@ -0,0 +1,8 @@
+#
+# NOTE! Don't add files that are generated in specific
+# subdirectories here. Add them in the ".gitignore" file
+# in that subdirectory instead.
+#
+# Generated files
+#
+/Makefile
diff --git a/vxworks/testsuite/.gitignore b/vxworks/testsuite/.gitignore
new file mode 100644
index 0000000..089bf31
--- /dev/null
+++ b/vxworks/testsuite/.gitignore
@@ -0,0 +1,10 @@
+msgQ-1
+msgQ-2
+msgQ-3
+sem-1
+sem-2
+sem-3
+task-1
+task-2
+wd-1
+
-- 
1.6.0.1



From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH v2 5/8] demo-image: Fix sshd-regen-keys
 problems on arm / qemu
Date: Wed, 13 Oct 2021 14:17:29 +0200
Message-Id: <20211013121732.140595-6-florian.bezdeka@siemens.com>
In-Reply-To: <20211013121732.140595-1-florian.bezdeka@siemens.com>
References: <20211013121732.140595-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

See patch descriptions for details. The main problem was that the key
generation took extremly long and several other services (like the
serial consoles) were not started because the configured timeout was
reached.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 ...Start-key-generation-after-entropy-s.patch | 40 +++++++++++++++++++
 ...Fix-some-systemd-obsolete-warnings-a.patch | 34 ++++++++++++++++
 isar-patches/series                           |  2 +
 kas.yml                                       |  4 ++
 4 files changed, 80 insertions(+)
 create mode 100644 isar-patches/0001-sshd-regen-keys-Start-key-generation-after-entropy-s.patch
 create mode 100644 isar-patches/0002-sshd-regen-keys-Fix-some-systemd-obsolete-warnings-a.patch
 create mode 100644 isar-patches/series

diff --git a/isar-patches/0001-sshd-regen-keys-Start-key-generation-after-entropy-s.patch b/isar-patches/0001-sshd-regen-keys-Start-key-generation-after-entropy-s.patch
new file mode 100644
index 0000000..56fb7d6
--- /dev/null
+++ b/isar-patches/0001-sshd-regen-keys-Start-key-generation-after-entropy-s.patch
@@ -0,0 +1,40 @@
+From 94b24ec5be3e3b0d32db4dbfe7cc9b63d8a0ce0a Mon Sep 17 00:00:00 2001
+From: Florian Bezdeka <florian.bezdeka@siemens.com>
+Date: Thu, 7 Oct 2021 17:59:44 +0200
+Subject: [PATCH 1/2] sshd-regen-keys: Start key generation after entropy seed
+
+Especially on low-end systems (including arm on qemu) it could happen
+that the key generation took extremly long. As side effect some other
+services (like the ones for serial consoles) run into the configured
+timeouts.
+
+[ TIME ] Timed out waiting for device /dev/hvc0.
+[DEPEND] Dependency failed for Serial Getty on hvc0.
+[ TIME ] Timed out waiting for device /dev/ttyAMA0.
+[DEPEND] Dependency failed for Serial Getty on ttyAMA0.
+
+Delaying the key generation to the point in time where
+systemd-random-seed finished solves this problem. My current
+understanding is that the regeneration is waiting for enough entropy
+which is being seeded in parallel.
+
+Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
+---
+ .../sshd-regen-keys/files/sshd-regen-keys.service                | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/meta/recipes-support/sshd-regen-keys/files/sshd-regen-keys.service b/meta/recipes-support/sshd-regen-keys/files/sshd-regen-keys.service
+index a05e1a9..4d0a8c6 100644
+--- a/meta/recipes-support/sshd-regen-keys/files/sshd-regen-keys.service
++++ b/meta/recipes-support/sshd-regen-keys/files/sshd-regen-keys.service
+@@ -3,6 +3,7 @@ Description=Regenerate sshd host keys
+ DefaultDependencies=no
+ Conflicts=shutdown.target
+ After=systemd-remount-fs.service
++After=systemd-random-seed.service
+ Before=shutdown.target sshd.service
+ ConditionPathIsReadWrite=/etc
+ 
+-- 
+2.31.1
+
diff --git a/isar-patches/0002-sshd-regen-keys-Fix-some-systemd-obsolete-warnings-a.patch b/isar-patches/0002-sshd-regen-keys-Fix-some-systemd-obsolete-warnings-a.patch
new file mode 100644
index 0000000..1b8d2e0
--- /dev/null
+++ b/isar-patches/0002-sshd-regen-keys-Fix-some-systemd-obsolete-warnings-a.patch
@@ -0,0 +1,34 @@
+From 4d20f39987326d1a545015c9bbb385b6d9219c67 Mon Sep 17 00:00:00 2001
+From: Florian Bezdeka <florian.bezdeka@siemens.com>
+Date: Thu, 7 Oct 2021 18:05:15 +0200
+Subject: [PATCH 2/2] sshd-regen-keys: Fix some systemd obsolete warnings about
+ using syslog
+
+Fixes the following warnings:
+
+[   11.450104] systemd[1]: /lib/systemd/system/sshd-regen-keys.service:15:
+[   11.450806] systemd[1]: /lib/systemd/system/sshd-regen-keys.service:16:
+	Standard output type syslog is obsolete, automatically updating to journal.
+	Please update your unit file, and consider removing the setting altogether.
+
+Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
+---
+ .../sshd-regen-keys/files/sshd-regen-keys.service               | 2 --
+ 1 file changed, 2 deletions(-)
+
+diff --git a/meta/recipes-support/sshd-regen-keys/files/sshd-regen-keys.service b/meta/recipes-support/sshd-regen-keys/files/sshd-regen-keys.service
+index 4d0a8c6..ebcee86 100644
+--- a/meta/recipes-support/sshd-regen-keys/files/sshd-regen-keys.service
++++ b/meta/recipes-support/sshd-regen-keys/files/sshd-regen-keys.service
+@@ -13,8 +13,6 @@ RemainAfterExit=yes
+ Environment=DEBIAN_FRONTEND=noninteractive
+ ExecStart=/usr/sbin/sshd-regen-keys.sh
+ ExecStartPost=-/bin/systemctl disable sshd-regen-keys.service
+-StandardOutput=syslog
+-StandardError=syslog
+ 
+ [Install]
+ WantedBy=sysinit.target
+-- 
+2.31.1
+
diff --git a/isar-patches/series b/isar-patches/series
new file mode 100644
index 0000000..3e76460
--- /dev/null
+++ b/isar-patches/series
@@ -0,0 +1,2 @@
+0001-sshd-regen-keys-Start-key-generation-after-entropy-s.patch
+0002-sshd-regen-keys-Fix-some-systemd-obsolete-warnings-a.patch
diff --git a/kas.yml b/kas.yml
index c8bafcd..345fccc 100644
--- a/kas.yml
+++ b/kas.yml
@@ -23,6 +23,10 @@ repos:
   isar:
     url: https://github.com/ilbers/isar.git
     refspec: 1cfe166c5e53ae96bc07b895a92bf6cd7ace7bc9
+    patches:
+      "isar-patches":
+        repo: xenomai
+        path: isar-patches
     layers:
       meta:
 
-- 
2.31.1



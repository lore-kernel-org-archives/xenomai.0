From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH v3 5/8] ci/kas: Skip ssh key regeneration for
 all ci targets
Date: Mon, 15 Nov 2021 11:13:43 +0100
Message-Id: <20211115101346.3566075-6-florian.bezdeka@siemens.com>
In-Reply-To: <20211115101346.3566075-1-florian.bezdeka@siemens.com>
References: <20211115101346.3566075-1-florian.bezdeka@siemens.com>
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

To minimize CI build time, the ssh-regen part will be skipped on all
ci / test targets.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 opt-ci.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/opt-ci.yml b/opt-ci.yml
index 4d1ab60..f90277a 100644
--- a/opt-ci.yml
+++ b/opt-ci.yml
@@ -27,6 +27,8 @@ repos:
 
 local_conf_header:
   xenomai-ci: |
+    ROOTFS_POSTPROCESS_COMMAND_remove = "image_postprocess_sshd_key_regen"
+    IMAGE_INSTALL_remove += "sshd-regen-keys"
     IMAGE_INSTALL_remove += "expand-on-first-boot"
     IMAGE_TYPE = "${@ 'ext4-img' if d.getVar('MACHINE', True).startswith('qemu') else 'targz-img' }"
     COMPRESS = "${@ 'gz' if d.getVar('MACHINE', True).startswith('qemu') else '' }"
\ No newline at end of file
-- 
2.30.2



From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH v3 3/8] ci/kas: Disable partition expanding
 during first boot
Date: Mon, 15 Nov 2021 11:13:41 +0100
Message-Id: <20211115101346.3566075-4-florian.bezdeka@siemens.com>
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

Trying to expand the partition during first boot doesn't make sense
as we use NFS for deployment. Removing it helps to reduce the first boot
time a bit.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 opt-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/opt-ci.yml b/opt-ci.yml
index 9df02d0..4d1ab60 100644
--- a/opt-ci.yml
+++ b/opt-ci.yml
@@ -27,5 +27,6 @@ repos:
 
 local_conf_header:
   xenomai-ci: |
+    IMAGE_INSTALL_remove += "expand-on-first-boot"
     IMAGE_TYPE = "${@ 'ext4-img' if d.getVar('MACHINE', True).startswith('qemu') else 'targz-img' }"
     COMPRESS = "${@ 'gz' if d.getVar('MACHINE', True).startswith('qemu') else '' }"
\ No newline at end of file
-- 
2.30.2



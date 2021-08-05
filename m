From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2] linux-xenomai_4.4: Add machine specific
 config for beagle bone black
Date: Thu,  5 Aug 2021 14:29:22 +0200
Message-Id: <20210805122922.31963-1-Quirin.Gylstorff@siemens.com>
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
To: jan.kiszka@siemens.com, xenomai@xenomai.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The beagle bone black does most[1] of the time not boot ipipe 4.4 + xenomai 3.0.x if
the following kernel configuration elements are active:
 - CONFIG_RAW_PRINTK
 - CONFIG_DEBUG_LL
 - CONFIG_IPIPE_DEBUG
 - CONFIG_XENO_OPT_DEBUG

Last message in U-boot is:
```
Starting kernel ...
```

4.19 and newer are not impacted.

[1]: The CI build boots around 1 out 4. See https://source.denx.de/Xenomai/xenomai-images/-/jobs/303430

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes V2:
 - replace defconfig with partial config
 - adapt commit message for sporatic CI boots

 recipes-kernel/linux/files/bbb_4.4.cfg    | 4 ++++
 recipes-kernel/linux/linux-xenomai_4.4.bb | 1 +
 2 files changed, 5 insertions(+)
 create mode 100644 recipes-kernel/linux/files/bbb_4.4.cfg

diff --git a/recipes-kernel/linux/files/bbb_4.4.cfg b/recipes-kernel/linux/files/bbb_4.4.cfg
new file mode 100644
index 0000000..4628f44
--- /dev/null
+++ b/recipes-kernel/linux/files/bbb_4.4.cfg
@@ -0,0 +1,4 @@
+# CONFIG_RAW_PRINTK is not set
+# CONFIG_DEBUG_LL is not set
+# CONFIG_IPIPE_DEBUG is not set
+# CONFIG_XENO_OPT_DEBUG is not set
diff --git a/recipes-kernel/linux/linux-xenomai_4.4.bb b/recipes-kernel/linux/linux-xenomai_4.4.bb
index 2a1137c..42c6d83 100644
--- a/recipes-kernel/linux/linux-xenomai_4.4.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.4.bb
@@ -16,6 +16,7 @@ SRCREV_amd64 ?= "ipipe-core-4.4.268-cip57-x86-28"
 PV_amd64 = "4.4.268+"
 
 SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1"
+SRC_URI_append_armhf = " ${@ 'file://bbb_4.4.cfg' if d.getVar('MACHINE') == 'beagle-bone-black' else '' }"
 SRCREV_armhf ?= "ipipe-core-4.4.268-cip57-arm-13"
 PV_armhf = "4.4.268+"
 
-- 
2.20.1



From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 3/9] linux-xenomai: NFS support in KERNEL
 configuration
Date: Thu,  5 Sep 2019 17:44:19 +0200
Message-Id: <20190905154425.10007-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20190905154425.10007-1-Quirin.Gylstorff@siemens.com>
References: <20190905154425.10007-1-Quirin.Gylstorff@siemens.com>
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

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

LAVA deploys the Rootfs with NFS on the target.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/files/amd64_defconfig | 27 ++++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/recipes-kernel/linux/files/amd64_defconfig b/recipes-kernel/linux/files/amd64_defconfig
index f8aea8a..cba31a5 100644
--- a/recipes-kernel/linux/files/amd64_defconfig
+++ b/recipes-kernel/linux/files/amd64_defconfig
@@ -656,7 +656,7 @@ CONFIG_ZONE_DMA=y
 CONFIG_SMP=y
 CONFIG_X86_FEATURE_NAMES=y
 CONFIG_X86_FAST_FEATURE_TESTS=y
-# CONFIG_X86_X2APIC is not set
+CONFIG_X86_X2APIC=y
 CONFIG_X86_MPPARSE=y
 # CONFIG_GOLDFISH is not set
 CONFIG_RETPOLINE=y
@@ -943,6 +943,7 @@ CONFIG_PCI_MMCONFIG=y
 CONFIG_PCI_DOMAINS=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_HOTPLUG_PCI_PCIE=y
+CONFIG_HOTPLUG_PCI_PCI=y
 CONFIG_PCIEAER=y
 # CONFIG_PCIE_ECRC is not set
 # CONFIG_PCIEAER_INJECT is not set
@@ -969,7 +970,7 @@ CONFIG_PCI_IOV=y
 # CONFIG_PCI_PASID is not set
 CONFIG_PCI_LABEL=y
 CONFIG_HOTPLUG_PCI=y
-# CONFIG_HOTPLUG_PCI_ACPI is not set
+CONFIG_HOTPLUG_PCI_ACPI=y
 CONFIG_HOTPLUG_PCI_CPCI=y
 # CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
 # CONFIG_HOTPLUG_PCI_CPCI_GENERIC is not set
@@ -1039,7 +1040,10 @@ CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTIPLE_TABLES=y
 CONFIG_IP_ROUTE_MULTIPATH=y
 CONFIG_IP_ROUTE_VERBOSE=y
-# CONFIG_IP_PNP is not set
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE_DEMUX is not set
 # CONFIG_NET_IP_TUNNEL is not set
@@ -1071,7 +1075,7 @@ CONFIG_TCP_CONG_CUBIC=y
 # CONFIG_TCP_CONG_HSTCP is not set
 # CONFIG_TCP_CONG_HYBLA is not set
 # CONFIG_TCP_CONG_VEGAS is not set
-# CONFIG_TCP_CONG_NV is not set
+# CONFIG_TCP_CONG_NV=y
 # CONFIG_TCP_CONG_SCALABLE is not set
 # CONFIG_TCP_CONG_LP is not set
 # CONFIG_TCP_CONG_VENO is not set
@@ -1940,7 +1944,7 @@ CONFIG_NET_VENDOR_QUALCOMM=y
 CONFIG_NET_VENDOR_REALTEK=y
 # CONFIG_8139CP is not set
 # CONFIG_8139TOO is not set
-# CONFIG_R8169 is not set
+CONFIG_R8169=m
 CONFIG_NET_VENDOR_RENESAS=y
 CONFIG_NET_VENDOR_RDC=y
 # CONFIG_R6040 is not set
@@ -3655,7 +3659,16 @@ CONFIG_PSTORE_ZLIB_COMPRESS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
-# CONFIG_NFS_FS is not set
+CONFIG_NFS_FS=y
+CONFIG_NFS_V2=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+CONFIG_NFS_V4_1=y
+CONFIG_NFS_V4_2=y
+CONFIG_ROOT_NFS=y
+CONFIG_NFS_ACL_SUPPORT=y
+CONFIG_NFS_COMMON=y
 # CONFIG_NFSD is not set
 # CONFIG_CEPH_FS is not set
 # CONFIG_CIFS is not set
@@ -3728,7 +3741,7 @@ CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 #
 CONFIG_PRINTK_TIME=y
 CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
-CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
+CONFIG_MESSAGE_LOGLEVEL_DEFAULT=7
 # CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_DYNAMIC_DEBUG is not set
 
-- 
2.20.1



From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] linux-xenomai: arm: Enable
 CONFIG_ARM_MODULE_PLTS
Message-ID: <6a5993f8-d169-9605-e8a1-a07a623206bb@siemens.com>
Date: Mon, 11 Oct 2021 11:15:50 +0200
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

No reason to turn this off, in fact, we have to turn it on with
bullseye's gcc-10 and debug options enabled to avoid relocation
range problems when loading modules.

Reported-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/files/armhf_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/recipes-kernel/linux/files/armhf_defconfig b/recipes-kernel/linux/files/armhf_defconfig
index ef4981d..eda674c 100644
--- a/recipes-kernel/linux/files/armhf_defconfig
+++ b/recipes-kernel/linux/files/armhf_defconfig
@@ -1112,7 +1112,6 @@ CONFIG_HIGHPTE=y
 CONFIG_CPU_SW_DOMAIN_PAN=y
 CONFIG_HW_PERF_EVENTS=y
 CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
-# CONFIG_ARM_MODULE_PLTS is not set
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_HAVE_MEMBLOCK=y
-- 
2.31.1


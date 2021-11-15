From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH v3 7/8] linux-xenomai: arm: Enable
 CONFIG_ARM_MODULE_PLTS
Date: Mon, 15 Nov 2021 11:13:45 +0100
Message-Id: <20211115101346.3566075-8-florian.bezdeka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

No reason to turn this off, in fact, we have to turn it on with
bullseye's gcc-10 and debug options enabled to avoid relocation
range problems when loading modules.

Reported-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
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
2.30.2



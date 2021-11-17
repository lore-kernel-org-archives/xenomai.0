From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 2/4] xenomai-version.inc: Add stable-head
 versions as well
Date: Wed, 17 Nov 2021 19:34:17 +0100
Message-Id: <bf26cd85f121635333e57700ce5c976cc5b44a0f.1637174059.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1637174059.git.jan.kiszka@siemens.com>
References: <cover.1637174059.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

This ensures the right version selection when using
opt-xenomai-3.X.x.yml, i.e. selecting the head of the respective stable
branches.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/include/xenomai-version.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/conf/distro/include/xenomai-version.inc b/conf/distro/include/xenomai-version.inc
index e8e819b..dc34415 100644
--- a/conf/distro/include/xenomai-version.inc
+++ b/conf/distro/include/xenomai-version.inc
@@ -11,10 +11,10 @@
 
 XENOMAI_DEFAULT_KERNEL_VERSION = "5.10%"
 
-XENOMAI_3_0_VERSION_LIST = "3.0 3.0% 3.0.% 3.0.12"
+XENOMAI_3_0_VERSION_LIST = "3.0 3.0% 3.0.% 3.0.12 stable-3.0.x"
 XENOMAI_3_0_KERNEL_VERSION = "4.4%"
 
-XENOMAI_3_1_VERSION_LIST = "3.1 3.1% 3.1.% 3.1.2"
+XENOMAI_3_1_VERSION_LIST = "3.1 3.1% 3.1.% 3.1.2 stable-3.1.x"
 XENOMAI_3_1_KERNEL_VERSION = "5.4%"
 
 # If PREFERRED_VERSION_xenomai contains any item from XENOMAI_3_0_VERSION_LIST use
-- 
2.31.1



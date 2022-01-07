From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH v3 4/5] Kconfig: Add entry for 3.2.x head
Date: Fri, 7 Jan 2022 13:01:01 +0100
Message-ID: <b2dd846fe7ff64ea6126bfe417c016f98f868af6.1641556862.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1641556862.git.jan.kiszka@siemens.com>
References: <cover.1641556862.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index 8337d3f..df47058 100644
--- a/Kconfig
+++ b/Kconfig
@@ -63,6 +63,9 @@ choice
 config XENOMAI_LATEST
 	bool "Head of next branch"
 
+config XENOMAI_3_2_LATEST
+	bool "Head of stable/v3.2.x branch"
+
 config XENOMAI_3_2
 	bool "Latest 3.2.x release"
 
@@ -78,6 +81,7 @@ endchoice
 config KAS_INCLUDE_XENOMAI
 	string
 	default "opt-xenomai-next.yml" if XENOMAI_LATEST
+	default "opt-xenomai-3.2.x.yml" if XENOMAI_3_2_LATEST
 	default "opt-xenomai-3.1.x.yml" if XENOMAI_3_1_LATEST
 	default "opt-xenomai-3.0.x.yml" if XENOMAI_3_0_LATEST
 
@@ -87,11 +91,11 @@ choice
 
 config KERNEL_5_10_LATEST
 	bool "Head of 5.10 Dovetail branch"
-	depends on XENOMAI_LATEST || XENOMAI_3_2
+	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_5_10
 	bool "Latest 5.10 Dovetail version"
-	depends on XENOMAI_LATEST || XENOMAI_3_2
+	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_5_4_LATEST
 	bool "Head of 5.4 I-pipe branch"
-- 
2.31.1



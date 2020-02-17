From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] testsuite: Fix installation path of smokey_net_server
Message-ID: <b60117b0-5380-8a01-1cb5-9ea1054ff166@siemens.com>
Date: Mon, 17 Feb 2020 18:16:28 +0100
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

Put it where the rest goes as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/net_common/Makefile.am | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/net_common/Makefile.am b/testsuite/smokey/net_common/Makefile.am
index 5185449feb..71ee52f430 100644
--- a/testsuite/smokey/net_common/Makefile.am
+++ b/testsuite/smokey/net_common/Makefile.am
@@ -1,4 +1,5 @@
-bin_PROGRAMS = smokey_net_server
+testdir = @XENO_TEST_DIR@
+test_PROGRAMS = smokey_net_server
 
 noinst_LIBRARIES = libnet_common.a
 noinst_HEADERS = \
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


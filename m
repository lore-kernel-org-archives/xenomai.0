From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH] y2038: testsuite/smokey: Skip recvmmsg64 test if kernel
 support is missing
Date: Wed, 20 Oct 2021 14:52:40 +0200
Message-Id: <20211020125240.52313-1-florian.bezdeka@siemens.com>
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

It might happen that the kernel does not support the combination of
address family and protocol we use for this test. Skip the test and
simulate success in such cases.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index f025fd55d..a1a5d12f6 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -1016,6 +1016,10 @@ static int test_sc_cobalt_recvmmsg64(void)
 	};
 
 	sock = smokey_check_errno(socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP));
+	if (sock == -EAFNOSUPPORT) {
+		smokey_note("recvmmsg64: skipped. (no kernel support)");
+		return 0;
+	}
 	if (sock < 0)
 		return sock;
 
-- 
2.31.1



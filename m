From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH] testsuite/smokey: Fixing a registry leak of the posix_select
 test
Date: Thu, 12 Aug 2021 18:38:22 +0200
Message-Id: <20210812163822.55293-1-florian.bezdeka@siemens.com>
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

According to POSIX message queues have kernel persistence, which means
they are not cleaned up until the next reboot.

The test has a mq_unlink() as "precondition", so it will clean up
failed test runs silently but /proc/xenomai/registry/usage will still
report a "leak" once the test has completed.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/posix-select/posix-select.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testsuite/smokey/posix-select/posix-select.c b/testsuite/smokey/posix-select/posix-select.c
index e9bf938b3..0a59e4968 100644
--- a/testsuite/smokey/posix-select/posix-select.c
+++ b/testsuite/smokey/posix-select/posix-select.c
@@ -138,6 +138,8 @@ static int run_posix_select(struct smokey_test *t, int argc, char *const argv[])
 	usleep(300000);
 	smp_rmb();
 	ret = test_status;
+
+	mq_unlink("/select_test_mq");
 out:
 	pthread_join(tcb, NULL);
 	
-- 
2.30.2



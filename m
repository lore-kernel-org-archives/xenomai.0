From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 6/7] y2038: testsuite/smokey/y2038: Add a missing error
 handling path
Date: Wed,  5 Jan 2022 15:06:49 +0100
Message-Id: <20220105140650.1033850-7-florian.bezdeka@siemens.com>
In-Reply-To: <20220105140650.1033850-1-florian.bezdeka@siemens.com>
References: <20220105140650.1033850-1-florian.bezdeka@siemens.com>
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

Initialization of the mutex used for mutex_timedlock64 tests could fail.
We have to abort the test in this case.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 874decc2a..2f4041e51 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -489,7 +489,8 @@ static int test_sc_cobalt_mutex_timedlock64(void)
 	struct xn_timespec64 ts64;
 	struct thread_context ctx = {0};
 
-	ret = pthread_mutex_init(&mutex, NULL);
+	if (!__T(ret, pthread_mutex_init(&mutex, NULL)))
+		return ret;
 
 	/* Make sure we don't crash because of NULL pointers */
 	ret = XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
-- 
2.30.2



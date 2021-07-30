From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v3 1/5] smokey: posix_mutex: Fix mutex/smokey_barrier leak
Date: Fri, 30 Jul 2021 15:58:52 +0200
Message-Id: <20210730135856.12958-2-florian.bezdeka@siemens.com>
In-Reply-To: <20210730135856.12958-1-florian.bezdeka@siemens.com>
References: <20210730135856.12958-1-florian.bezdeka@siemens.com>
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

The mutex of the smokey_barrier used inside protect_handover() was
never destroyed. This had side effects when trying to extend the test
suite with an additional function that had a mutex located on the same
address than the never cleaned up smokey_barrier lock.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/posix-mutex/posix-mutex.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testsuite/smokey/posix-mutex/posix-mutex.c b/testsuite/smokey/posix-mutex/posix-mutex.c
index 9a55d0973..e5793c42c 100644
--- a/testsuite/smokey/posix-mutex/posix-mutex.c
+++ b/testsuite/smokey/posix-mutex/posix-mutex.c
@@ -997,6 +997,8 @@ static int protect_handover(void)
 	if (!__T(ret, pthread_mutex_destroy(&mutex)))
 		return ret;
 
+	smokey_barrier_destroy(&barrier);
+
 	return 0;
 }
 
-- 
2.30.2



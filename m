From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 2/4] lib/alchemy/testsuite: Fix pipe-1 test case
Date: Tue, 12 Oct 2021 20:19:18 +0200
Message-Id: <b1d53838d917b934c6ad11a3e1f33c07d2445c8b.1634062760.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1634062760.git.jan.kiszka@siemens.com>
References: <cover.1634062760.git.jan.kiszka@siemens.com>
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

A missing initialization led to early termination and crashes.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/alchemy/testsuite/pipe-1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/alchemy/testsuite/pipe-1.c b/lib/alchemy/testsuite/pipe-1.c
index 7272079eec..3f821efe41 100644
--- a/lib/alchemy/testsuite/pipe-1.c
+++ b/lib/alchemy/testsuite/pipe-1.c
@@ -23,7 +23,7 @@ struct pipe_message {
 static void realtime_task(void *arg)
 {
 	struct pipe_message m;
-	int ret, seq;
+	int ret, seq = 0;
 
 	traceobj_enter(&trobj);
 
-- 
2.31.1



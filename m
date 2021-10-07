From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] drivers/testing/switchtest: Properly clean up xnthread on
 error
Message-ID: <6f7e5329-69ef-4a7c-7227-c49a5c7a8a23@siemens.com>
Date: Thu, 7 Oct 2021 16:12:24 +0200
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

Analogously to dfb55d64fc0d.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/testing/switchtest.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/drivers/testing/switchtest.c b/kernel/drivers/testing/switchtest.c
index 8224974e5c..6f8a9fcaa3 100644
--- a/kernel/drivers/testing/switchtest.c
+++ b/kernel/drivers/testing/switchtest.c
@@ -504,6 +504,8 @@ static int rtswitch_create_ktask(struct rtswitch_context *ctx,
 		sattr.entry = rtswitch_ktask;
 		sattr.cookie = &arg;
 		err = xnthread_start(&task->ktask, &sattr);
+		if (err)
+			__xnthread_discard(&task->ktask);
 	} else
 		/*
 		 * In order to avoid calling xnthread_cancel() for an
-- 
2.31.1


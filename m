From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] drivers/testing/heapcheck: Add missing MODULE_LICENSE
Message-ID: <eaac73c4-be4d-377c-fb6f-5801f9c43a3d@siemens.com>
Date: Fri, 11 Oct 2019 11:10:18 +0200
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

Fixes module usage.

Reported-by: Lange Norbert <norbert.lange@andritz.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/testing/heapcheck.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/drivers/testing/heapcheck.c b/kernel/drivers/testing/heapcheck.c
index 447cc13fec..4eb6a5aae2 100644
--- a/kernel/drivers/testing/heapcheck.c
+++ b/kernel/drivers/testing/heapcheck.c
@@ -510,3 +510,5 @@ static void __exit heapcheck_exit(void)
 
 module_init(heapcheck_init);
 module_exit(heapcheck_exit);
+
+MODULE_LICENSE("GPL");
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


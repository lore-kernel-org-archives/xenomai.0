From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 03/16] utils/net: rtifconfig: display device name untruncated
Date: Thu, 21 Mar 2019 18:13:17 +0100
Message-Id: <20190321171330.2073-4-rpm@xenomai.org>
In-Reply-To: <20190321171330.2073-1-rpm@xenomai.org>
References: <20190321171330.2073-1-rpm@xenomai.org>
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
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 utils/net/rtifconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/net/rtifconfig.c b/utils/net/rtifconfig.c
index 8117e127c..9a9abfc4c 100644
--- a/utils/net/rtifconfig.c
+++ b/utils/net/rtifconfig.c
@@ -183,7 +183,7 @@ void print_dev(void)
     struct itf_stats *itf;
 
 
-    cmd.head.if_name[9] = 0;
+    cmd.head.if_name[IFNAMSIZ - 1] = 0;
 
     printf("%-9s Medium: ", cmd.head.if_name);
 
-- 
2.20.1



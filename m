From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@ba-healthcare.com>
Subject: [PATCH 1/7] utils/net: rtifconfig: display device name untruncated
Date: Wed, 28 Jul 2021 09:27:56 +0200
Message-Id: <20210728072802.5816-2-jean-baptiste.tredez@ba-healthcare.com>
In-Reply-To: <20210728072802.5816-1-jean-baptiste.tredez@ba-healthcare.com>
References: <20210728072802.5816-1-jean-baptiste.tredez@ba-healthcare.com>
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
2.17.1



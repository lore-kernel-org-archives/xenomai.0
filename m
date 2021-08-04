From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH 2/2] testsuite/smokey: net_client: skip late packet error in
 vm mode
Date: Tue,  3 Aug 2021 22:47:14 -0400
Message-Id: <20210804024714.665-2-hongzhan.chen@intel.com>
In-Reply-To: <20210804024714.665-1-hongzhan.chen@intel.com>
References: <20210804024714.665-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

In vm mode, skip late packet error in functional test to avoid
test failure.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/testsuite/smokey/net_common/client.c b/testsuite/smokey/net_common/client.c
index d13d72918..752ea55ed 100644
--- a/testsuite/smokey/net_common/client.c
+++ b/testsuite/smokey/net_common/client.c
@@ -204,7 +204,7 @@ static int smokey_net_client_loop(struct smokey_net_client *client)
 		} while (err != -ETIMEDOUT);
 	}
 
-	if (glost || glate)
+	if (glost || (!smokey_on_vm && glate))
 		fprintf(stderr, "RTnet %s test failed", client->name);
 	if (glost) {
 		if (glost == limit)
@@ -214,11 +214,11 @@ static int smokey_net_client_loop(struct smokey_net_client *client)
 			fprintf(stderr, ", %Lu packets lost (%g %%)",
 				glost, 100.0 * glost / limit);
 	}
-	if (glate)
+	if (!smokey_on_vm && glate)
 		fprintf(stderr, ", %Lu overruns", glate);
 	if (glost || glate)
 		fputc('\n', stderr);
-	err = glost || glate ? -EPROTO : 0;
+	err = glost || (!smokey_on_vm && glate) ? -EPROTO : 0;
 
   err:
 	sock = smokey_check_errno(__RT(close(sock)));
-- 
2.17.1



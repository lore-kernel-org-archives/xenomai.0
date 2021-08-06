From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH v2] testsuite/smokey: net_client: skip late packet error in vm
 mode
Date: Thu,  5 Aug 2021 20:11:23 -0400
Message-Id: <20210806001123.7331-1-hongzhan.chen@intel.com>
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
---
 testsuite/smokey/net_common/client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testsuite/smokey/net_common/client.c b/testsuite/smokey/net_common/client.c
index d13d72918..02a9e7e6d 100644
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
@@ -218,7 +218,7 @@ static int smokey_net_client_loop(struct smokey_net_client *client)
 		fprintf(stderr, ", %Lu overruns", glate);
 	if (glost || glate)
 		fputc('\n', stderr);
-	err = glost || glate ? -EPROTO : 0;
+	err = glost || (!smokey_on_vm && glate) ? -EPROTO : 0;
 
   err:
 	sock = smokey_check_errno(__RT(close(sock)));
-- 
2.17.1



From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] testsuite/smokey: net: Ignore late or lost packets when
 running in VM
Message-ID: <ccc448d1-deb7-8c67-96b7-535e5b8b0176@siemens.com>
Date: Tue, 10 Aug 2021 12:17:27 +0200
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

Do not fail the test if packets arrive late or are lost due to the
delays a VM, specifically an emulator like QEMU, may bring. Only if all
packets are lost, something is wrong and should be reported.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This now replaces "testsuite/smokey: net_client: skip late packet error 
in vm mode" in next.

 testsuite/smokey/net_common/client.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testsuite/smokey/net_common/client.c b/testsuite/smokey/net_common/client.c
index d13d72918a..914bda4a49 100644
--- a/testsuite/smokey/net_common/client.c
+++ b/testsuite/smokey/net_common/client.c
@@ -204,6 +204,12 @@ static int smokey_net_client_loop(struct smokey_net_client *client)
 		} while (err != -ETIMEDOUT);
 	}
 
+	if (smokey_on_vm) {
+		glate = 0; /* ignore late arrivals */
+		if (glost != limit)
+			glost = 0; /* ignore some lost packets, not all */
+	}
+
 	if (glost || glate)
 		fprintf(stderr, "RTnet %s test failed", client->name);
 	if (glost) {
-- 
2.31.1


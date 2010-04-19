From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 19 Apr 2010 12:28:46 +0200
Message-Id: <b647395e430e0b72601ca59e054f4a43bd0cbed3.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
Subject: [Xenomai-core] [PATCH v4 06/25] RTIPC: Fix memory leak on failing
	socket creation
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

CC: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/drivers/ipc/rtipc.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/ksrc/drivers/ipc/rtipc.c b/ksrc/drivers/ipc/rtipc.c
index d529912..563cc4e 100644
--- a/ksrc/drivers/ipc/rtipc.c
+++ b/ksrc/drivers/ipc/rtipc.c
@@ -143,6 +143,7 @@ static int rtipc_socket(struct rtdm_dev_context *context,
 {
 	struct rtipc_protocol *proto;
 	struct rtipc_private *p;
+	int ret;
 
 	if (protocol < 0 || protocol >= IPCPROTO_MAX)
 		return -EPROTONOSUPPORT;
@@ -161,7 +162,11 @@ static int rtipc_socket(struct rtdm_dev_context *context,
 	if (p->state == NULL)
 		return -ENOMEM;
 
-	return proto->proto_ops.socket(p, user_info);
+	ret = proto->proto_ops.socket(p, user_info);
+	if (ret)
+		xnfree(p->state);
+
+	return ret;
 }
 
 static int rtipc_close(struct rtdm_dev_context *context,
-- 
1.6.0.2



From: Jan Kiszka <Jan Kiszka jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 15:12:31 +0200
Message-Id: <807b337e72450d1315e8f88e936286bb38d5f62b.1271596367.git.Jan
	Kiszka jan.kiszka@domain.hid>
In-Reply-To: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
In-Reply-To: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH v3 07/24] RTIPC: Drop support for RT socket
	creation/deletion
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@domain.hid>

This is deprecated now, RT callers will automatically be migrated to
NRT to perform the requests. Moreover, dropping it allows us to allocate
resources from Linux instead of using the precious system heap.

CC: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/drivers/ipc/rtipc.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/ksrc/drivers/ipc/rtipc.c b/ksrc/drivers/ipc/rtipc.c
index 563cc4e..71629cb 100644
--- a/ksrc/drivers/ipc/rtipc.c
+++ b/ksrc/drivers/ipc/rtipc.c
@@ -158,13 +158,13 @@ static int rtipc_socket(struct rtdm_dev_context *context,
 
 	p = rtdm_context_to_private(context);
 	p->proto = proto;
-	p->state = xnmalloc(proto->proto_statesz);
+	p->state = kmalloc(proto->proto_statesz, GFP_KERNEL);
 	if (p->state == NULL)
 		return -ENOMEM;
 
 	ret = proto->proto_ops.socket(p, user_info);
 	if (ret)
-		xnfree(p->state);
+		kfree(p->state);
 
 	return ret;
 }
@@ -180,7 +180,7 @@ static int rtipc_close(struct rtdm_dev_context *context,
 	if (ret)
 		return ret;
 
-	xnfree(p->state);
+	kfree(p->state);
 
 	return 0;
 }
@@ -232,10 +232,8 @@ static struct rtdm_device device = {
 	.device_name	=	"rtipc",
 	.protocol_family=	PF_RTIPC,
 	.socket_type	=	SOCK_DGRAM,
-	.socket_rt	=	rtipc_socket,
 	.socket_nrt	=	rtipc_socket,
 	.ops = {
-		.close_rt	=	NULL,
 		.close_nrt	=	rtipc_close,
 		.recvmsg_rt	=	rtipc_recvmsg,
 		.recvmsg_nrt	=	NULL,
-- 
1.6.0.2



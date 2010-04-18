From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:15:44 +0200
Message-Id: <63113a0fd9c595c3aa7bf0155b6f4aea2f4fe07a.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 03/23] RTDM: Properly clean up on proc setup
	errors
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

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/skins/rtdm/proc.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/ksrc/skins/rtdm/proc.c b/ksrc/skins/rtdm/proc.c
index b889f73..70ee4a2 100644
--- a/ksrc/skins/rtdm/proc.c
+++ b/ksrc/skins/rtdm/proc.c
@@ -292,34 +292,38 @@ int __init rtdm_proc_init(void)
 	/* Initialise /proc entries */
 	rtdm_proc_root = create_proc_entry("xenomai/rtdm", S_IFDIR, NULL);
 	if (!rtdm_proc_root)
-		return -EAGAIN;
+		goto error;
 
 	proc_entry = create_proc_entry("named_devices", S_IFREG | S_IRUGO,
 				       rtdm_proc_root);
 	if (!proc_entry)
-		return -EAGAIN;
+		goto error;
 	proc_entry->read_proc = proc_read_named_devs;
 
 	proc_entry = create_proc_entry("protocol_devices", S_IFREG | S_IRUGO,
 				       rtdm_proc_root);
 	if (!proc_entry)
-		return -EAGAIN;
+		goto error;
 	proc_entry->read_proc = proc_read_proto_devs;
 
 	proc_entry =
 	    create_proc_entry("open_fildes", S_IFREG | S_IRUGO, rtdm_proc_root);
 	if (!proc_entry)
-		return -EAGAIN;
+		goto error;
 	proc_entry->read_proc = proc_read_open_fildes;
 	proc_entry->write_proc = proc_kill_open_fildes;
 
 	proc_entry =
 	    create_proc_entry("fildes", S_IFREG | S_IRUGO, rtdm_proc_root);
 	if (!proc_entry)
-		return -EAGAIN;
+		goto error;
 	proc_entry->read_proc = proc_read_fildes;
 
 	return 0;
+
+error:
+	rtdm_proc_cleanup();
+	return -EAGAIN;
 }
 
 void rtdm_proc_cleanup(void)
-- 
1.6.0.2



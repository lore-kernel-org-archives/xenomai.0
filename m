Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB66C5399
	for <xenomai@lists.linux.dev>; Thu, 31 Aug 2023 20:37:44 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023083120374184c674b68f2b3f3559
        for <xenomai@lists.linux.dev>;
        Thu, 31 Aug 2023 22:37:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=96Z74E/3VspxvqKIhVYMGKUKnjO1cLAA5rfovGHKIBU=;
 b=CET+5+L7ctWRD8HRM3Eeeas0TqxJbnLScsErOT1oMKgufo1sxLKBrdbfLIBOz+K6fV4Eeq
 90kScxkGQeLJ2QedbsuDH7LaHO8OssF6ZFqf9ROXqQCIb49HdhVLaK1rf+6vAr1s2dbxr+l8
 J8/6lHHS6qFQ71abgJjnD96uMUffc=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 31 Aug 2023 22:37:27 +0200
Subject: [PATCH stable/v3.2.x 01/19] Account for switch to pde_data in 5.17
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v1-1-0e08770820e8@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

[ master commit 142a88155d2b96ab859a0ed5c86ffe2eb2a16053 ]

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 4 ++++
 kernel/cobalt/vfile.c                                | 8 ++++----
 kernel/drivers/analogy/device.c                      | 2 +-
 kernel/drivers/can/rtcan_module.c                    | 4 ++--
 kernel/drivers/can/sja1000/rtcan_sja1000_proc.c      | 2 +-
 5 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 05dd6c8c5..99059d2e9 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -252,4 +252,8 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 #define close_fd(__ufd)	__close_fd(current->files, __ufd)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,17,0)
+#define pde_data(i)	PDE_DATA(i)
+#endif
+
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
diff --git a/kernel/cobalt/vfile.c b/kernel/cobalt/vfile.c
index a0ec5cad1..05fa48a09 100644
--- a/kernel/cobalt/vfile.c
+++ b/kernel/cobalt/vfile.c
@@ -146,7 +146,7 @@ static void vfile_snapshot_free(struct xnvfile_snapshot_iterator *it, void *buf)
 
 static int vfile_snapshot_open(struct inode *inode, struct file *file)
 {
-	struct xnvfile_snapshot *vfile = PDE_DATA(inode);
+	struct xnvfile_snapshot *vfile = pde_data(inode);
 	struct xnvfile_snapshot_ops *ops = vfile->ops;
 	struct xnvfile_snapshot_iterator *it;
 	int revtag, ret, nrdata;
@@ -318,7 +318,7 @@ ssize_t vfile_snapshot_write(struct file *file, const char __user *buf,
 			     size_t size, loff_t *ppos)
 {
 	struct xnvfile_snapshot *vfile =
-		PDE_DATA(file->f_path.dentry->d_inode);
+		pde_data(file->f_path.dentry->d_inode);
 	struct xnvfile_input input;
 	ssize_t ret;
 
@@ -497,7 +497,7 @@ static struct seq_operations vfile_regular_ops = {
 
 static int vfile_regular_open(struct inode *inode, struct file *file)
 {
-	struct xnvfile_regular *vfile = PDE_DATA(inode);
+	struct xnvfile_regular *vfile = pde_data(inode);
 	struct xnvfile_regular_ops *ops = vfile->ops;
 	struct xnvfile_regular_iterator *it;
 	struct seq_file *seq;
@@ -566,7 +566,7 @@ ssize_t vfile_regular_write(struct file *file, const char __user *buf,
 			    size_t size, loff_t *ppos)
 {
 	struct xnvfile_regular *vfile =
-		PDE_DATA(file->f_path.dentry->d_inode);
+		pde_data(file->f_path.dentry->d_inode);
 	struct xnvfile_input input;
 	ssize_t ret;
 
diff --git a/kernel/drivers/analogy/device.c b/kernel/drivers/analogy/device.c
index 5033c5d66..69492b96b 100644
--- a/kernel/drivers/analogy/device.c
+++ b/kernel/drivers/analogy/device.c
@@ -92,7 +92,7 @@ int a4l_rdproc_devs(struct seq_file *p, void *data)
 
 static int a4l_proc_transfer_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, a4l_rdproc_transfer, PDE_DATA(inode));
+	return single_open(file, a4l_rdproc_transfer, pde_data(inode));
 }
 
 static const DEFINE_PROC_OPS(a4l_proc_transfer_ops,
diff --git a/kernel/drivers/can/rtcan_module.c b/kernel/drivers/can/rtcan_module.c
index 3d07eaed9..c071e12c6 100644
--- a/kernel/drivers/can/rtcan_module.c
+++ b/kernel/drivers/can/rtcan_module.c
@@ -265,7 +265,7 @@ static int rtcan_read_proc_info(struct seq_file *p, void *data)
 
 static int rtcan_proc_info_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, rtcan_read_proc_info, PDE_DATA(inode));
+	return single_open(file, rtcan_read_proc_info, pde_data(inode));
 }
 
 static const DEFINE_PROC_OPS(rtcan_proc_info_ops,
@@ -310,7 +310,7 @@ static int rtcan_read_proc_filter(struct seq_file *p, void *data)
 
 static int rtcan_proc_filter_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, rtcan_read_proc_filter, PDE_DATA(inode));
+	return single_open(file, rtcan_read_proc_filter, pde_data(inode));
 }
 
 static const DEFINE_PROC_OPS(rtcan_proc_filter_ops,
diff --git a/kernel/drivers/can/sja1000/rtcan_sja1000_proc.c b/kernel/drivers/can/sja1000/rtcan_sja1000_proc.c
index 4813c5009..57fd80704 100644
--- a/kernel/drivers/can/sja1000/rtcan_sja1000_proc.c
+++ b/kernel/drivers/can/sja1000/rtcan_sja1000_proc.c
@@ -47,7 +47,7 @@ static int rtcan_sja_proc_regs(struct seq_file *p, void *data)
 
 static int rtcan_sja_proc_regs_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, rtcan_sja_proc_regs, PDE_DATA(inode));
+	return single_open(file, rtcan_sja_proc_regs, pde_data(inode));
 }
 
 static const DEFINE_PROC_OPS(rtcan_sja_proc_regs_ops,

-- 
2.39.2


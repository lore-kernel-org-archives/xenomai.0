Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1479468F
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:09:09 +0000 (UTC)
Received: from relay11.mail.gandi.net (unknown [217.70.178.231])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id C5D55C5112
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:44 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 8DC21100005
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:37 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 5CE28AC0B0A
	for <xenomai@xenomai.org>; Mon,  4 Jul 2022 13:08:36 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202207041308356e9ceb11b02b12b4e0
        for <xenomai@xenomai.org>;
        Mon, 04 Jul 2022 15:08:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=CCTTTBLZF4Ogp1T4lJsdB5IJjJAiHq3qf/NKJSOET2M=;
 b=dUl2R3jAicVoLq+UBz67xy4Hcx8Nw/vovs4bsjpuO8dU5GQhmPVmZNUp4G9tlzhXCINuuX
 bJac4yEwB6o6fkt5TGB+PuxMxjw1UDCOhFRQEHMbl3gsRgUDxRyfaDbPQ5+AGg7GQoMZ/EeT
 4d9AGD5PvoAut594C1mTpCPVr+N0k=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [PATCH 01/15] Account for switch to pde_data in 5.17
Date: Mon,  4 Jul 2022 15:08:21 +0200
Message-Id: <142a88155d2b96ab859a0ed5c86ffe2eb2a16053.1656940114.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1656940114.git.jan.kiszka@siemens.com>
References: <cover.1656940114.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool3: domain of rts-flowmailer.siemens.com designates 185.136.64.226 as permitted sender) client-ip=185.136.64.226; envelope-from=fm-294854-202207041308356e9ceb11b02b12b4e0-Utze1i@rts-flowmailer.siemens.com; helo=mta-64-226.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=dUl2R3jA;
	dmarc=pass (policy=none) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-202207041308356e9ceb11b02b12b4e0-Utze1i@rts-flowmailer.siemens.com designates 185.136.64.226 as permitted sender) smtp.mailfrom=fm-294854-202207041308356e9ceb11b02b12b4e0-Utze1i@rts-flowmailer.siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 4 ++++
 kernel/cobalt/vfile.c                                | 8 ++++----
 kernel/drivers/analogy/device.c                      | 2 +-
 kernel/drivers/can/rtcan_module.c                    | 4 ++--
 kernel/drivers/can/sja1000/rtcan_sja1000_proc.c      | 2 +-
 5 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index ff9f2c37cc..88152a25e1 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -54,4 +54,8 @@
 #define close_fd(__ufd)	__close_fd(current->files, __ufd)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,17,0)
+#define pde_data(i)	PDE_DATA(i)
+#endif
+
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
diff --git a/kernel/cobalt/vfile.c b/kernel/cobalt/vfile.c
index a0ec5cad1c..05fa48a091 100644
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
index 5033c5d663..69492b96b6 100644
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
index 94b8c64122..632c01bed2 100644
--- a/kernel/drivers/can/rtcan_module.c
+++ b/kernel/drivers/can/rtcan_module.c
@@ -267,7 +267,7 @@ static int rtcan_read_proc_info(struct seq_file *p, void *data)
 
 static int rtcan_proc_info_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, rtcan_read_proc_info, PDE_DATA(inode));
+	return single_open(file, rtcan_read_proc_info, pde_data(inode));
 }
 
 static const DEFINE_PROC_OPS(rtcan_proc_info_ops,
@@ -312,7 +312,7 @@ static int rtcan_read_proc_filter(struct seq_file *p, void *data)
 
 static int rtcan_proc_filter_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, rtcan_read_proc_filter, PDE_DATA(inode));
+	return single_open(file, rtcan_read_proc_filter, pde_data(inode));
 }
 
 static const DEFINE_PROC_OPS(rtcan_proc_filter_ops,
diff --git a/kernel/drivers/can/sja1000/rtcan_sja1000_proc.c b/kernel/drivers/can/sja1000/rtcan_sja1000_proc.c
index 4813c50092..57fd80704b 100644
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
2.35.3


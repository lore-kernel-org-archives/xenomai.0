Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83066DCF9
	for <xenomai@lists.linux.dev>; Tue,  5 Dec 2023 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D13626435FF8;
	Tue,  5 Dec 2023 21:22:16 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id I9-TpZe6KtaR; Tue,  5 Dec 2023 21:22:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 69BA46436004;
	Tue,  5 Dec 2023 21:22:16 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JshzoT5wlWxv; Tue,  5 Dec 2023 21:22:16 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (84-115-239-180.cable.dynamic.surfer.at [84.115.239.180])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 216556435FF8;
	Tue,  5 Dec 2023 21:22:16 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: wg@denx.de,
	rpm@xenomai.org,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH] cobalt/drvlib: Prefault io memory again
Date: Tue,  5 Dec 2023 21:22:10 +0100
Message-Id: <20231205202210.25477-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This issue was fixed a long time ago by
03d5b0b0083c ("cobalt/rtdm: fix caching and page fault issues with rtdm_i=
omap_to_user()"),
later with commit c8e9e166b ("cobalt/rtdm: introduce mmap() support")
iomap code lost again the call to cobalt_machine.prefault().

I have no idea why this took so longer to come up again.
Last week, while upgrading an aarch32 setup from Xenomai 2 to Xenomai 3, =
the application
failed due to massive latencies caused by page faults after writing to io=
 memory.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 kernel/cobalt/rtdm/drvlib.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 30455c3d7..620be27fa 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -1761,6 +1761,7 @@ static int mmap_iomem_helper(struct vm_area_struct =
*vma, phys_addr_t pa)
 {
 	pgprot_t prot =3D PAGE_SHARED;
 	unsigned long len;
+	int ret;
=20
 	len =3D vma->vm_end - vma->vm_start;
 #ifndef CONFIG_MMU
@@ -1774,8 +1775,17 @@ static int mmap_iomem_helper(struct vm_area_struct=
 *vma, phys_addr_t pa)
 #endif
 	vma->vm_page_prot =3D pgprot_noncached(prot);
=20
-	return remap_pfn_range(vma, vma->vm_start, pa >> PAGE_SHIFT,
-			       len, vma->vm_page_prot);
+	ret =3D remap_pfn_range(vma, vma->vm_start, pa >> PAGE_SHIFT,
+			      len, vma->vm_page_prot);
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_MMU
+	if (cobalt_machine.prefault)
+		cobalt_machine.prefault(vma);
+#endif
+
+	return 0;
 }
=20
 static int mmap_buffer_helper(struct rtdm_fd *fd, struct vm_area_struct =
*vma)
--=20
2.35.3


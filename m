Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855AB2156E1
	for <xenomai@lists.linux.dev>; Mon,  9 Dec 2024 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733733546; cv=none; b=kgMlZNwAohMYJpnrOOlYX0YNr+LbwDUlg4iaKquC00pxQIfoGKv14jrSGdV59blG75sYIKLTOrfwkdIsbJ75qHYZhsk73A35l2zdMr+rIU61D0BgUTv5ib250NvSSymgr7KjO4eD+hqe5pOwfwbssM0a/k+Nm3msCIWN1QmFUsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733733546; c=relaxed/simple;
	bh=/ikv7/dMfS5wVAlBcJe2yu4qRM0hnWU9bH1nd3jghIM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VYedRaG+xn20Gmn0CckVgwprushibdUuCAtxkeeUcNjV/1g3H8fwrD/6VbYbl4GzVGlmRAHvgeq2LpmXHos7iDOnPe1+6QF6cFXNsveArku2kcNtvmK0x1HuLcUkSB9F2+BaTkNzqqIixYIXCsgUXqmz9WUXyBX5mR/usKBu/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCxejOvZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCxejOvZ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-216585cbe1eso4352105ad.3
        for <xenomai@lists.linux.dev>; Mon, 09 Dec 2024 00:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733733543; x=1734338343; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WInaCvrEBvcvulRyW2Uif+2ELZIP/Kx4X/JmZKcuXqI=;
        b=LCxejOvZP8AZ/zR3HBWVVP+daztYAqVQKGgMp0LPq2SoWRHIuPFki2fLyATh6fY3t4
         VuajKJ7gxCLi9nVdEvpGSTinlbkA6tNJ3oHmgh0yLqzceBQ5HaJHIKm4pkaRvQNRrgXi
         /bJGWE9xAMeM4M9lqyRi4qfjncQUJRbqvcsNo0ISrrdM9hxO59i9oR8xvfZb08tAlEYx
         h3nd1Pk36uyl/Tb8geU2Ngr5KyheX9+sOruaUnXxXvO/F49f9hlJYCs80uWBowvgkBCP
         IAkfSxICcMXvzhTeaaeIuyHkTktjTQsAhBlnGiDIxNGr49CSZq4hcrNqnS+McM5IHX1A
         GP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733733543; x=1734338343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WInaCvrEBvcvulRyW2Uif+2ELZIP/Kx4X/JmZKcuXqI=;
        b=hZEm7gmzl4KEMWTML6ZSRXVemG/KGUNGagdm+mwUuP5Tthwjb2MF9xPdhAxkpvoF5a
         4CtbFK9k1evTmWrRpalC5mT55YlO7whOClZU0vwRdWyUcfK+jZ5n7lg2TjnLHlylu1+H
         y9LTg9ISktuGLkE5XYJH+YPs89BHUZiVJTSgLmC3G/kOuCq6n/BYfrRIPFIdOLdojbQl
         7wLX4VXtPsknvh7D5jl3iPdXPNDEWed3SPs1GQ+/7IRhhdV387P5LEJkyDqRqGp3hlec
         iPRFBjJs7h8bV2zDFbfVx2AiXQl9HO4wJ+NSMWmuXGOirM+FeNu395QgpseK5Rn1pQYL
         p1xA==
X-Gm-Message-State: AOJu0Yy3jptUK78QbwRTqihsvmjI2j2bwXboyt5rzSJLnvVI6+fEuqTn
	oZ5IcrS/qTRw4r/fdggk+RZEhJlcBtobIA/etj/UOH3zH2iJNmYxT8ziG3Wi
X-Gm-Gg: ASbGncsNgh5hlqVp92EykS2E6Wd1vcf4ifC7x46ubktPaZxVM+w9vJLXMS+3LvW/tAK
	ZZ7ghV9zV/Hyuc0BLEPFXyjZvtGEil43WhjVEbvBPWloKP0HsBg1n5GFlQk0TIbtBx/olu2epaj
	5pWoFhB8/rQ07FRjeP+gVFRPYWkQ9SHfI/QMx8Xto5ETLYNaYlmcpDWlg2b1N3+l5KwftIHf46H
	00JYOSKMVedphFe5Olu3W1BJ2FUkNBKC4VuxHTT1n4v+kZ4vISGdb1A9iLSJzdPYHrY4icU
X-Google-Smtp-Source: AGHT+IGEy4FhtZsCap6uNI+tRya1qH4Bo+yF1g/gbpDGkTWBFRobgAA4NuVfABqS4n54gm1XpJToyQ==
X-Received: by 2002:a17:902:d2cb:b0:216:640a:8a05 with SMTP id d9443c01a7336-216640a8e1cmr5486005ad.55.1733733543110;
        Mon, 09 Dec 2024 00:39:03 -0800 (PST)
Received: from c6b487f3e4fd.tail12dc50.ts.net ([223.72.120.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e64210sm67682545ad.77.2024.12.09.00.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 00:39:02 -0800 (PST)
From: Qichen Qiu <ruiqurm@gmail.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Qichen Qiu <ruiqurm@gmail.com>
Subject: [PATCH] evl: fix the gdb accessing control buffer issue.
Date: Mon,  9 Dec 2024 08:37:46 +0000
Message-Id: <20241209083746.672587-1-ruiqurm@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, EVL maps the control buffer using remap_pfn_range, tagging 
the memory with VM_IO. However, this prevents access by gdb.

This patch introduces the control_mmap_access function for the control 
VMA, enabling gdb access when CONFIG_HAVE_IOREMAP_PROT is supported on 
the target architecture.

Signed-off-by: Qichen Qiu <ruiqurm@gmail.com>
---
 kernel/evl/control.c | 53 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/kernel/evl/control.c b/kernel/evl/control.c
index 2d1b44f3b0dc..33ec47745740 100644
--- a/kernel/evl/control.c
+++ b/kernel/evl/control.c
@@ -8,6 +8,7 @@
 #include <linux/mm.h>
 #include <linux/sched/isolation.h>
 #include <linux/bitmap.h>
+#include <linux/highmem.h>
 #include <evl/memory.h>
 #include <evl/factory.h>
 #include <evl/tick.h>
@@ -335,8 +336,52 @@ static long control_ioctl(struct file *filp, unsigned int cmd,
 	return ret;
 }
 
+static int control_mmap_access(struct vm_area_struct *vma, unsigned long addr,
+			       void *buf, int len, int write)
+{
+	resource_size_t phys_addr;
+	pte_t *ptep, pte;
+	void *virt_addr;
+	spinlock_t *ptl;
+	struct page *page;
+	int offset = offset_in_page(addr);
+	int ret = -EINVAL;
+
+	if (follow_pte(vma, addr, &ptep, &ptl))
+		return -EINVAL;
+
+	pte = ptep_get(ptep);
+	pte_unmap_unlock(ptep, ptl);
+
+	phys_addr = (resource_size_t)pte_pfn(pte) << PAGE_SHIFT;
+	page = pfn_to_page(PFN_DOWN(phys_addr));
+
+	virt_addr = kmap(page) + offset;
+	if (!virt_addr) {
+		ret = -ENOMEM;
+		goto unmap;
+	}
+
+	if (write) {
+		memcpy(virt_addr, buf, len);
+	} else {
+		memcpy(buf, virt_addr, len);
+	}
+	ret = len;
+
+unmap:
+	kunmap(page);
+
+	return ret;
+}
+
+static const struct vm_operations_struct control_mmap_ops = {
+	.access = control_mmap_access
+};
+
 static int control_mmap(struct file *filp, struct vm_area_struct *vma)
 {
+	int err;
 	void *p = evl_get_heap_base(&evl_shared_heap);
 	unsigned long pfn = __pa(p) >> PAGE_SHIFT;
 	size_t len = vma->vm_end - vma->vm_start;
@@ -344,7 +389,13 @@ static int control_mmap(struct file *filp, struct vm_area_struct *vma)
 	if (len != evl_shm_size)
 		return -EINVAL;
 
-	return remap_pfn_range(vma, vma->vm_start, pfn, len, PAGE_SHARED);
+	err = remap_pfn_range(vma, vma->vm_start, pfn, len, PAGE_SHARED);
+	if (err < 0){
+		return err;
+	}
+
+	vma->vm_ops = &control_mmap_ops;
+	return 0;
 }
 
 static const struct file_operations control_fops = {
-- 
2.34.1


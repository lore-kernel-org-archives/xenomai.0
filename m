Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1645C1F668C
	for <xenomai@lists.linux.dev>; Tue, 17 Dec 2024 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446423; cv=none; b=n2EROD75u+Z1O+kt0x6tRkdjQJjV0q0OmVJiLxnGJ1RjaHxnmzjTC/MqSfgtSyH0Tag5Sx5hvFR7H6zSIwv+E6FzcfGNbsSyg06x9hlp4cKqqQpvODM0BvCCsm8Bf7jF76Gn0qfwYU4uir9xYTouYBDvnv3xR+5cv0D7YQst+L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446423; c=relaxed/simple;
	bh=lmFZaaPADlt9sYmCAS8O271XQ11QPZCYstaGYpxoxE0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ntP19uteUI1Ic7o//xjfMxlVmL2Hti9yoD9cTvyXJneyVl3E3uTyvN4okUlH9pOdIPVjhFB1N0NKpkL5vQG951M+R6CaRSLJBJx71P/02nGmYZcbT11uXMrR0JahMy9SFgYDlNsORNURoPo4f499I1gPo6TjC0j7yh0Ke9DTLcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoEDqaS2; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoEDqaS2"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-725ef0397aeso4792710b3a.2
        for <xenomai@lists.linux.dev>; Tue, 17 Dec 2024 06:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734446421; x=1735051221; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mZdkrCjjTTy6GU68cn5+2A4VStYJVFsv3fKn3u/mqbU=;
        b=DoEDqaS2P0gqNGwECgvQAeJiSxSO928h/2SZ5vwGwsIlC7Vinf0+0stZ4lZULPeHe1
         xAV6NpN64Zvi6fb4aO96kxbVc89YIvekkhV6aZ6tvR1yoABz629+y3BgFWM0VRdU93Rv
         bhyG8mOCZPREOdRdRBcUlub2+LjHgFDP5DcJfiHgX091aMrOtsgLW1MawGJbs1ei7lEK
         n9h3C7V1+v+gPiQN47OIycrHlhQanL4TRvf+N5G/9jFPuJmea2lYIFfdA4GXWddUgA+8
         YW0fW4r1RAZbmg3zKry9gwqgMGgOOBj5rXnHZ6ZV1NHrlt8rGE4aPQCaz1czDrJdxqUC
         6mhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734446421; x=1735051221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZdkrCjjTTy6GU68cn5+2A4VStYJVFsv3fKn3u/mqbU=;
        b=rPRcSOxylMsG+0YZdEZJXMqtTGk6wVxgNVqSsT1LEclxJ7tiumgJVizvEF0UAkNSbR
         gPDTxnGBxL/jx8nXI0esaCW1fkJ7etUCeDtLovWpdK/dkzLKvxqzwdH873PdFqi/4mVV
         OegmpT+4kL3Ljsggtk+ltK/lRZ0YK04WbHKlqnXrxspr82ze0gswmt3eg2yEiI0y9fWx
         +9pLmIIuUFtSAwuQsVEF4TpPmCmT6CiJ4Y5Bt7RldwTyHHVHnDwIY7KmlU8lJc+v27Y+
         qQEMnupDJfjZpR16njZgWGZ2aXoz9M49dLl8fv1p6Ltyj0krdOaHu0v+paN1dcm02qXB
         RUwg==
X-Gm-Message-State: AOJu0YxA//0VOGoYch0STpasVO0x+7YfT0JX8JjBOItrJKD8udbQOROH
	sMS2xP85j4/AqrJlv8sFBdy4mhJilHoEYNYhQE1MIB/4TjROWi5et5b9uM89
X-Gm-Gg: ASbGncsfNQZQ4ioNhtIhTUaTPqYt0LFI58LzDRF5JDMHX5h/chZq0wJ8HtCZlUoFl9g
	IEAoGgVsfxGVhKTEo4g9RxGe0+HmLn9patDaHaDy/EGrQeUnJmZrp4cVflksuYzZMJuelmBq7H2
	vbtv8IZe2RvTFRKs986D7tFs8x6XpiUQNQ0bEqJh2Hw5WzfH1UZk+hFtZo08CaVZFyRwQG0dh+W
	DSkWAhNMbgQqd2zNjwq0L4RiAuocg7qWuQVtLDgnpef+DQXvfY=
X-Google-Smtp-Source: AGHT+IF9MjCPQNf35hqPjt0z/eQIVPwvb5nPAdgYrZrkt5JdQvF/414/grktU1cFbac49n5sHlnfqg==
X-Received: by 2002:a05:6a20:734b:b0:1e1:adfe:c43 with SMTP id adf61e73a8af0-1e1dfd61895mr27380302637.9.1734446420629;
        Tue, 17 Dec 2024 06:40:20 -0800 (PST)
Received: from localhost ([223.72.120.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bce2f4sm6665862b3a.196.2024.12.17.06.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 06:40:20 -0800 (PST)
From: Qichen Qiu <ruiqurm@gmail.com>
To: xenomai@lists.linux.dev
Cc: ruiqurm@gmail.com
Subject: [PATCH] evl/memory: allow system heap inspection using GDB
Date: Tue, 17 Dec 2024 14:40:15 +0000
Message-Id: <20241217144015.1879213-1-ruiqurm@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GDB was unable to inspect the evl shared heap mapping regions(i.e. 
__current_evl_window) due to limitations imposed by the VM_IO flag when 
ptrace accesses memory regions that were mapped using remap_pfn_range. 
This restriction hindered effective debugging.

To resolve this issue, the shared heap is now allocated using `vzalloc`, 
and the memory is mapped with `vm_insert_page`, which work seamlessly 
with GDB and ptrace.

Signed-off-by: Qichen Qiu <ruiqurm@gmail.com>
---
 kernel/evl/control.c | 15 +++++++++++++--
 kernel/evl/memory.c  |  6 +++---
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/evl/control.c b/kernel/evl/control.c
index 2d1b44f3b0dc..32764a9fc08b 100644
--- a/kernel/evl/control.c
+++ b/kernel/evl/control.c
@@ -338,13 +338,24 @@ static long control_ioctl(struct file *filp, unsigned int cmd,
 static int control_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	void *p = evl_get_heap_base(&evl_shared_heap);
-	unsigned long pfn = __pa(p) >> PAGE_SHIFT;
 	size_t len = vma->vm_end - vma->vm_start;
+	unsigned long addr = vma->vm_start;
+	int err;
+	struct page *page;
 
 	if (len != evl_shm_size)
 		return -EINVAL;
+
+	while (addr < vma->vm_end) {
+		page = vmalloc_to_page(p);
+		err = vm_insert_page(vma, addr, page);
+		if (err < 0)
+			return err;
+		addr += PAGE_SIZE;
+		p += PAGE_SIZE;
+	}
 
-	return remap_pfn_range(vma, vma->vm_start, pfn, len, PAGE_SHARED);
+	return 0;
 }
 
 static const struct file_operations control_fops = {
diff --git a/kernel/evl/memory.c b/kernel/evl/memory.c
index 1da5be623d69..053a377396d2 100644
--- a/kernel/evl/memory.c
+++ b/kernel/evl/memory.c
@@ -630,13 +630,13 @@ static int init_shared_heap(void)
 		CONFIG_EVL_NR_MONITORS *
 		sizeof(struct evl_monitor_state);
 	size = PAGE_ALIGN(size);
-	mem = kzalloc(size, GFP_KERNEL);
+	mem = vzalloc(size);
 	if (mem == NULL)
 		return -ENOMEM;
 
 	ret = evl_init_heap(&evl_shared_heap, mem, size);
 	if (ret) {
-		kfree(mem);
+		vfree(mem);
 		return ret;
 	}
 
@@ -650,7 +650,7 @@ static void cleanup_shared_heap(void)
 	void *membase = evl_get_heap_base(&evl_shared_heap);
 
 	evl_destroy_heap(&evl_shared_heap);
-	kfree(membase);
+	vfree(membase);
 }
 
 static int init_system_heap(void)
-- 
2.34.1


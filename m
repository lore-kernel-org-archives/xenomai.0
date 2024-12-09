Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5057A1B424F
	for <xenomai@lists.linux.dev>; Mon,  9 Dec 2024 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752049; cv=none; b=oX5QG5aCXbTCH28THXlukunF3fhnMzA6R1Qu7sGlcJWioEHM/0gTb6JFaAA5ItYP5EnsT0GE1tWu/x51t7bRw1qC20XQlzdz6b2ApRcqWsIEXroXp13y1eAfkzwNhNQH9AOiuP953Gu0wIOrOIjEfE4uIC3Dt0TQNYuhnyu9/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752049; c=relaxed/simple;
	bh=eXslCOWNADyJlJXDMfuLiRbhrimGwL4ncqYykQoDgto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KAIQtE3A+vDiOzlpppFrGWLTj0SomaYGdyRK//MzCHfhnezf0AIOs6cVoxNtXgy1BSXqkO2WkVilIPKMreL5Wt0T5rfeyI/yUebIFfFFzsXWdTspl69XpQ14FKxXEvaCCC/DNUdTrh+qwK5N3BbMTEVd7lo89yvtw0CsLMGm0Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlfwFqaW; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlfwFqaW"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7f71f2b1370so2783977a12.1
        for <xenomai@lists.linux.dev>; Mon, 09 Dec 2024 05:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733752046; x=1734356846; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mq/u5uvV4uHMTl+CeI8htrUZY1ihZthcjNZalQHfw/Q=;
        b=JlfwFqaWYeKK8VgTmXpissoineKj4k3k6shyO8KqZzYPmC0b2aAM4iPeM3XQi91zBI
         Et2MEUNNXgg/hFbWQpFLns+T7oER3x4JR7MrIFsbGJv7/kITrMcQ0o834il5d/mtpHho
         BllAWI6GV12DUM1Cs6g6DlMhNahEyXoBaxIOvDtcWPAHW+VlUVvm6fq1xbV3EiIC89HH
         ZxYshSnta704EK6psUkcHhYQWB2Hq+FCVdUMt4GVDjoJESYVp9NxIyr6PbXn+ckoYrJE
         suLnZkAWu5/Uz70Dn5o1kNw9B0ypwZK01xs3BDefk9/FfHZ5/LApTWsu4okjS1JhFIXr
         GGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733752046; x=1734356846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mq/u5uvV4uHMTl+CeI8htrUZY1ihZthcjNZalQHfw/Q=;
        b=nyvzRm182RSVd5Wzgi3Y0Dlh1/mrtU4SWaVZTFtOOhFlw1R0DMDtUX/z0wpClxmoOv
         499+B5knFMTis6Z4XYOq6vFhBdRoXw9Wi5NIKbRaV+z4tdB0KcwWDHDr2wi4yCHrqiKR
         d+UkmsvNcX9Mvo039ZZ1uZ/gxKomv2rDFI8h9BaKRhvycn4DFoN64zWdIoRQwGQTY1r9
         LjqyQb2gVUxPgLSxR9KuAyVv7fB2DdeLB6Imq+oZxcM9LzL859oM7MO2vo9r+vxMiPg8
         iX3ZTUO9HrB20yCrWrs9Wb+sxK9jDVEKWrFdUURZ6WwV1L/wSxXHKrX4bawdKtih64to
         wXtw==
X-Forwarded-Encrypted: i=1; AJvYcCXTVKHpE8eC9b1TyIVG8kYVjID5EFxu9GZS41lWntCjUyG+vC+ACj6xNLLv1proGuuIKVfiBCvV@lists.linux.dev
X-Gm-Message-State: AOJu0YwPmeJuK39UgO912z/WhwMnQbJUEQ43TUr1xveeekNn0GzO59Jt
	ELN0xIlLxLI4vJx/oyKt+AZ8qSQ2+k8/7YZxYv81K7e++wm/v1h+
X-Gm-Gg: ASbGncsD2YSAtZqZ0GpZNKF0ySSBGowf614KcB1w7WKvCT38lCGRqjwJ9ZnlrPwF3W1
	y4Dwv1TxjpeSvjaLWkj1nOkxwScToin+qAEwtSLKkP9nmsjoZBvUytME5I73md1FygwGtBKH0kQ
	TMQy3fJhJf/ZRexmE5GwkgcokjYBvSQaVFvURd1hlbobSnRz3acTtxroKbkSye6lZp2s3Bfm2OY
	wRBTHYvFvwOhDfcZ3S0bQhQq+a2bIPiR4d6NCHhcM+O
X-Google-Smtp-Source: AGHT+IHA7vC03Hq6giQZjaXH1l6BQL3TiG7MsvNdcDmYnhOk0+OfaYi6+iJzWDw0DORfLyw8gNAvIQ==
X-Received: by 2002:a05:6a20:6a06:b0:1e1:9fef:e95c with SMTP id adf61e73a8af0-1e19fefeab1mr7687976637.12.1733752046409;
        Mon, 09 Dec 2024 05:47:26 -0800 (PST)
Received: from localhost ([223.72.120.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2a903a3sm7513767b3a.116.2024.12.09.05.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:47:26 -0800 (PST)
From: Qichen Qiu <ruiqurm@gmail.com>
To: florian.bezdeka@siemens.com
Cc: rpm@xenomai.org,
	ruiqurm@gmail.com,
	xenomai@lists.linux.dev
Subject: [PATCH v2] evl: fix the gdb accessing control buffer issue
Date: Mon,  9 Dec 2024 13:47:22 +0000
Message-Id: <20241209134722.747090-1-ruiqurm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1a1ba081bad39a548d0ca0b1bce44b7c9643d9ce.camel@siemens.com>
References: <1a1ba081bad39a548d0ca0b1bce44b7c9643d9ce.camel@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Background
I tried using GDB to debug an EVL program but encountered an issue: I 
couldn't access __evl_current_window. This variable resides in a 
memory-mapped area of the control factory, where the kernel uses 
remap_pfn_range to allocate a region for communication between the 
kernel and user space. The remap_pfn_range function sets the VM_IO 
flag for the memory, which may disallow gdb read the memory directly.

When GDB attempts to access this memory via __access_remote_vm, it 
fails in get_user_pages_remote function, goes into the IS_ERR(page) 
branch. If the CONFIG_HAVE_IOREMAP_PROT configuration is enabled, 
which depends on architecture support, the function instead invokes 
vma->vm_ops->access.

To address this, I implemented a custom vm_ops->access function that 
allows GDB to copy values from this memory region, enabling proper 
debugging. See the reference for detail.


Reproduce:
create a simple evl program:
```c
 #include <stdio.h>
 #include <evl/thread.h>
 #include <evl/proxy.h>
 #include <evl/timer.h>
int main()
{
    int efd,tfd;
    struct evl_sched_attrs evl_sched_attr;
    evl_sched_attr.sched_priority = 1;
    evl_sched_attr.sched_policy = SCHED_FIFO;
    efd = evl_attach_self("a");
    evl_set_schedattr(efd, &evl_sched_attr);
    evl_printf("is_inband=%d\n",evl_is_inband());
}
```

Compile it with debug symbol. Here is an example command:
gcc -g -O0 -o a a.c /usr/local/lib/libevl.a

Debug it:
sudo gdb ./a  -ex "b 14" -ex "r" -ex "p/x *__evl_current_window"

If the patch is not applied, the __evl_current_window can not be accessed.
Otherwise, it may print:
$1 = {state = 0x4080, info = 0x2000, pp_pending = 0x0}
(the gdb will affect the thread state)

Reference:
[1]: https://stackoverflow.com/questions/3640095/gdb-cant-access-mmapd-kernel-allocated-memory
[2]: https://stackoverflow.com/questions/654393/examining-mmaped-addresses-using-gdb

Signed-off-by: Qichen Qiu <ruiqurm@gmail.com>
---
 kernel/evl/control.c | 52 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/kernel/evl/control.c b/kernel/evl/control.c
index 2d1b44f3b0dc..dba951d2e9d4 100644
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
+	virt_addr = kmap_local_page(page) + offset;
+	if (!virt_addr) {
+		ret = -ENOMEM;
+		goto unmap;
+	}
+
+	if (write)
+		memcpy(virt_addr, buf, len);
+	else
+		memcpy(buf, virt_addr, len);
+
+	ret = len;
+
+unmap:
+	kunmap_local(virt_addr);
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
@@ -344,7 +389,12 @@ static int control_mmap(struct file *filp, struct vm_area_struct *vma)
 	if (len != evl_shm_size)
 		return -EINVAL;
 
-	return remap_pfn_range(vma, vma->vm_start, pfn, len, PAGE_SHARED);
+	err = remap_pfn_range(vma, vma->vm_start, pfn, len, PAGE_SHARED);
+	if (err < 0)
+		return err;
+
+	vma->vm_ops = &control_mmap_ops;
+	return 0;
 }
 
 static const struct file_operations control_fops = {
-- 
2.34.1


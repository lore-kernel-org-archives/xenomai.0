Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BCE1AA1C4
	for <xenomai@lists.linux.dev>; Wed, 11 Dec 2024 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733930859; cv=none; b=lkfz+XVKHa3FgAKq747QoOUP4Txf5G1dM/8Mo7zAkgrStB+1OAXfNdKiRMQ+PrbLOoclBS4Gp6lq4r/bQEsmhyUXP4QQBzqkvOhFu9MWhjcCBCLYKvoSuXeAxCBlC+2FV7j0HwGAwNg/CeVj/oFdL5aP3v+kBPXsXMA7Orw+XZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733930859; c=relaxed/simple;
	bh=KPd+krFUetqbEpmlhPCyPN5+2Hm444I44guNqioaPMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ciG4fynCtNIvj9OT/b85WiwzB3ksOOAid7XG/TT/KbgmAtxe1gk1suEdaZK2KYPyWZYmXv9geY9dSSiaFJ2tSP4IeAFIIR0h7F9+GY9UNcjjUgCfduo5JlUksm+S2bWJAQQ4w3OiuonSz+CghT6yOfD+pmUseZF4FyIclrK1BK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvwvnUHM; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvwvnUHM"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-728d1a2f180so697205b3a.1
        for <xenomai@lists.linux.dev>; Wed, 11 Dec 2024 07:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733930857; x=1734535657; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6cp2UgtmyQlJVri9QOds7GncUNP7JAcZt24OBxaAoA=;
        b=gvwvnUHMqlilYO+AsgsfE05qZirVrW6jSq11BhV4C9JNEHZSUJwnzsWPjPZQuWaGFb
         Kk1a+xo9p84KrhBNCVb1/0qeX+tOIg82fE/3bsrF9OTSYZyu4uPZ82ooyD/5SQ8zVihg
         NP27fldKjdkCsXQ7pjSM0s/1H12Ylk9Q7kyVY/uBKPL0X/El/ostD4iiPLX8i2aN1YQT
         pQPr1MzEfComgxtTqhGeH2Fkl4ZE1cpqRFHfl+S9+CMJg41X3zG74hIbmq70DUqOezn3
         rxPSTxphsMLfuo7tj7SzMiChjkuFtJOOW50MzN8KFuXSTRSA788hEULRHDG8Jyfh+U08
         4zzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733930857; x=1734535657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6cp2UgtmyQlJVri9QOds7GncUNP7JAcZt24OBxaAoA=;
        b=pbVOpfmaIs5GbIioaqVg8AXWn7DBEdBsBkRvT2I9nkrI2MHJ3d4EUL1IKEn6HOGmyA
         JJLu1OY0wbJiZSi/6JJ6lgfLYXnz0c5RO6w0aSmNL0oLd01K5JHj8vmYuwH6GyCRXcQy
         3xbloC69jre6iQnVohonajF0Kkqo8VP3NIrMfeX0mKI5Iv5HZSMyYg/fOvf5aB0nQJYe
         sOPOI272xcFwcZXnUO5ajSW6DgBcq6KzBQxyuwiWwFlD32cyzkgvYoOEOIOm59L9MKLq
         CiqVc+DvwKefg2CGbLCkiiXzHIBWqfXFOd5SLrzoxEO8mBWgahTozoYjPUVtK9ln5VNL
         nlpg==
X-Forwarded-Encrypted: i=1; AJvYcCVVaD1y30mI1z9lfLKP/9j8IodBtaMjl8EQjSxToX42bKDKjw7VWjk5oIeGleVfWmuyzG17Hcyc@lists.linux.dev
X-Gm-Message-State: AOJu0YwPWMmeFDYbOOv0KmCapveHwtVY8cUwSP3e/HZhq4+/SdiXvBNC
	1xoRVp8FTw1WCEuBaxpbGkSaKqInKhxrG8fGjihp2CS0a7MzGuE1jUIdGoUs
X-Gm-Gg: ASbGncvx8iJm336AC93I4s6CuxE6U2XBWeUqyymn+urUU0oJNadF5FeoqgK3axySojV
	bYnSKwdlM8xlk9zZesgyyR0PtkkvpqI2pbpOeL9rSj1/r/I8fbWS2lCQ6sK5w2vXY43LO4qmoQd
	dpivplRdPVWXAYndKcelKkv2MiekNdORIufUZMSV6cohT8BtDMmEdr156x7vVQ95g/ZklSrjSUF
	uyLrmal5VWEr2Odlus7TTUNFUny6Ny3824Bzb8bLmkNuwC3
X-Google-Smtp-Source: AGHT+IEnmbrN6u2RDDRMYIuHGA+kkHpUzNsO2XHpL5zqEG4Rfx2O+TbZBAaoBVHaCFIY2bNX6UupWA==
X-Received: by 2002:a05:6a00:3cc8:b0:725:4a1b:38ec with SMTP id d2e1a72fcca58-728edb5c343mr5274021b3a.3.1733930856978;
        Wed, 11 Dec 2024 07:27:36 -0800 (PST)
Received: from localhost ([223.72.121.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725dad8ade2sm7360620b3a.49.2024.12.11.07.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:27:36 -0800 (PST)
From: Qichen Qiu <ruiqurm@gmail.com>
To: rpm@xenomai.org
Cc: ruiqurm@gmail.com,
	xenomai@lists.linux.dev
Subject: [PATCH] evl: replace `remap_pfn_range` with `vm_insert_page` in control_mmap.
Date: Wed, 11 Dec 2024 15:27:30 +0000
Message-Id: <20241211152730.864059-1-ruiqurm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8734iwc334.fsf@xenomai.org>
References: <8734iwc334.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, I used vm_insert_page to map the area to user space, and it 
successfully resolved the issue.

Signed-off-by: Qichen Qiu <ruiqurm@gmail.com>
---
 kernel/evl/control.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/evl/control.c b/kernel/evl/control.c
index 2d1b44f3b0dc..eee4bcaad390 100644
--- a/kernel/evl/control.c
+++ b/kernel/evl/control.c
@@ -338,13 +338,22 @@ static long control_ioctl(struct file *filp, unsigned int cmd,
 static int control_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	void *p = evl_get_heap_base(&evl_shared_heap);
-	unsigned long pfn = __pa(p) >> PAGE_SHIFT;
 	size_t len = vma->vm_end - vma->vm_start;
+	unsigned long addr = vma->vm_start;
+	int err;
 
 	if (len != evl_shm_size)
 		return -EINVAL;
+
+	vm_flags_clear(vma, VM_WRITE);
+
+	while (addr < vma->vm_end) {
+		err = vm_insert_page(vma, addr, virt_to_page(p));
+		if (err < 0)
+			return err;
+		addr += PAGE_SIZE;
+		p += PAGE_SIZE;
+	}
 
-	return remap_pfn_range(vma, vma->vm_start, pfn, len, PAGE_SHARED);
+	return 0;
 }
 
 static const struct file_operations control_fops = {
-- 
2.34.1


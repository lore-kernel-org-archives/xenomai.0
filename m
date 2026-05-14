Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5399213AD26
	for <xenomai@lists.linux.dev>; Thu, 14 May 2026 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778785365; cv=none; b=AQG8xz7TvBw36SZCAuI0s+YJl3CLsu+jjQBKuFnLfUl9/DxZJ96dkaRP1rCrrbL7p4n2k4iBiPaLVcF6ayGRUwCtaSpn108DYQI+1DfTGEm79+WClbBlvdbNPqsH+wKnvbgKu/GI+aMMNr+g8wB/jQHu0E8sEJo3I/YME0ilA/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778785365; c=relaxed/simple;
	bh=X5mh9LyA5nQr4RGSlH9dJp7UCfBbO+zHCvhmtqkysJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yikfdg/L3rHRkVb95f+iYF2M9yPTyNYhPGcpXKWHm3EVESQvhT1Xl4RquMJ9z9bFEJY/28jhIOk752Vt4PVGYm1gSmNbRaLSpR8JKDTZIs6CDisWH4knGNyVNO/GSDFGgDQZv8J6ZaKOStkRxAAvylMn0d4x5+jrYUDSZPpgEB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4fF/Y2x; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4fF/Y2x"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2f7020a928eso11752347eec.1
        for <xenomai@lists.linux.dev>; Thu, 14 May 2026 12:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778785363; x=1779390163; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ek8D1srXo4Y4sHkQnMwh5PpNhJ5rkKw2ADE6ue7fUN0=;
        b=A4fF/Y2xqg2dc+WeXWRhXJdupB4ciogDPf+es0Fupay5whR01zzbFmj10AXlU2mXE6
         q/+4jxOmH8fLmun+hxaKZcdMZmli0nL4354bPyqbkKr4hyFdC0hzAZCjykF8h/VNNEmY
         7mfdBK8hEpy4wICuLdPAaAGkvkoNTyymw6IrNcAgNDL99nzua22rIaQKo5Ptw0iywb5e
         doHLD84uK44lCuS+FEtMu2N49w+V9RK/2stlu7JywGZCYOps6pct/OA6wcxuwKPTzVY0
         Kfco+AMDFGgXtTsPb4Kd424rQies4+/OsIS1J9jaq2jwl3NvwsKi4hRQ9RtwmGX1/8vL
         q0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778785363; x=1779390163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ek8D1srXo4Y4sHkQnMwh5PpNhJ5rkKw2ADE6ue7fUN0=;
        b=QsaBf7jOqeO8DWCPaxXExY7n9FZOjB5ucJMgJkBTjg4qvFI6vvYdY189Jvg9CSDoap
         GZdD+rNTcqjhRdBJ4roxJx5oL/v4xjPE/UfapxIubPpwpfRu7xsNmCbCPl9i29MuJkPI
         +/Qp1CAvYapX+pxDajkxPCtZQKtMKm5N4Tk2+eAZLWUz9Mjkdlozt4mZ5/As2VuI0pvi
         61dIHsy/KdInUI9w8cprsJMilxBEO5Hn1BCiLGPGi0/ABRHLzIp2lRl1vRTvHnTH3IC+
         y3K03MsYizKaq0PGWpWH0nilwK+trjZf238vaY4C15/S/YjKo7nGX9/NahJj/Gk2xuCG
         jl+A==
X-Forwarded-Encrypted: i=1; AFNElJ/YMoTCyBmblwkd/AGzCtV8PVi3YYWmgSOV7NK2B+aW64ZHTibA2IoDa8Mjvf1fsu2MV45W02/C@lists.linux.dev
X-Gm-Message-State: AOJu0YzCCOMfcgbSu1Vw4Hiq3SncLoBhZ3mbJzrrC4kUNijj0eHixKhQ
	mLn4JhPrkNymGIi+xc+Hrpvib7hDHZrMDBgd7iuJ59d/iCR5v9jO40L4
X-Gm-Gg: Acq92OGcwp9EJmPQqp2KuE+te+/9/wk9DtKDfEeMuMY3lqGELc27RtlTG91E7TIEmvX
	2PTJXzZRnr9702I12aJmFqHfoyHXDcAT2GqQJ74nKufXuqWcvw4LiCUW8XqkatcO/IYiRDSzNJA
	gxZ7JI+eauhaTdO9B9yPlQACMe/7V3ki+VEcure9PuL+id4USNlMS4kWhzqmaguHu/QioljDPk/
	8FxGeGu6ovLrYxAJv76GWZz+bPJgYwlpeZjjmhEqFph7ncg4iFeaMmmKMUF4p2a2MoPjz8x+/4c
	wDvOG/cbvBZ2Zi/D86nZ/YZiK36U9Gh0sEn+F3tUzm8RvYfYRX/DV6f5yleA62etkO38S8rvGjr
	J9vIf/EJiYg1HYf71bPJStblsrwufe8mR3mV7QQim1eP5Mr/L0MKW4zPi97b5QxwJKKkEdQ3fhg
	U93qqBjMGfEI+0WXqwSOmyEdP4pHlN0Z8b
X-Received: by 2002:a05:7301:2907:b0:2ed:75d:fe40 with SMTP id 5a478bee46e88-303984bf216mr455337eec.15.1778785363376;
        Thu, 14 May 2026 12:02:43 -0700 (PDT)
Received: from localhost ([47.176.121.166])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30290c4a699sm4145330eec.0.2026.05.14.12.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 12:02:42 -0700 (PDT)
From: Jay Sridharan <jayasurya.sridharan@gmail.com>
To: rpm@xenomai.org
Cc: brandonho667@gmail.com,
	brho@relativityspace.com,
	jayasurya.sridharan@gmail.com,
	jsridharan@relativityspace.com,
	xenomai@lists.linux.dev
Subject: [PATCH] update caveat.md about memory compaction
Date: Thu, 14 May 2026 12:02:08 -0700
Message-ID: <20260514190207.40567-2-jayasurya.sridharan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87ecjpj88r.fsf@xenomai.org>
References: <87ecjpj88r.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jay Sridharan <jsridharan@relativityspace.com>

Thanks Phillipe - maybe try it now? First time sending in patches via email...

---
 content/core/caveat.md | 62 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/content/core/caveat.md b/content/core/caveat.md
index b24e270..912b5ba 100644
--- a/content/core/caveat.md
+++ b/content/core/caveat.md
@@ -70,6 +70,68 @@ which depend on instrumenting the spinlock constructs (e.g.
 `CONFIG_DEBUG_PREEMPT`), you may want to disable all the related kernel
 options, starting with `CONFIG_SMP`.
 
+### Memory compaction and page migration impact real-time behavior {#caveat-memory-compaction}
+
+Several kernel configuration options related to memory management can
+introduce unpredictable latency through page migration and page fault
+handling, which is problematic for real-time workloads:
+
+- `CONFIG_COMPACTION`: Enables memory compaction to reduce fragmentation
+  by migrating pages to create larger contiguous memory regions. The
+  compaction process can trigger page migrations that introduce latency.
+
+- `CONFIG_MIGRATION`: Allows the migration of the physical location of
+  memory pages of processes while the virtual addresses are not changed.
+  Useful for allowing the kernel to move pages between NUMA
+  nodes or during compaction. Page migration involves copying page
+  contents and updating page table entries, which can take time, or
+  cause page faults when page table entries become temporarily unavailable.
+  The use of `mlock` or `mlockall` does **NOT** automatically guarantee
+  that a page will not be migrated. See below for more.
+
+- `CONFIG_TRANSPARENT_HUGEPAGE`: Transparent Hugepages (THP) reduces page
+  faults by mapping 2MB instead of 4KB pages, but causes higher latency
+  during faults due to intensive memory allocation and zeroing. While
+  reducing the number of faults, THP can incur higher latency during
+  initial memory access or when khugepaged compacts memory.
+
+The best approach depends on your workload characteristics. In an ideal
+situation, you would disable `CONFIG_COMPACTION`,
+`CONFIG_MIGRATION`, and `CONFIG_TRANSPARENT_HUGEPAGE` entirely. In other
+situations, you may need to keep these options enabled
+
+If you are running applications that alloc/free memory often, and/or need
+a steady source of consecutive pages, you may need to keep `CONFIG_MIGRATION`
+and `CONFIG_COMPACTION` enabled. Without it, your in-band applications may
+experience out-of-memory issues.
+
+Luckily, procfs provides tunables to control compaction behavior:
+
+- `vm.compaction_proactiveness`: determines how aggressively compaction is
+  done in the background. Write of a non zero value to this tunable will
+  immediately trigger the proactive compaction. Setting it to 0 disables
+  proactive compaction.
+- `vm.compact_unevictable_allowed`: When set to 1, compaction is allowed
+  to examine the unevictable lru (mlocked pages) for pages to compact. This
+  should be used on systems where stalls for minor page faults are an
+  acceptable trade for large contiguous free memory. Set to 0 to prevent
+  compaction from moving pages that are unevictable. On EVL, the default
+  value is 0 in order to avoid a page fault due to compaction.
+  (`CONFIG_COMPACT_UNEVICTABLE_DEFAULT`)
+
+procfs also provides an interface to manually trigger a memory compaction
+operation using `vm.compact_memory`.
+
+Using these options, you can perform a sequence such as the following to
+prime the system for reliability:
+
+- Launch EVL threads. At the end of initialization, but before calling mlockall..
+- Trigger a memory compaction manually using `vm.compact_memory`
+- Once complete, call `mlockall` to lock pages.
+- Then, disable `vm.compact_unevictable_allowed` to prevent those pages
+  from getting migrated.
+- Finally, launch other in-band applications.
+
 ## Architecture-specific issues
 
 ### x86 {#x86-caveat}
-- 
2.43.0


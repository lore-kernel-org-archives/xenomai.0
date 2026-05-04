Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C5636493C
	for <xenomai@lists.linux.dev>; Mon,  4 May 2026 17:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777917139; cv=pass; b=a6HYkVv4GprTQmH2YVPVENtTHVQ8PpWXUL30TqisafqQt2LLVot/QTKeQjzNcd0uFCPJuAyfGAXRbFWVkvJa5h6j4FESCuT7UR3rBAfTb08IgM9wJNjIFCovGlKObHvOfaR0siloYSanDTMIGVBsgq8l90hmeaJFfetV0DNIPds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777917139; c=relaxed/simple;
	bh=KhREE1xKs/17kaKXqw4s8f7XgWgIKhejbS0v2eXev54=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SxtugSvqBdXUBu5YnkKmPFHSLdVK+JGxDiq3ChNN1CMR4tAXFgRJBB0/LCaGYslsCFgRWUexfl5xHyoCXg0SJfkaRv1c5Y8ecllAdp+WT0H1AuyGLgVqqG/qKZIfU485hiT552HIAiMvE/LDVbbGWHCdCyHxfcCNvO0ty99lC40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khIwxxqp; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khIwxxqp"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38eab6cf7d8so36952561fa.1
        for <xenomai@lists.linux.dev>; Mon, 04 May 2026 10:52:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777917136; cv=none;
        d=google.com; s=arc-20240605;
        b=TDJJeNAiStl7wx1Y7qlmoKNr2wWubgi0fEoB41CQe+jwgX5Vc2ZSNgCJvnAKsYAP4b
         FSIeLsTzl+fJYcLni94Xo4Dq88/xK12IfSLJfqqX9bPlIV/u7V+KQ/gF9SRXNoAJps9V
         hHWCQ65Yu5xVkjm9GgOvHZv4TzEgEJsEiL4dQYVM+8lofzst1UY5VKMkFXNc9EBu3o3t
         WKZlQheuK11evkM5J9Ld/4MD4SApfJeNn9bRb+59sSTWc3L6VFhVQxQwwOhIRFIWVX/f
         oCv6pfJoBnEPV59p3Y6toFFAk4Bf/OnRvoX0n2jnOs93cQy8qH+wjKmMCkkY5aT5yupP
         XJGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=3RODZ6ZJLqPcgMt+PTjZg5DpfTcswq+tBneouSfN1S0=;
        fh=FQH4Cv9TdJFMKHzBXiBjgcXuXvsswzjMm+Q1PRaPVoU=;
        b=eYHMvoNq5T+AgwVgm7h6tN7srkCQoCdy9ROoGKFNBsR5IEnyHypgt+hk5l+UKU8a7+
         F5efYLsPRzjnMJq9zqn5nvncqf0KZIRQtJOPD0j1+itHJ1fmE+1JaD5VFPyRAA07qUzy
         69cJco84cJ5peFf9mL/XW22rmZzjDJ2jtYKUvI5CixKK9Otrv+M0IQHuIn+3PEV+IEjS
         rTafXAzYy6ymXHizGBUc+TBVWZQAzo0bV0cTpEAnq36GR1pXYd03S79moc2EfmjRjzOA
         j5Qz/S6eVe2e2SGvFUWRuNlrVjmPN9biU9REclat0gqviUZsKMhwNIan3SYTvWKyFES9
         xOJw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777917136; x=1778521936; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3RODZ6ZJLqPcgMt+PTjZg5DpfTcswq+tBneouSfN1S0=;
        b=khIwxxqpkt1Zn39W4IkSotSdHlxbg7MfQtDOtBE+xtCdIr85DeMEv8gHm9JoqNvEya
         megDboSOmQ9o8Cn+tWdlwISd6Ueyx7+vNjj7WyUsWzUU3KZsozQpNcV8eqbqz69amstV
         OExznk9LQZOFixWjjceD5Jfw11cGb2g582cUHF0BtOeylzMRE8WXmI0Pm3ytaqezkhGZ
         3QUUP8OoQLMjXnP8hHy+sEC3FMUa4CwDm8K2kbwGNTiDRpcSLX3SS32RJXoCctMQIhli
         jNLV86F/+XdxvYSzNKgofUikdQKeGfJhIu/Qi6f/shxfx2lbmS5GO/lr1CRj4i3O67WG
         BtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777917136; x=1778521936;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3RODZ6ZJLqPcgMt+PTjZg5DpfTcswq+tBneouSfN1S0=;
        b=VXH7E1RZzX7y/+ucPLCR37Qe0hGN9VNrs0J2MBS8iHPGESVSIpmGMEyAIrMU7iH1Pc
         8FW60tsw0hSAhOqPN7Cf39bnXUstVh7339mX6gRCWmvorQoI9jYQQeQOVSVSTdNlDBB2
         jvtv/SFTfRFfB+wh5vczSQuAx9fBhPyx9EdLrWI08ubNf/J7kdkAZdmxiIuUg8WcmvS6
         zvH3miYNs+I212TKNEBFyWgffCYF774n5Eo9zDcjoLV4woj9MiBJaFY71PBpQoVdOjmK
         lP8RMs0KyaA08Fc4p9Cw63GqwUuenOdMxGot6CCfMFJcOBtmVGwcv1Y93N17HqAQ/RuS
         4xoQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ym9VQ62yoQa4adoraZ3NPqrvySZ8i86U1Yq/5B/0oDEGYW7lvmy02YS/euvlHB9oMeVM/kY4f@lists.linux.dev
X-Gm-Message-State: AOJu0YwtUIl7vXcBgwcYXh8Ag1ou3elaZ5wmEBgEJ2TXwTRBhCpeBLDa
	kXV95GXI1f2RMpaXeurpIHsCG89VKO1SZIeMuy4iWh2far8qMWLL1QnbT1S4Lf0Z0hgZRAyAZlx
	Fr9rM15cmdGPdNAXzKOuveOhLIGBw2IY=
X-Gm-Gg: AeBDietANnsQKPDCimLLCkJazI+JAYGANv+DFYVN5+Ao8KvRVB+pg8UANQ1Hte5zoij
	wZLHyZdKqvkFok+27C+FL5P5aw2k/cQvvd7gekV170TIaZsq4ibi3teKfTpq1sunjv2FLcSkDx5
	Z3IKbHdBIkzuDhTnACY4dCFVMOMwSzIIB8dxDRxNUeBYm9rTP7Hkrf7J+3B0JQSoKBoyRA+Aaz3
	++uAHza2BoUYP0fSfM9xPbBYfWQeZZetjB6oC8jBOsFDAeuI5CCRkCJm43yzLXCUbtxZcUBMfK8
	DnRz8SXfYgYsmJS/SJQ=
X-Received: by 2002:a05:651c:3250:b0:38a:965d:79ac with SMTP id
 38308e7fff4ca-3937843e959mr40927771fa.12.1777917136062; Mon, 04 May 2026
 10:52:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Jay Sridharan <jayasurya.sridharan@gmail.com>
Date: Mon, 4 May 2026 10:52:04 -0700
X-Gm-Features: AVHnY4LdbNS-smkZyBC-T7gPo1476PKyo6xnUFyDX70hhh4PZLMSgrUMJPfF_i4
Message-ID: <CAGNKwhBekLJqcrNi3u+ZMKrpqU-6X7_1DXJ7Grpz=R8FkYrjfg@mail.gmail.com>
Subject: Re: Minor page faults from memory compaction causing in-band transitions
To: rpm@xenomai.org
Cc: Brandon Ho <brandonho667@gmail.com>, brho@relativityspace.com, 
	jsridharan@relativityspace.com, xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Phillipe,

Let me know what you think of this patch for the docs:

diff --git a/content/core/caveat.md b/content/core/caveat.md
index b24e270..e11d605 100644
--- a/content/core/caveat.md
+++ b/content/core/caveat.md
@@ -70,6 +70,68 @@ which depend on instrumenting the spinlock constructs (e.g.
 `CONFIG_DEBUG_PREEMPT`), you may want to disable all the related kernel
 options, starting with `CONFIG_SMP`.

+### Memory compaction and page migration impact real-time behavior
{#caveat-memory-compaction}
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
+- Launch EVL threads. At the end of initialization, but before
calling mlockall..
+- Trigger a memory compaction manually using `vm.compact_memory`
+- Once complete, call `mlockall` to lock pages.
+- Then, disable `vm.compact_unevictable_allowed` to prevent those pages
+  from getting migrated.
+- Finally, launch other in-band applications.
+
 ## Architecture-specific issues

 ### x86 {#x86-caveat}

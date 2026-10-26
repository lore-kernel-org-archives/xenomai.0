Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793033517;
	b=b5hdmY5LBag1486+W30roFYefkFR8j9z3aGPYmJvPU9Uz5cA+IHJ/SF/KdX6Wqxf2+9H
	 4Vb19WoYS8Qr8nKGKw9iYxrs6/fk8DANYOJz+29I2ZAVZcMIwhQbHHVb0XyMnDl559Pjt
	 xfv0mxIkX/IFSbJ4ZF0+5HBu8q0mHy+q4yO2MLLnokSp70SbLL+a51KZ4IpphBmNpJWmG
	 XTWvkSOr6NgNeVxWCzKB1+bMR/975kxgkKk4hRHkSMfUWgfLidV1AkwE39mokix4HHT9i
	 42pGtGjpbmSJxm9ZShO8bT6byefulE/zN3DDhdeNxk2mJWLB+77NE5+7IaPrcaez3Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033517;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Flowmailer-Platform:Feedback-ID;
	bh=wADtsCRLSg48z/ivaoYQYznrGxw3qeFlHPRBILDfvg8=;
	b=aL6QqOjdOr61zymll42mknAzQbxEggmVyIEjm6jTOaKxWvmGIoJ1XwNTllIO9nA7x572
	 JPn2cU2LNf9iQedoTFauLnJNJ4sg+1LZubLq4EHNxWtDrWL9dDXirJUmLaCbVv/LNDt+C
	 +PL/a+cn9ddYUIgup6B21SWwUSqfi2NIREGMXjZ3jfkNTillrSr0u/G7A7jwZOVe+DsKP
	 3JuDWJzdngd0eeMg5BwFH9Fj5J5LJX0FVJr0i/CHiSjunT2vUw4MF7brGkMVH9EizJyte
	 6Lx7pvERLYgM1T9oVr4Ie7LoYG+Bda56U1VQz9x6rGYFR/OR0ZA0rcanpa5NrwQwEjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=Ar9crYmn;
	arc=none smtp.remote-ip=185.136.65.225
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CC0606A323
	for <xenomai@lists.linux.dev>; Mon, 26 Oct 2026 16:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7CC0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=Ar9crYmn
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202610261651467c5ce8baeb000207e8
        for <xenomai@lists.linux.dev>;
        Mon, 26 Oct 2026 17:51:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=wADtsCRLSg48z/ivaoYQYznrGxw3qeFlHPRBILDfvg8=;
 b=Ar9crYmnirg1WeRcy3N1iMC6jx8XeB5rYWSw+vSc4K003vBp1cdMLL5fG8Q7acMtzn9BzP
 ql9ZwRjXgCeg7Ac+LoMrl9YLeIlcQ2lV7y22xjdFeW4f3h9Xq5YkIXrNO9CU2yUzkLi1ZbIR
 R1poCC3cZIhZdUp/MM4J5UQB8NjroKy8TlFmlmNuuEgf2P6gfWi7+cv8aaq+Oq6CaPUnYxn4
 loc2B8KK2ySRoWBsyEy/ks0p8Zz3M0CVUvsZwl4iqW7QmppFiszjKC/nk2FdVUsx7u8rlNys
 a+6g6nYq98zAmjpcOTFcBKHhON9vbQQ7wFMbfAgXP8kwFWMPLB9kjg2A==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 26 Oct 2026 17:51:45 +0100
Subject: [PATCH] cobalt: Allow naming of inband synthetic IRQs
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-wip-flo-implement-inband-sirq-naming-v1-1-f18ad0aaec7a@siemens.com>
X-B4-Tracking: v=1; b=H4sIACCF32oC/x2NwQ6CMBAFf4Xs2U0oBxF+xXjY2gVeQpfaEjUh/
 LuNhznMZeagohlaaGwOyvpGwWZV3KWh5yI2KyNUp67trq7CHySe1o0R06pRbWeYFwtckF9sEmE
 zy80F3wfp/aBUUynrhO9/c3+c5w9e0qcqdgAAAA==
X-Change-ID: 20261026-wip-flo-implement-inband-sirq-naming-a81db7da7b9e
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Cobalt registers two synthetic inband IRQs, both by calling
pipeline_create_inband_sirq(). As a result both IRQs were assigned the
same "name", which made it hard to tell which IRQ in /proc/interrupts
got assigned to the different callers.

Extending pipeline_create_inband_sirq() allows both callers to assign
a name to be shown in /proc/interrupts.

/proc/interrupts shows the names as below (example from x86/qemu):

  25:    <cpu stats> SIRQC          25      in-band sirq: select
  26:    <cpu stats> SIRQC          26      in-band sirq: registry

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/dovetail/pipeline/sirq.h | 7 ++++---
 kernel/cobalt/registry.c                       | 3 ++-
 kernel/cobalt/select.c                         | 3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/sirq.h b/include/cobalt/kernel/dovetail/pipeline/sirq.h
index 13eb020ac7c17ec06c52b43406cc68aa7f3e52a1..a533aad390492f61d4b786032ec35d92ee5bea0e 100644
--- a/include/cobalt/kernel/dovetail/pipeline/sirq.h
+++ b/include/cobalt/kernel/dovetail/pipeline/sirq.h
@@ -16,8 +16,9 @@
  * a handler on the in-band execution stage.
  */
 
-static inline
-int pipeline_create_inband_sirq(irqreturn_t (*handler)(int irq, void *dev_id))
+static inline int
+pipeline_create_inband_sirq(irqreturn_t (*handler)(int irq, void *dev_id),
+			    const char *name)
 {
 	/*
 	 * Allocate an IRQ from the synthetic interrupt domain then
@@ -30,7 +31,7 @@ int pipeline_create_inband_sirq(irqreturn_t (*handler)(int irq, void *dev_id))
 		return -EAGAIN;
 
 	ret = request_percpu_irq_affinity_flags(sirq, handler, IRQF_NO_THREAD,
-						"Inband sirq", NULL,
+						name, NULL,
 						&cobalt_machine_cpudata);
 
 	if (ret) {
diff --git a/kernel/cobalt/registry.c b/kernel/cobalt/registry.c
index 3e4bfc46051c0f8348f391beebf13c6051bfc859..2a10a19f36351e84a9582af9c03773624130fec4 100644
--- a/kernel/cobalt/registry.c
+++ b/kernel/cobalt/registry.c
@@ -126,7 +126,8 @@ int xnregistry_init(void)
 		return ret;
 	}
 
-	proc_virq = pipeline_create_inband_sirq(registry_proc_schedule);
+	proc_virq = pipeline_create_inband_sirq(registry_proc_schedule,
+						"in-band sirq: registry");
 	if (proc_virq < 0) {
 		xnvfile_destroy_regular(&usage_vfile);
 		xnvfile_destroy_dir(&registry_vfroot);
diff --git a/kernel/cobalt/select.c b/kernel/cobalt/select.c
index 70ae9a07d52680a6d56b6811d15b26025482342a..544fbf7da90ebe796c2e1ddb07c5bd9c793b677f 100644
--- a/kernel/cobalt/select.c
+++ b/kernel/cobalt/select.c
@@ -441,7 +441,8 @@ out:
 
 int xnselect_mount(void)
 {
-	deletion_virq = pipeline_create_inband_sirq(xnselector_destroy_loop);
+	deletion_virq = pipeline_create_inband_sirq(xnselector_destroy_loop,
+						    "in-band sirq: select");
 	if (deletion_virq < 0)
 		return deletion_virq;
 

---
base-commit: cfffefd3dc4c44cdd5376e9e0b03eba7c95f2d6f
change-id: 20261026-wip-flo-implement-inband-sirq-naming-a81db7da7b9e

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>


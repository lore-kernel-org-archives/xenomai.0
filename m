Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF8833D4F6
	for <xenomai@lists.linux.dev>; Tue,  3 Feb 2026 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770124553; cv=none; b=tNPZV05NX00rwbZMSOi+wm0ijdRK3sSYz+CL5bhfJrp+319O2LXpWVdFLp/UWUgXM2HCWxLqqe8wSQVnuxNk1a0Vsimn70XMWwt5Zj7YvmElH5Zzy7TopZB9b6YG8HEv9iL7KGkq9O6H6RSZofoSQN1KPMlCa1ONIBOOs3A4Tek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770124553; c=relaxed/simple;
	bh=0TbFWKE7ER71jsSm3ryuK8nTcHEL/Dozp7gEfr8+YaQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LSjn8L8K7dmKTNVOP/93asqb9wuSSR9Aqeq8krqKvNaY04w7jeydGwdOGyI7egeRjW+m69EHWO05M0Gp9aLe3iwerh4xsr9/cApH9q6UUZ/hX7pIRWvVus7Mymo2WYHe+wLB79NmVNHRFrPRFXejmQXqFxK1RTRwaQUob6diMPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=MhfMr02h; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="MhfMr02h"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 5748A581A9C
	for <xenomai@lists.linux.dev>; Tue,  3 Feb 2026 13:08:22 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4318A42888;
	Tue,  3 Feb 2026 13:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1770124095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kD90XYShgw2TImFbxIlknWkbrOdiZDIBykSNb7nk8ag=;
	b=MhfMr02hlkkw75c/Q3QwhLSJv1KLN5aNlIiiAB7PgqZlUc4JpLf9SnWFkEL2IdjKLmv/aw
	54v9yQvlawADdTozq74Ov8C3ekf9SpvRNetZ4T1DHGwduPy41uf9ebiDy22hBCL3C2bxkH
	je2esvejqYSzNF0nINY06bXZkVDvf2BSLXbIHwPZYdvH9fsf23l8cXVnVYxC8o7MGTdIIv
	ZoApAGop+MbXV5WgcbOlATqiGHx4X/fh62WkcfU98QW8mt8vEXqkWcpHqOMzW3M7WstP1Y
	1Z9OGQqtAar19isW/dgihnc8i7o1HXkGPQlCE8Sw0kyHxlTHZoqk+DQJJXTYLQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.18 1/3] arm64: irq_pipeline: Fix mapping of
 SGI/LPI IPIs
In-Reply-To: <20260201-wip-flo-fixes-for-6-18-v1-1-91ea07c7eb7e@siemens.com>
	(Florian Bezdeka's message of "Mon, 02 Feb 2026 08:55:20 +0100")
References: <20260201-wip-flo-fixes-for-6-18-v1-0-91ea07c7eb7e@siemens.com>
	<20260201-wip-flo-fixes-for-6-18-v1-1-91ea07c7eb7e@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 03 Feb 2026 14:08:14 +0100
Message-ID: <87o6m6vutd.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedtudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepgeefudekteegvdekkeekpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> There were two problems with the mapping:
>   - We stopped mapping after OOB_NR_IPI (3) IPIs.
>     There are more IPIs after the last IPI reserved for OOB

Yes, but we don't need to care those, since the code should never refer
to IPIs past OOB_NR_IPI when pipelining is enabled. The last issue
regarding this would be the out-of-bound access to ipi_count[], which
your other fix addresses.

As I understand this, e.g. on a two-way system, depending on SGI/LPI
modes, we need to hook:

in SGI mode, e.g. with IRQ0-3 globally available for mapping the IPIs on
all CPUs:

CPU0: SGI0 -> IRQ0 (in-band), SGI1 -> IRQ1, SGI2 -> IRQ2, SGI3 -> IRQ3 (oob)
CPU1: SGI0 -> IRQ0 (in-band), SGI1 -> IRQ1, SGI2 -> IRQ2, SGI3 -> IRQ3 (oob)

in LPI mode, e.g. with IRQ0-3 and IRQ4-7 available from CPU0 and CPU1
resp. for mapping the IPIs:

CPU0: SGI0 -> IRQ0 (in-band), SGI1 -> IRQ1, SGI2 -> IRQ2, SGI3 -> IRQ3 (oob)
CPU1: SGI0 -> IRQ4 (in-band), SGI1 -> IRQ5, SGI2 -> IRQ6, SGI3 -> IRQ7 (oob)

The root of the issue is the backtrace code bypassing the logical IPI ->
SGI0 mapping in smp_cross_call(). In this case, requesting
BACKTRACE=IPI7 without remapping to SGI0 would break in LPI mode,
because get_ipi_desc() returns NULL for that one. So my understanding is
that we must ensure that arm64_send_ipi() for in-band IPIs never escapes
the IPI->SGI0 mapping, instead of installing IPI descriptors on the
whole range of IPIs. We must also fix the IRQ mapping in the LPI case,
which wrongly maps everything to the IRQ range used by CPU0, which makes
no sense, as you pointed out.

>
>   - In the LPI case everything was mapped to the IRQ desc of CPU 0,
>     which seems odd. Each CPU has its own LPI used for multiplexing
>     inband IPIs.
>
> The following splat was observed whent trying to handle a backtrace
> IPI. This is one of the IPIs located after the OOB IPIs.
>
> [  115.357495] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000048
> [  115.358088] Mem abort info:

A simpler fix for the mapping issue: we only need to factor in the base
offset for IPIs in LPI mode:

--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1020,12 +1020,12 @@ static void do_handle_IPI(int ipinr)
 
 #ifdef CONFIG_IRQ_PIPELINE
 
-static inline void map_oob_ipis(int cpu)
+static inline void map_oob_ipis(int cpu, int offset)
 {
 	int ipi;
 
 	for (ipi = OOB_IPI_OFFSET; ipi < OOB_NR_IPI + OOB_IPI_OFFSET; ipi++)
-		get_ipi_desc(cpu, ipi) = irq_to_desc(ipi_irq_base + ipi);
+		get_ipi_desc(cpu, ipi) = irq_to_desc(ipi_irq_base + cpu * offset + ipi);
 }
 
 static void ipi_setup_oob_sgi(void)
@@ -1033,7 +1033,7 @@ static void ipi_setup_oob_sgi(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		map_oob_ipis(cpu);
+		map_oob_ipis(cpu, 0);
 }
 
 static void ipi_setup_oob_lpi(int ncpus)
@@ -1041,7 +1041,7 @@ static void ipi_setup_oob_lpi(int ncpus)
 	int cpu;
 
 	for (cpu = 0; cpu < ncpus; cpu++)
-		map_oob_ipis(cpu);
+		map_oob_ipis(cpu, nr_ipi);
 }
 
 static void __smp_cross_call(const struct cpumask *target, unsigned int ipinr)

-- 
Philippe.

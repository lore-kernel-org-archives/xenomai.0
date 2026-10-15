Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D63B481AB0
	for <xenomai@lists.linux.dev>; Thu, 15 Oct 2026 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070354; cv=none; b=OD1ZBJjLOEfmb2GQYmq09uLza4LPyaoebQbAUQFm8fuqzN4wCMURyWfX4/DUljkydzmYgyVahs1mzEqzYNW9t2d/RlzaAEXBxaeCULq9QLD7pnCmi3aQCl/CoSR6vaHOyAPkF0/sUwK/UvMudHIFC2TBZS88Ga5v2k+qTjAtXkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070354; c=relaxed/simple;
	bh=M4ONd64+EuGhdW1UiYsQnVWOK+dJQ/V+LVIyHVmWIJU=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=CZNK0SOY9GIylvNFMffJrOCKJ5Iy6bEBeFRERJGnbcx9esTV15OsBc3Rhc72ytq/BgI39msrNE3wfq9g6NpZHNK63VREP7WRuWNm8YzZQ0DiXF7y11VNvgXF6/OszsjlDWfSp4+Mq73an/B7b9kqPjKJOSJPRsSwzMlhFDTtS7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ah5ILXaY; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ah5ILXaY"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202610151308534d6a82dd0200020714
        for <xenomai@lists.linux.dev>;
        Thu, 15 Oct 2026 15:08:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=wKgTVTh1TD9S4xy3Ni+TuTs6gJjCW2Gl712f0lxnh2U=;
 b=ah5ILXaYh2NUUPakeF1PwqCLyQp8UrmdPdHyfxv7OZz26lhUrJUv0GHmqrPGmqMYAPCPru
 urd6wxE/bpqZ5iKHDXs+7jlfgU1YSAi6nhmZLvuz7+LZLtpj5nk0YzFE9iQ7xsaQIarlADo1
 fckF/uTNM9Z+jBG/SLohmQJbhwS8kJHiEiJNKvIGBjZBGug0CW4ja0qq1XNosGuByYZBox5N
 etOeRdDhLjGCgaaJtirNq1SQorJG0nWqB09b8ViQlN5LaZk55trqDNh018fTeAvslvK/K6/Y
 s9PNAJ2nhyeBwKUVTlU4InoZ3D+vcP2nm4O8fUOPfa4gJOA6fe5HJxEg==;
Message-ID: <bcb7c74d1f1757ca0764864fa1a840bb122ed5a8.camel@siemens.com>
Subject: Dovetail: Review-Request for wip/flo/v7.2.10-dovetail-rebase
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Date: Thu, 15 Oct 2026 15:08:53 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi Philippe,

I just pushed wip/flo/v7.2.10-dovetail-rebase, a rebase on top of the
latest 7.2 stable branch.

Files I had to touch:
	arch/arm/mm/fault.c
	arch/arm64/kernel/entry-common.c
	drivers/pinctrl/sunxi/pinctrl-sunxi.h
	kernel/time/clockevents.c

I'm going to schedule a CI run now. In addition, it would be nice if you
could have a look / review the changes. It's quite minimal, but as
always I might have missed something.

Next step is moving to the 7.3-rc baseline.

I had to apply (not part of the branch yet)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 12641375571e1..c1c20df9b14d4 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -12,6 +12,7 @@
 #include <linux/arch_topology.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/irqstage.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/sched.h>

to get the following build failure fixed for riscv:

In file included from ./include/linux/spinlock.h:59,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:17,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:14,
                 from arch/riscv/kernel/smpboot.c:11:
arch/riscv/kernel/smpboot.c: In function =E2=80=98smp_callin=E2=80=99:
./include/linux/irqflags.h:256:25: error: implicit declaration of function =
=E2=80=98unstall_inband_nocheck=E2=80=99 [-Wimplicit-function-declaration]
  256 |                         unstall_inband_nocheck();               \
      |                         ^~~~~~~~~~~~~~~~~~~~~~
arch/riscv/kernel/smpboot.c:261:9: note: in expansion of macro =E2=80=98loc=
al_irq_enable_full=E2=80=99
  261 |         local_irq_enable_full();
      |         ^~~~~~~~~~~~~~~~~~~~~

I think we should better address that in linux/irqflags.h, as that is
the place where we use it, but that triggered another include horror
show that I did not investigate yet.

Best regards,
Florian

--=20
Siemens AG, Foundational Technologies
Linux Expert Center



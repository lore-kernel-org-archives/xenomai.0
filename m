Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91730569F29
	for <xenomai@lists.linux.dev>; Wed,  9 Sep 2026 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964389; cv=none; b=mfUFy6DtjZzaY4u6qgd60YGN5n0FuiIwrOzjwLewR+IygchKdVRR1TsDbU5MBZgadx1t0jWuZtuYsc7k+yp89aOuEsCBWIGgVAoXm2/pBIZtBxaiFDB6rDc7RlhjXegarpLmpI69N/Ypf9lX4DvYgty9xBRzObsTtjQp4SJCc/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964389; c=relaxed/simple;
	bh=bg5eZqzCOFZ9aa1hhyzpbxT8fQt0lQzG2ZNUZmp/mc8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lXLjlYqRHTbI4dBDE98mvmvURICdOEz9CZ/HI95dc76cobN6IuamsX3C6Xi0GLvkSjCmyw4Am7GSOGUIHhccB1VkNLmx33xN4RipXoppbpnb0ZFaTjrLkBDo7s0t0U5mjKgNxbAGGjHWj27/r+1HnsH1RP49qzN1FEeG35na0D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=f+FuB14I; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="f+FuB14I"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260909143300eaa64b0ea50002074e
        for <xenomai@lists.linux.dev>;
        Wed, 09 Sep 2026 16:33:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=xegYp5XvJYH2qwb302hdNnvNrFCjyTUyIwQJgZnJW10=;
 b=f+FuB14IczF3xyJGGO1I9+zxOIlz4Zmfn4gq4x3agLIB4VRjO36LicgpXX1cR4ys6DdWAa
 fjm+M+4YoQ5TLCaPTdjxuOrrG0Om+Dw15xbhsQJoUo8vxjtdg+FHgm/AW6zivymAwOPFkltN
 GCceSlJc8PxJRiepKb0kil+zYY6BbNOFvchsuzDd6hfbJPBZMajRCpwAUwsIVPMAG5mQUJyG
 BxZuCvg9uaBBQl7pYCpzN6+zua3DU5m2MBAh+91SlUiyW7qp/hIiuJnMShPumotsojR+9krU
 YrWfi+XzBWerTvu9jnqGpaFEoEuij1CNeZkbde1CQuD3hLTvA0zxlNLw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail 0/2] Obsolete marking tick IRQs with IRQF_TIMER
Date: Wed, 09 Sep 2026 16:32:57 +0200
Message-Id: <20260909-wip-flo-v7-2-irq-cleanup-v1-0-825a908785ae@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABluoWoC/x3MQQ7CIBBA0as0s+4kFLSkXfcWjQvEwU5CgIKiS
 dO7S1y+xf8HFMpMBebugEyVC8fQMPQd2M2EJyE/mkEKOYpJaPxwQucjVo0SOe9oPZnwTjhe3V0
 rqy5ustDylMnx979eYYmVXoY93M7zB+poC7h0AAAA
X-Change-ID: 20260907-wip-flo-v7-2-irq-cleanup-65fb73c34f9c
To: Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>, 
 Gerte Hoogewerf <ghoogewerf@lmi3d.com>, 
 Andrew MacPherson <andrew@elk.audio>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

The following is the try to fix the problems reported by Gerte and Andrew.
We forgot to add the IRQF_TIMER to some of the arm/arm64 clocksource
drivers.

While the patch provided by Andrew [3] is correct, I tried to find a way
to get rid of this Dovetail specific IRQF_TIMER marking, as it could
easily be forgotten.

Review comments and intensive testing is highly appreciated.
Tests were done on qemu for arm, arm64 and x86.

If accepted / merged we should clean up the dovetail IRQF_TIMER markers
afterwards.

Best regards,
Florian

[1] https://lore.kernel.org/xenomai/CAKndYJF00RPbfD7U8YCAn_vzxDFdtwz5m9O=JVqhH5fdXHxY9w@mail.gmail.com/T/
[2] https://lore.kernel.org/xenomai/CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com/
[3] https://lore.kernel.org/xenomai/20260907083708.2566-1-andrew@elk.audio/T/#u

To: Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>
Cc: Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Cc: Andrew MacPherson <andrew@elk.audio>

Suggested-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (2):
      genirq: irq_pipeline: Remove irq_is_oob()
      irq_pipeline: Introduce IRQ_TICK to obsolete IRQF_TIMER on tick IRQs

 include/linux/irq.h       | 11 +++++++++--
 include/linux/irqdesc.h   |  5 -----
 kernel/irq/debug.h        |  1 +
 kernel/irq/manage.c       | 11 +++++++++++
 kernel/irq/pipeline.c     |  3 ++-
 kernel/irq/settings.h     | 17 +++++++++++++++++
 kernel/time/clockevents.c |  3 +++
 kernel/time/tick-common.c |  5 +++++
 8 files changed, 48 insertions(+), 8 deletions(-)
---
base-commit: 58e8e0f74c2b20f6228b7d327ec2e955ffd5b491
change-id: 20260907-wip-flo-v7-2-irq-cleanup-65fb73c34f9c

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>


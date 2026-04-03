Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782CF38E5E1
	for <xenomai@lists.linux.dev>; Fri,  3 Apr 2026 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775220968; cv=none; b=olmupLFpEBcOCGHwkJKiz10XRslHUrttLja2eUkenS56qjTblBYxtincOaW+EIVp3g3W5TTm8/jJ2QSQ+cDyIwN5MyQ6Y/F/+8sL1MSZBSIoJ1I9+4jJlXfcXopSCU0Td6vdp6hKfTuLJnJGqeLYjCBqPfurblQwaDFM02gefJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775220968; c=relaxed/simple;
	bh=WbAxjKayaSPB70b3GLbjkwzTXILxAUjO+XaEadPmnEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AIwC4ZxVIQoBi2aTpUGMgbR3zIWuVx4jKAJNqjpZjjWyRQFPVlM9reejDTMUwWe4h2GwBX161XbIIC/qOcJrls7fD/ows5pqy7QgWvdEsOMkUvbuZ1PNVeJaHRVg7tg0uQ5Pm9Zg3yLW58ObhzZDBVSM4bqyNqN3Yfr32ASuTu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=LTnYrvgz; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="LTnYrvgz"
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB6703EC00;
	Fri,  3 Apr 2026 12:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1775220953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=khPTqxBstELS50AIX4vP1KM6cU5xYUihyRRJlW7Ccxc=;
	b=LTnYrvgzgwff5ZL9a1Rxe8F2S6jZJx3vIYCE2cFsCeBZ8pePq1WHE/96996tkAio5qQRbq
	dLGk08pc4NWsXjb2qy6iANZtxyVTGG3sL3HsYBr30YO2TtL3R+PlcBk1QKSsZ4O34tZFuL
	rJ/WyoW8zN8jV2klunN8L2+uGW72VyyBoOtM3ujhv04psKXoKzj5axjxFP7vLYv7GDJuiT
	DtJHl9zlA1oYLVTlh17KMaCFAzru09JSjMo8sucAXbsK21RUptti2G/Spxh0yaqLdOgXMo
	4UAhb3PO45mPjbfWkQ9V1VKJoR9BTcogSeTSt9KqWCzeo4Moq0sgF6jM1PeQSA==
From: Philippe Gerum <rpm@xenomai.org>
To: Brandon Ho <brandonho667@gmail.com>
Cc: xenomai@lists.linux.dev,  Brandon Ho <brho@relativityspace.com>,  Jay
 Sridharan <jsridharan@relativityspace.com>
Subject: Re: Minor page faults from memory compaction causing in-band
 transitions
In-Reply-To: <20260331231457.141480-1-brho@relativityspace.com> (Brandon Ho's
	message of "Tue, 31 Mar 2026 16:14:47 -0700")
References: <20260331231457.141480-1-brho@relativityspace.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 03 Apr 2026 14:55:52 +0200
Message-ID: <87v7e8yzhj.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTEdagt0iHga7aqLIH7yI1jzymlhScji7Rt5BTnEy+BPW9uuulqGRWF+BFE4Z7jCRalKY0wCxhhmotT3ICkxvKhNiGS2edVGVvrq9H/8uZXV1a0C3b+Ll/4vD9iIZdy3y5WKmOwN2Ob0oleUGGqT+ihylhcyH1aRzDfXyWnPc635AUf1auqomkAq/RrLJpaVpHqpX6U0JWFaKRc5t1H4UwkwMMKkJDnSLApfrD9llMsaCBBFjbifEyCmTU1FlG7FBa5xsx6bWlTsVkgLUwNsHuX9fse/BJTbfA//m/EZa4uzgngv6dzG4qlHNP0ZVjp9UhffsF2oFsxLtsZbpbjQbAJJKt7nMd9BR6LOkD7x+VWuvcX1QnZY0YpXQYl5uVTIcRPN4JQmKfrA7uHuUiMBI0BieHMnsSA2yKAJ0IGJ2Fwo8s7rTE3bOolTIj93+3YP7SoQVsByT8R0fn3woZBWdkzt0BJWVTR4S2GoA+DFVW25sjA/KLaP4EvxmUgcUpUQXxbn/ur/UwT6N7o0vzKawa7HAG5aRHfM2bM+9ninUPNEeFJOWG966bH1MMsYnF0X8ZFRsDvszLWoMRs1z/fKYgQ2pD5I02YllIoAcZS1Pa+ZUHU//WANkhQpkMxlMkgcFV3TX0s+YE4I8JBzqtqb/Obs60Gxmy3Y93uP742HdEGdyw
X-GND-State: clean
X-GND-Score: -100

Brandon Ho <brandonho667@gmail.com> writes:

> Hi Xenomai team,
>
> I'm working on a real-time control application using Xenomai and we've been
> experiencing unexpected in-band transitions caused by minor page faults during
> kernel memory compaction. Even though our RT threads use mlockall(MCL_CURRENT |
> MCL_FUTURE) and we've pre-faulted memory, the kernel's compaction process seems
> to temporarily invalidate PTEs on our locked pages, causing faults when the RT
> thread accesses them.
>
> Has this issue come up before?

Yes, this is a known issue.

> I'm wondering if there's a mechanism to reserve
> a section of RAM that's excluded from compaction/migration entirely,
> or if

Not to my knowledge.

> there are kernel/Xenomai configurations we should be using to prevent this.
>
> Any guidance would be appreciated!
>

As Jan mentioned, the only way is to disable all options which select
CONFIG_COMPACTION ATM.

-- 
Philippe.

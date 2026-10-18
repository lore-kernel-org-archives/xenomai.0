Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8845349B15
	for <xenomai@lists.linux.dev>; Sun, 18 Oct 2026 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792313117; cv=none; b=RDzmt3dw+ut6sOv7dFqxMXR/uHfsMC37h36MpH7XNYHjIdBUnnZ9g22jJbfMsqAv+sjJJ8xbSZ8+skal8jd+ZeFQWcxm/Nq5O+drTPOj1FsM2e7z5Xk7rWz1XFfLdDy3ipjKNcgfnpL1rjaA1Pt+GW6Kf0zLNAG8lNulNSg35mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792313117; c=relaxed/simple;
	bh=WqGIIHyQcEZiA6zVUskjUiZAgOu7DaUsEJbvyhCZsAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SHDOgysr/mDRxDbUjiq1rMlGqXVdG92/+xZJdNMnVi2A843tIdXIPMf3Jz96rd/jhm4wbNBCOU2XkEzV+XsVLWsMnwLnF1bu9mgA8OMhzxKd2HJJK0cy1DMEEFP/hDh69pPaOfHELHXiwdmh5vhFpiMAHZYwwRFVGoLk9jp/2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=WrQeZkZj; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="WrQeZkZj"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A373E3EBAF;
	Sun, 18 Oct 2026 08:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1792313107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nC5u/EoS8l6MDsTskyYk0ixuj/gymYEXxaNiknoyxEY=;
	b=WrQeZkZjXQCS0d4ZJlDBR1+5vQAWXdmXbsP/v6MJUnYTKKckIaFAAhVGpEr2fRFZdoa/TU
	O8tNg75/lSW+Qil1jteQ4USaxLjgcLJ8lGYBY1oxoNokGvoQs4fhPgkFSaMKigi+oHMWaY
	hLPtgxg35WqA9i7y1wSkhlmN3c7aQ3t7Yu9KQauqKRQAV+UnT8XcxdHR0ckz07bqw9psLh
	goTyMV3QuvbSmqRvhq4egV01aRTUHbzJtrDiNJwtuNFo5EeksFO4o+TrpPKy1e7e+Pak2p
	dJa/FVtuw/BIQ0smU8QJLSrFtp83gSXBPcO9KiInWWyNMcihibE8tT9OCZiF2g==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Gerte Hoogewerf
 <ghoogewerf@lmi3d.com>,  Andrew MacPherson <andrew@elk.audio>
Subject: Re: [PATCH Dovetail 0/2] Obsolete marking tick IRQs with IRQF_TIMER
In-Reply-To: <20260909-wip-flo-v7-2-irq-cleanup-v1-0-825a908785ae@siemens.com>
	(Florian Bezdeka's message of "Wed, 09 Sep 2026 16:32:57 +0200")
References: <20260909-wip-flo-v7-2-irq-cleanup-v1-0-825a908785ae@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 18 Oct 2026 10:45:05 +0200
Message-ID: <87fqy3wg6m.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTE1z09YK58XC+QDrq2laVs9WMtonBAPGbePGUfHomb+/4JRRTvJNz4H9FxPshinKe8kbCOQjo2WZezNT1zIOvBiZbP9H33GeVlUHoHehrcpb6/LHe6S+5WqO26EYMpr3vJIFIAxdh/YjfXqjnaxGj0CJ66LSmFldXi3NlZmK0mY8wbzeT83h0E6ek8H03raaKZQiSJ8KBPJtohNbXzBvrg4zPz/O9kbC9v+LTT8Yfnq7mSh+Cb7emRzYuDfsnsE28iaacS0hK9/t4B+oh6sjPQG9qU8zlohuUJ38xOzp7/tWAPHMTdqnugQnIHerZVDn3TBUg41wNzraHMztUsTF6+0jjBGxvA6/N2/lGpkV908/7mdWPbihk0R2tM1l+vrTEnr47qV/VlqphOHC9nSmBlNzvoN1s+rMh0nERvQk3epeasycRUvDTHCgknxBoz9a42Sw7oWR/3Zq1ke34n4Ae2Hs156VHfX37D9i873e4MAvzABH8TlBZjnIDBehhB+9q7ZBlrybT2z4OwdkGvfJvpUXJkPDu5bYAtN7KZM65f+i3T5Gmvxus46rpU8mARjz4rbw9GCdXkKr+0XlBd0NBARUIwv4rLiNyEVovqls29R0BE2WjElPFurgVXZyhhpueLS4AK2/evv+o6XyyIR9Sz54f7zE5Oejc0NtCSnq2u/zw
X-GND-State: clean
X-GND-Score: -100

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi all,
>
> The following is the try to fix the problems reported by Gerte and Andrew.
> We forgot to add the IRQF_TIMER to some of the arm/arm64 clocksource
> drivers.
>
> While the patch provided by Andrew [3] is correct, I tried to find a way
> to get rid of this Dovetail specific IRQF_TIMER marking, as it could
> easily be forgotten.
>
> Review comments and intensive testing is highly appreciated.
> Tests were done on qemu for arm, arm64 and x86.
>
> If accepted / merged we should clean up the dovetail IRQF_TIMER markers
> afterwards.
>
> Best regards,
> Florian
>
> [1] https://lore.kernel.org/xenomai/CAKndYJF00RPbfD7U8YCAn_vzxDFdtwz5m9O=JVqhH5fdXHxY9w@mail.gmail.com/T/
> [2] https://lore.kernel.org/xenomai/CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com/
> [3] https://lore.kernel.org/xenomai/20260907083708.2566-1-andrew@elk.audio/T/#u
>
> To: Xenomai <xenomai@lists.linux.dev>
> Cc: Philippe Gerum <rpm@xenomai.org>
> Cc: Gerte Hoogewerf <ghoogewerf@lmi3d.com>
> Cc: Andrew MacPherson <andrew@elk.audio>
>
> Suggested-by: Philippe Gerum <rpm@xenomai.org>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (2):
>       genirq: irq_pipeline: Remove irq_is_oob()
>       irq_pipeline: Introduce IRQ_TICK to obsolete IRQF_TIMER on tick IRQs
>
>  include/linux/irq.h       | 11 +++++++++--
>  include/linux/irqdesc.h   |  5 -----
>  kernel/irq/debug.h        |  1 +
>  kernel/irq/manage.c       | 11 +++++++++++
>  kernel/irq/pipeline.c     |  3 ++-
>  kernel/irq/settings.h     | 17 +++++++++++++++++
>  kernel/time/clockevents.c |  3 +++
>  kernel/time/tick-common.c |  5 +++++
>  8 files changed, 48 insertions(+), 8 deletions(-)
> ---
> base-commit: 58e8e0f74c2b20f6228b7d327ec2e955ffd5b491
> change-id: 20260907-wip-flo-v7-2-irq-cleanup-65fb73c34f9c
>
> Best regards,

Series merged with backports to v6.12.y-cip, v6.18.y, thanks.

-- 
Philippe.

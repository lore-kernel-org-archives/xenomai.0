Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4DB2580F8
	for <xenomai@lists.linux.dev>; Wed, 30 Apr 2025 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025380; cv=none; b=GCxlbJHwNRF/m3q6rQiG2Wssrz6ZhP6Q9nMacsU8GU6BOpxBhchwAjJZ2tHYHLV8UlgA0h3taDcH6agV+wtPl0EzF3FGg/B+lRbeCoPVOHIT0V8XZw6Tk51kNmv03nPH2T80z8E1RepShkePwrO2e2h9QEcN8W9ef4jcAbdhK6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025380; c=relaxed/simple;
	bh=cme36MMEysdtoGcZ1wK0i4rqjRAk66BzVgqIfBZiuEg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u4NFKDklq45ionAxqWetosC39fDOGnOUm/U8WCILgJnXEsFAtD7c9mJbB7q2KwgRJ2w2aaqBosVgH6GHWrSd0f6GLmIWfVdUUV9Mkiv6x/7xGXPNxiMQKYwla/3R9pNzvxCOCjcCDtIymSnAYDCji1w4vVVqmAdReoLtUuMlB80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=L8I3UPAL; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="L8I3UPAL"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202504301502536f44cabf789fecc1ec
        for <xenomai@lists.linux.dev>;
        Wed, 30 Apr 2025 17:02:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=cme36MMEysdtoGcZ1wK0i4rqjRAk66BzVgqIfBZiuEg=;
 b=L8I3UPALHvqx6yr5AfcUNRzYTTYxW2w0Yd3bhcCRNPIu/uOocn3hm2Ms7VnYwpN/znjP3+
 PWBHR8Vo9EZOvqVZoZAwg+rPJ0X5GyEzO8BRd6XvF1no7oIeULkuQ5mA0KA5HusGGyAh/MGK
 Le64+Skqw3f3nGhDjAZj3yMuw5QPyCEGzyQ5kNHsE0/+HhPIXvME3lHXIpNrQqG1aVBR12Gt
 kz3PbUzdixXs76+ouzpWLYfzWFLHJEAylEebgIxhAw1RpNApSpzJkBXE87CofSfTAIMHNUAU
 RIItfxvLQDaMBG30oWT3TXLP3spNyTDimY52qmIpPD47Qb4bBrmrXZgg==;
Message-ID: <3e3fca3538b2769396e4aac4b1f8a2e16197a6f5.camel@siemens.com>
Subject: Re: [PATCH][Dovetail] fix IRQ forwarding to the in-band stage
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
	xenomai@lists.linux.dev
Date: Wed, 30 Apr 2025 17:02:52 +0200
In-Reply-To: <8991b5d9-74a7-4089-9390-4937b119e010@siemens.com>
References: <87plgtg3r9.fsf@xenomai.org>
	 <645bc7bc-9c4d-475c-9596-2f5813e23689@siemens.com>
	 <8991b5d9-74a7-4089-9390-4937b119e010@siemens.com>
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

On Wed, 2025-04-30 at 16:52 +0200, Jan Kiszka wrote:
> On 30.04.25 16:14, Jan Kiszka wrote:
> > On 30.04.25 15:47, Philippe Gerum wrote:
> > >=20
> > > Could some (preferably several) people check the patch below for
> > > non-regression specifically on x86 with stacked irqchips? I ran into
> > > an issue with interrupt forwarding while working on the xenomai4
> > > netstack which that patch addresses. So far, so good here, but we nee=
d
> > > more eyeballs and tests for this patch on a tricky and critical piece=
 of
> > > code.
> > >=20
> > > This patch is against the Dovetail tree for 6.1.y-cip, also available
> > > from [1].
> >=20
> > Does it apply to more trees than 6.1? We could push that through
> > smoke-testing CI, but I suppose we also need "real" workload.
> >=20
>=20
> Seems it applies from 6.14 down to to 5.10. So, here is the CI run (for
> stable kernels):
>=20
> https://source.denx.de/Xenomai/xenomai-images/-/pipelines/26015

IIRC, we don't have the stacked IRQ chip situation in our lab right
now. I'm not expecting any problems here.

IRQ_FLOW_PILEUP always confused me. Happy to see that getting removed.
I will have a closer look on Friday as we have a public holiday
tomorrow.

Florian


--=20
Siemens AG, Foundational Technologies
Linux Expert Center




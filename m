Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990762EA16D
	for <xenomai@lists.linux.dev>; Tue,  2 Sep 2025 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756848327; cv=none; b=fbyzLlaMLJLGlMc3xF6Z03i2DOr0B3pOl+vZ47hF9NcfHfoBrqOQqC2KLmNRTjrZORx3sqOYMk6Br8SOdjwM+0Lonp5J3Nx4im0Fl43BL6XHZbzNIQ827BwyrOWMXGzD15fijjlYGqZKrxp+/1MDC/K+flWYDTWWSSQBCirHD1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756848327; c=relaxed/simple;
	bh=RMYuUSwtArWRM334ffAsRn62q7cg+AT4YI4J4bqw0EA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p6cnMX5nXw9c6x7u/AaLQKUErpDZZfxp/q2ILdAMiuIAmhbkOpfiFCwqOZ+GX0xgVBVwwj6aRxc8XGvnk1TtjMuOr+uZZbzvNy29abxA+K4dpNKZax20gwM+OaIVw7Lsz587yBKz305Z2CkcqczDx4caIrfRdRVrgB30mtDfSXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=djaGaEkN; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="djaGaEkN"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250902211504d86b2256ad000207e9
        for <xenomai@lists.linux.dev>;
        Tue, 02 Sep 2025 23:15:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RMYuUSwtArWRM334ffAsRn62q7cg+AT4YI4J4bqw0EA=;
 b=djaGaEkNzK20P5Xkt7BSDuMgzXxmdW1Pb694NX9naruRO+uOuCrJxwVkJLSVZrOImxncwR
 A/hUgcBrP8GuGqdq5rnASlTQ8BXdWEdnRZo74cclSMFoxJCgo6sI1dOJWLnbm0SKZt+a/snt
 M1gK2S9IO61i1N+c+m8sljkj4oQctQ97Jm7XiG9otS0AnELXt6lUKxc2LJvoXd/nqha086jq
 /AyaWFONmvJDbvxCcbO5nnLUyqP7C3eja7G3V5IyHUOiPB7UmhjHu1H3wP/xWPaNhGz3YFEI
 ZdedeCLpTgsVSxS4JrlsJE3OpC9WRlfZog4x17+XtTsLL/Srjprvl6KA==;
Message-ID: <9bf0622e5a30c984974470ca3c7425c73cb8fc8b.camel@siemens.com>
Subject: Re: [PATCH] cobalt/pipe: Fix invalid wait context in
 xnpipe_wakeup_proc()
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 02 Sep 2025 23:15:02 +0200
In-Reply-To: <bc5c15c2-3423-4d6e-b296-63797ef7ff31@siemens.com>
References: 
	<20250829-wip-flo-migrate-cobalt-pipe-to-irq-work-v1-1-43a7c06e676e@siemens.com>
	 <bc5c15c2-3423-4d6e-b296-63797ef7ff31@siemens.com>
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

On Mon, 2025-09-01 at 15:51 +0200, Jan Kiszka wrote:
> I was briefly checking if we have more inband sirq issues, but the other
> two users, registry and xnselect, lock different and unaffected.

I checked other x3 users of sirqs last week as well and came to the
same conclusion.

>=20
> But I'm still wondering if we need both irq_work and inband_sirq. And
> how to shorten the number of steps to the actually required minimum. No
> real conclusion yet, but thoughts on how to either obsolete one in favor
> of the other or how to avoid that we take another thread wakeup when not
> needed are welcome.

Seems I'm too late. Philippe already clarified this.

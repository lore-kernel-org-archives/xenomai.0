Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D144328629
	for <xenomai@lists.linux.dev>; Tue, 21 Oct 2025 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052439; cv=none; b=OIfF0EMOjwhgRhQkGUuqDEmOnnwHdVgz1/caDMtLgiq9gOOLyq5/xCwCuZS60kNgXxsGMh/kbxrOX6vPhaydMmXvQp+pHHBmzZK/ZNiArJQ32PEchNLA60MetXSXWjm7fJ59vyiI3l8gYnS3SBY5tX+b22enNQRnFmIYkeplT8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052439; c=relaxed/simple;
	bh=AswPhelLswarz4U0IptsEfoeplEiyzcWfnLvWdmw9fA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GR0s+5IN+QVxKvDtbL9+YmAlU1mskmO6JCkzWa5SW3VNSR7v1OaQLUW66K9Ih1mMonhGZIcvddKLNobbE86c3rkJD3rZvvTQ+Hjk14w+zXUYvzBaTyGPhMQACToWQAuScEY8UkwSasz2RXorFMXhnGIVxXHDfsmU05bk4IrX0LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Wv+2y8tQ; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Wv+2y8tQ"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 5B7EB583DB5
	for <xenomai@lists.linux.dev>; Tue, 21 Oct 2025 12:47:47 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BB19243E8D;
	Tue, 21 Oct 2025 12:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1761050860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sf07vKaTFOxLK1X+oNblEgQNG/DDSGBZvDmxiqGqlDw=;
	b=Wv+2y8tQKEp9D9mcG/zlO1qPxMHDrqcs8W1rz3MsVba3/Ac4BLL6uzE43VY8X5tQx9OHst
	8CQpC9U2rpu5pOJ8N3Sc1TclsoO1jpcAOV0Vuk1YeieWQWx6lJ9Wc2fwgdYK1szWlESVmV
	WCJiprfUJSUWa/yGuQeboxlJDMjyLlGaLdl9b2Rl4Lu90tKlDL51/AlSsVpTGeL3RFT8SG
	lk0xrmxxaK9sBYzFjkLI9qKNu+UUxOOKlYnlX3w4R2MdyKu4s9Qz+kt/TM5x/fPdTw1T9G
	HhLazZJk38xca2RZ5KuyqNL88/scnZAp0yT2++Y3JT0qlDFDNvI/wTxQ25nQHQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.17 v3 1/4] clocksource/hyper-v: irq_pipeline:
 Enable pipelined clock events
In-Reply-To: <20250602-flo-add-hyperv-support-for-6-15-v3-1-f3b45eaed2e8@siemens.com>
	(Florian Bezdeka's message of "Tue, 21 Oct 2025 14:23:11 +0200")
References: <20250602-flo-add-hyperv-support-for-6-15-v3-0-f3b45eaed2e8@siemens.com>
	<20250602-flo-add-hyperv-support-for-6-15-v3-1-f3b45eaed2e8@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 21 Oct 2025 14:47:35 +0200
Message-ID: <87a51kbevs.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Make the clock event around the STIMER0 pipeline safe. The
> implementation is following the same pattern that we already have in
> place for the x86 LAPIC interrupt / clock event.
>
> To get the proxy tick working we need to link the hyperv clock event
> device with the STIMER0 vector. This part is also following the pattern
> of the x86 lapic interrupt. Both have a fixed arch specific vector
> assigned.
>

Series merged, thanks.

-- 
Philippe.

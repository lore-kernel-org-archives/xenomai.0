Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7734825A2DD
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 22:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783461672; cv=none; b=ThacWCczIUTldlVX19hqFDXQ9Vu2TM3XVGDEv8ny6+6T0XZnTD/dQm27Bss0UsSpIZWH2osSYbUjmiMCYI3lMis+DVmIorYpRQSWVlkkvBQ/AlD8wRS4pmllLioJNp4h4c31Ty2ySELC2JybeFtoL7FUlTKWsDj8kM9/25lRJiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783461672; c=relaxed/simple;
	bh=nneWRHbfui83CjrdRIzfwcAt50te+Exc7A3MYzmsD7o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fVnXA4qAFel2Ddi1gGYJhW2tQoqlOd4CL6SDSSHKLG69GIL9essnY2+HTAyuxZs2wlvHDoyffW9uAX/7oqopDyUjOIStmqCH9g4cPGa01NFsaF01Zp3uNrKsKDKh6gAMFLmLUJ1Nhfkxy6x6G5KOFEfjSGvD30XH+d3OH75UhHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=r1G0tT7I; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="r1G0tT7I"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260707220105a90a9f4dbe000207ee
        for <xenomai@lists.linux.dev>;
        Wed, 08 Jul 2026 00:01:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nneWRHbfui83CjrdRIzfwcAt50te+Exc7A3MYzmsD7o=;
 b=r1G0tT7I+n43dVluSrbVNCzMAyXYPXuOttBXjFYI1/CQ3brlb2pgsVUFn1LcB/0UKPqisX
 loyYHWnzC49/mwQp9M6ShhQa628BVXmNydqnT/t4LcQ4BpDLBTQgc7jZQkqe/eMFAMMjz9+T
 FO5//YSutqsg2+SHV7CH9O4suLQjys2mch43usMK/gW0yCfZQadNJ+/aaeb4hLOugAhw+8ID
 0VT1X4tz9wVT4Zecw/x+FLlDV2Ea7Fq29l5OQ9iCWz8Va/rOSDoE9hiJ/ytj/safWPovguQk
 lugHZJVTMtgBk9aON+bJr+I9F+/Oql3pUm1qqF1x80x35LrLGPFsiE0w==;
Message-ID: <e17dae2e8bd38bec2f68c2e29215f8405a98f844.camel@siemens.com>
Subject: Re: [PATCH dovetail v10 00/11] riscv: Add dovetail support
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Schaffner, Tobias" <tobias.schaffner@siemens.com>, 
 "xenomai@lists.linux.dev"
	 <xenomai@lists.linux.dev>, "Kiszka, Jan" <jan.kiszka@siemens.com>
Date: Wed, 08 Jul 2026 00:01:05 +0200
In-Reply-To: <87tsqavr74.fsf@xenomai.org>
References: <20260706182927.281078-1-tobias.schaffner@siemens.com>
		<aea1bc068740212737bd02d3b6317dac1eb8fbc8.camel@siemens.com>
		<8bbe1df3070e3d031950851525c67386b03cd1e9.camel@siemens.com>
	 <87tsqavr74.fsf@xenomai.org>
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

On Tue, 2026-07-07 at 15:56 +0200, Philippe Gerum wrote:
> Ok, please strip the reference to "cobalt" in the CLOCK_EVT_FEAT* commit
> when reconciling the evl trees, this might be confusing.
>=20

Right. Done.

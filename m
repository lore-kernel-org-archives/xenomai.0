Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D07D40E
	for <xenomai@lists.linux.dev>; Fri, 31 May 2024 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717183791; cv=none; b=FywOdWDAX+y1IeImwYEvWLk5xVXmCxetKQOxIHMhDa0u9DfSt1kWqqm7tQIxEQ1WPhnp+SZPGG2pX3m/4Y4cVKmCE+jT3Vb+UOGCB6t5RyDCZ3/E966s1IAJRGDHs1MbPwJoeLwr7K6WjrFk63zKeK6nr6oWKBz6QRHBROtI7Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717183791; c=relaxed/simple;
	bh=pgquaSi8AEL6YZ+dVguODS/Ta5Xci4r6ak8bEU7fMUw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sfdT3SOJcblS+7FuMe2MF/rbVWBrV6r4gCPo4HC3t+ob7/VGSQQE7ACsv1/ijRCNvBTA6bGDdxrpR98tPzR0ATpMMekSCCfR1+wcBXpFoMdwjH7AATeHSb2bK2ziK1pBFa8oMpgQkBU0YbaFxUp/B/y3Uu7iGgfzUDyyvl7n8nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=vaG7YKjz; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="vaG7YKjz"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240531192936d55d0328e389897699
        for <xenomai@lists.linux.dev>;
        Fri, 31 May 2024 21:29:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RLr21RiNfc06aHzjvtN5N59qkDGZ+7gUxjU7KIXqmAw=;
 b=vaG7YKjzyxk9Y1YXfEMArCYhJi3mGq0EGYO4UA6TC+yAAi5bi5wCOi4ukdEBaY0gaThZl+
 qZ9TPDAhkpTv5tDT/PA9K9VB9lMzYn6gJDfKCMF7jlPzuZEJ58ElEX91Y5o52Bd/k/JAi9E+
 XP+lyAshqZFVOuMKPIkWMDqS90jX0=;
Message-ID: <b1960ceb203102668cc920aeec3b97e7f7c6387f.camel@siemens.com>
Subject: Re: [PATCH RFC dovetail 6.9 0/2] Input needed: Boot hang, dovetail
 6.9 as KVM guest
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Date: Fri, 31 May 2024 21:29:34 +0200
In-Reply-To: <20240531-flo-fix-kvm-guest-for-6-9-v1-0-1c895c256f8d@siemens.com>
References: 
	<20240531-flo-fix-kvm-guest-for-6-9-v1-0-1c895c256f8d@siemens.com>
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

On Fri, 2024-05-31 at 13:20 +0200, Florian Bezdeka wrote:
> @Philippe: Any ideas? Which way is correct?
> Patch 1 references a Linux commit that changed the registering part of
> the involved IRQ/vector. Is that considered problematic?
> idt_install_sysvec is now being called with the asm_ prefix as
> argument...

This is understood now. The asm_ prefix is fine, the low level entry
point has to be passed, we end up in the C world after the usual
trampoline code.

Still open:
With the first variant I get exactly one IRQ per vCPU during boot. I
can't see such "spurious" IRQs with the second variant (=3D patch 2
applied):

Taken from /proc/interrupts
HYP:          1          1          1          1   Hypervisor callback inte=
rrupts

Can someone enlighten me?

Best regards and have a nice weekend,
Florian


--=20
Siemens AG, Technology
Linux Expert Center


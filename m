Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942A53D9C
	for <xenomai@lists.linux.dev>; Fri, 29 Jul 2022 12:58:17 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::224])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id EAC8CCD5F9
	for <xenomai@lists.linux.dev>; Fri, 29 Jul 2022 12:47:13 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id A86FEE0007
	for <xenomai@lists.linux.dev>; Fri, 29 Jul 2022 12:47:05 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	by spool.mail.gandi.net (Postfix) with ESMTPS id A1E40D8067F
	for <xenomai@xenomai.org>; Fri, 29 Jul 2022 12:47:04 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 4D650240004;
	Fri, 29 Jul 2022 12:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1659098824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9UYLd79v0FqexMoYAMCe7cmIkMo82yaZMXSBPiZr7NI=;
	b=f7O6WFBSY0ydEzXV460FaZvqSwF4/CbKFa3djem5pihMEIu16AA1zm9cbIv1si8KdgRxwk
	HPae/ASCvBEBXyxbKAnb3tK56XW4bsZ14nTj4hAw/9LUp8goN25ZSupPRpvh6Z9UAThEdB
	cV7M6OG3mpl/sTrO3zV0AJjD8am15ILkiTtoman8YzZ8s7FOtPWOMUuZTxhCFC4kOowz4m
	gb9Nq11asO3sYuBG1aEti58MBx3i2aDMLdlAsbxCfvr4a6MYq35cT6U0ZLzI9FdtA+4sLG
	qnSks7VMCxI0dl7QTqj70019uTRFtRtblm8HqbDpByJGzjTrnX34Cc6cGGHg7w==
References: <CAAm9oxrU8-ohehSY2aUMc8acea2zGEzrvgi56nQzCiHv+gKv5w@mail.gmail.com>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Sri Subramanian <sridhar.subramanian@gmail.com>
Cc: xenomai@xenomai.org
Subject: Re: oob_recvmsg and protocol filtering
Date: Fri, 29 Jul 2022 14:33:15 +0200
In-reply-to: <CAAm9oxrU8-ohehSY2aUMc8acea2zGEzrvgi56nQzCiHv+gKv5w@mail.gmail.com>
Message-ID: <87sfmkjdbt.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass (spool5: domain of xenomai.org designates 217.70.178.230 as permitted sender) client-ip=217.70.178.230; envelope-from=rpm@xenomai.org; helo=relay10.mail.gandi.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b=f7O6WFBS;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 217.70.178.230 as permitted sender) smtp.mailfrom=rpm@xenomai.org


Sri Subramanian <sridhar.subramanian@gmail.com> writes:

> Hello,
>
> I am trying to minimize the latency on the network path of sending and
> receiving ethernet packets for a fieldbus application on a Raspberry
> PI CM4 board.
>
> I am using oob_sendmsg and oob_recvmsg (of course, the driver, in this
> case GENET MAC-based, is still using stock Linux, so this is not a
> perfect solution for now).
>
> I am binding the interface so that the allowed protocol is ETH_P_ALL.
> I am able to send the fieldbus packet with oob_sendmsg.
>
> However, on the receiving side, there is still filtering going on in
> kernel/evl/net/ethernet/input.c in evl_net_ether_accept() which checks
> if the protocol is ETH_P_IP, so oob_recvmsg doesn't push the fieldbus
> packet up the stack.
>
> So, 2 questions:
>
> 1. Is this right? i.e. should it be changed to accept the protocol
> based on the specified interface's bound protocol?
>
> 2. If this is right (or used to limit the OOB interface to only IP
> traffic), I am looking into patching the kernel function to allow the
> fieldbus protocol. Any guidance on the acceptability/desirability of
> this approach, or are there better avenues?
>

The current implementation is limited to my current use case ATM which
is conveying IP traffic through the ministack. The only requirement is
about allowing a NIC to be shared between regular and oob traffic
without proxying, hence the use of VLAN tagging for the latter.

Fieldbus traffic could be VLAN tagged IIRC, I see no reason to restrict
the ministack to dealing with IP if you can extend it to other protocols
in a reasonably generic way.

I don't have any particular guidance to provide for such extension
beyond what you already know. I'm fine with discussing patches to enable
fieldbus.

-- 
Philippe.

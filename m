Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E53D1854
	for <xenomai@lists.linux.dev>; Thu, 21 Jul 2022 07:47:13 +0000 (UTC)
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 2CF5D24000C
	for <xenomai@lists.linux.dev>; Thu, 21 Jul 2022 07:47:10 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 28E81740045
	for <xenomai@xenomai.org>; Thu, 21 Jul 2022 07:47:09 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id C9FABFF805;
	Thu, 21 Jul 2022 07:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1658389629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aGcFjtuknajhL0ZG3AQAUO4Dcs6VwbdsSDjJoxYESv0=;
	b=dSUSYU8XDrctX4Jl5SQpbg5hk58lElU9cb66CaDRY1TTazljfRBWQzfpsUK3P7xTyHoFSZ
	KTlSMSDxTz4rwaRYKQahQS8FrVZDvSZwqjW43B+o7XGD3xMJ1SeWtqpV6zYTSyt/lGRktZ
	2Onz0DVkgakkL+dLkZ5TXbWYtEAvrzhYOQQS21pbKX2v3Os/6EexUH0aewGPUaaa6pX1c5
	43pH1RPNQPuDbFvHY7Yu3nJOLMzcwf1rGuWlmF7zzlInUnEmlPRloFqqhhqU2rhMllUMT5
	2ne53FF9OawhCkIRJQjB3SfZVYqG9wivNT8J1d4U9qkwU2fzsRW7kyY6uA4xyw==
References: <CAAm9oxrn5pTSPH_AqrZ_0QakrL1LDsAW2GfA=ckejhnYFPOrFA@mail.gmail.com>
 <87fsj3d827.fsf@xenomai.org>
 <CAAm9oxq0qzdxx+KnbROMCHgNvp-xEZ99O90omY4zOxXtxsEpsA@mail.gmail.com>
 <CAAm9oxqa0Rp3x3QS_oteS7PX35n4W8TYZu1=7y6U_QC5G-3S=w@mail.gmail.com>
 <87edygmas6.fsf@xenomai.org>
 <CAAm9oxqx-P9O7cONgeGwud0BvsSWok7itGzqSZdc7NRCmFLdyg@mail.gmail.com>
 <87tu7bk76a.fsf@xenomai.org>
 <CAAm9oxpbtX2qXHPxOGCQre14_7T7jZtDuN=b5U2sA2B_su6ARQ@mail.gmail.com>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Sri Subramanian <sridhar.subramanian@gmail.com>
Cc: xenomai@xenomai.org
Subject: Re: Xenomai 4 / oob_sendmsg crashes kernel from tidbits/oob-net-icmp
Date: Thu, 21 Jul 2022 09:39:50 +0200
In-reply-to: <CAAm9oxpbtX2qXHPxOGCQre14_7T7jZtDuN=b5U2sA2B_su6ARQ@mail.gmail.com>
Message-ID: <87a692ewlf.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass (spool2: domain of xenomai.org designates 217.70.183.199 as permitted sender) client-ip=217.70.183.199; envelope-from=rpm@xenomai.org; helo=relay9-d.mail.gandi.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b=dSUSYU8X;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 217.70.183.199 as permitted sender) smtp.mailfrom=rpm@xenomai.org;
	dmarc=none


Sri Subramanian <sridhar.subramanian@gmail.com> writes:

> On Wed, Jul 20, 2022 at 10:47 AM Philippe Gerum <rpm@xenomai.org> wrote:
>>
>>
>> Ok. On my end, I'll connect a pi4 with the i.MX6, to add the GENET MAC
>> module to the picture.
>>
>
> It looks like the GENET MAC driver (or the interface) is the culprit.
> For some reason, it
> restricts the packets sent to 10 after every netif down/up toggle.
>

Weird. I'll trace that.

> I attached a network adapter card to the PCIe interface and connected
> that to the switch.
>
> Both the oob-net-icmp and my packet generator are able to call oob_sendmsg
> continuously!
>
> One anomaly I found in my experimentation:
>
> - When I try the USB-ethernet adapter, the packets are not seen by the
> EVL mini-stack and
> despite the fact that /sys/class/net/eth1.42/oob_port is set to 1 and
> control/net_vlans is 42,
> the packets are read/responded to by the Linux kernel and oob-net-icmp
> is just waiting.
>
> Previously I've used the USB-ethernet adapter for all tcp/ip
> communication to the device
> and it works just fine.
>

I suspect something is wrong in the oob traffic detection handler,
namely [1]. For some reason, incoming packets are not seen as belonging
to the oob vlan. Most likely something I overlooked when looking for the
802.1q encapsulation, which the USB adapter triggers.

[1] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/blob/v5.15.y-evl-rebase/kernel/evl/net/ethernet/input.c#L36

-- 
Philippe.

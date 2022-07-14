Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3E5290B
	for <xenomai@lists.linux.dev>; Thu, 14 Jul 2022 08:19:31 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 2D88060005
	for <xenomai@lists.linux.dev>; Thu, 14 Jul 2022 08:19:23 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 19AF9D80353
	for <xenomai@xenomai.org>; Thu, 14 Jul 2022 08:19:23 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id B0EB41C0007;
	Thu, 14 Jul 2022 08:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1657786763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YL+OUlgvNt8R9E/lHQ/hLbCTx3oUcxhN0lQcnKykCjg=;
	b=T5UwLk0796B8V33xDvT/vsDYI9o9LLjDfXkBBen/QiGxaIMqgLY2r0vLt4GCYxgdkG0NND
	XT6BwNHsCp4MqrAS43Ica1o0FotxDB9ao53+ilGXsVbIKPqW+rIyAp4TPZnfbl6pol87yT
	oaE/lOQvn96DC+3SNDHtOXZadY2+2bK5xHU7rcRiW6GHFPs6JNSB94euUI0xnJcSoYWoT4
	715W7UdpQC4UwDS8Os06uosOpAVdumETmxNwLzy13PixE99G8XCLeviNA2L5iH4493fDWq
	++sruBTnQuc66BVaDsgiG898SXBg1hF8EZPJ/Noi3gonDRkDAtgAmOn1LhuS1Q==
References: <CAAm9oxrn5pTSPH_AqrZ_0QakrL1LDsAW2GfA=ckejhnYFPOrFA@mail.gmail.com>
User-agent: mu4e 1.6.6; emacs 27.2
From: Philippe Gerum <rpm@xenomai.org>
To: Sri Subramanian <sridhar.subramanian@gmail.com>
Cc: xenomai@xenomai.org
Subject: Re: Xenomai 4 / oob_sendmsg crashes kernel from tidbits/oob-net-icmp
Date: Thu, 14 Jul 2022 10:16:23 +0200
In-reply-to: <CAAm9oxrn5pTSPH_AqrZ_0QakrL1LDsAW2GfA=ckejhnYFPOrFA@mail.gmail.com>
Message-ID: <87fsj4ds39.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass (spool5: domain of xenomai.org designates 217.70.183.197 as permitted sender) client-ip=217.70.183.197; envelope-from=rpm@xenomai.org; helo=relay5-d.mail.gandi.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b=T5UwLk07;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 217.70.183.197 as permitted sender) smtp.mailfrom=rpm@xenomai.org


Sri Subramanian <sridhar.subramanian@gmail.com> writes:

> Hello,
>
> I am trying to optimize sending ethernet raw packets (for an Ethercat
> fieldbus application) on a RaspberryPi/CM4 environment.
>
> Before implementing the application, I thought I'd try getting an ICMP
> echo using the "tidbits" sample program oob-net-icmp.
>
> I am using eth0 from a RaspberryPI (used to ping) connected to another
> PI device (CM4 on an IO board) also on eth0, which is echoing back the
> pings using oob-net-icmp. I set up vlan 42 as documented in the
> program, for both the devices. (I verify the network connection is
> good  prior to this by sending pings and verifying the echo responses,
> through the standard Linux stack on eth0).
>
> I also set up the ping-receiving device so the Xenomai kernel can
> route the packets up the Xenomai mini stack, setting:
>
> echo 1> /sys/class/net/eth0.42/oob_port
> echo 42 > /sys/class/evl/control/net_vlans
>
> On the first ping, the kernel crashes with the stack as below. I've
> tested on both versions 5.15 and 5.17 (both with CONFIG_NET_OOB=y).
> Thanks for any help or guidance.
>

Thanks for reporting, I can reproduce this as well. Maybe a problem with
the prep/recycling of socket buffers. Investigating this bug is on my
todo list.

-- 
Philippe.

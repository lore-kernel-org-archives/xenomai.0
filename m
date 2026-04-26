Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AFB1A073F
	for <xenomai@lists.linux.dev>; Sun, 26 Apr 2026 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777231455; cv=none; b=lvhgg3NEXdHKsxTvuPcm7R7Pqi1GpRjFaKl6pdNBf/m0tZPXlLOLfOv3O//YW7VqiSGnuOeeFcWEhbt/nQdLyfbMgVwwqj29bnsMcS3JE87/9PIxsWr5DVm3CYK/pzRkGGwjUSQwmEvxV+atQZz1Hg5wP9wyYdu/izZDTk6PxuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777231455; c=relaxed/simple;
	bh=rWo555zCk/Ge4aLlHvqVgXrmwiPMVa6lJauJREFW/RA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s9SuCgpFrAJv9Ua7vnfPjGN1NEVewbTMQzkN544suMD/kiSb1dA1icBfrteeGufph9RKV6s+qFaHWUi654h+oq6zfcsgVWzdbNaNe7ya4/KXx93/GvsEIRD1YDnH9pLSwpF9MiYdgiEIx4DjLHcw7Cx2RYfpRSx5Y4jhNfY+qVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=NnmvPDZc; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="NnmvPDZc"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42F3A3ED7D;
	Sun, 26 Apr 2026 19:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1777231445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9CGJVhJA4f6E0B7YuZZU0z9AllvAZo+eP2iCF5Id61g=;
	b=NnmvPDZcc10guZua4j71dmbUPr8QcIX6SM9mqOhyymwzkfHiQf19LQJmrX930lxk8jsKQx
	EbBhICXDg+nUsrl/eSHHYsTy+5sQ3uI3W3gOWsR444s6f7AjPNw00tzDazIkSA9s7l4qJg
	b76AdzFC/OkmdKZQsGgK9tmXyaA2AlRh2AKFYEk3LCnTtX2OojYmHpBbmwgUdc2TDI6j+K
	of7GPjEQ+iKdXS6GeIcfHp8plR6Jj3kGN7gFv6hfDzp1Q8f5RvVNJGISyo8cMFB3J0qf4P
	YaoQGu29TnDyY8F3zviIC4B7Mnm17wcuBRvAfTsw/m3MzXZ58T1ytF06U8YgRg==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [EVL] Kernel WARNING: notifier callback netevent_handler
 already registered
In-Reply-To: <201a7d9c-e1dc-4686-8a5e-adc7c921ba14@gmail.com> (Hannes
	Diethelm's message of "Sat, 25 Apr 2026 23:05:00 +0200")
References: <8e08bda6-1fed-4a5a-9bb3-74f019b05855@gmail.com>
	<87340ij2lx.fsf@xenomai.org>
	<201a7d9c-e1dc-4686-8a5e-adc7c921ba14@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 26 Apr 2026 21:24:00 +0200
Message-ID: <87jytt34q7.fsf@2a01cb0804738000b42250ae26cae50b.ipv6.abo.wanadoo.fr>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTGbOl7PjIlR8xtCv+lT8n7XJRHciFvg2wp2n9K9xKb8RoeaHRPTqaL5dTbUOgsNGkmFnB9UJ/bKVHASsPFLzKItarVwLzL0eCTRlAQp+a0Aw5941ociI6KtnT+Xa5QJb1xPYwFSgAlunTntc7hods1Ww+IlFBf7erSZ4n+wNUMSrogCHsp0kX0DURLMxowLHneVmdGfnYKtLW4DgkTmg+Pa99kU1ePe9Q7ABHRuamXafU4/enBFdPuu4Uo1Q9jK89pPX5YLzWM4qBscXJYqXbFggy+gpzhLtCb18jh6dqQLUqNKp4CFmt6aRms+b4VnBZZ/BkvDATV9JUbO61i/oJDpNqxfSzNcBTQ2ODzZPFOxxdDLNAY8fzqIlyD3fNphLgPYWEwxPHbbq9/MV2ZpBs9g2D5qcuvqoYWnyZ7yT87gb6q8XM41WLyKLIoKi+junwEQ62L0kEFRe+Nqk+nX3prlE6/5H6yGExeybi1n0WHRJ1clsM87LSzxLpaz02avyUTPghgqMqQ1HSgI06Qx4jChZXCT6Hr2Xqhb//u8ogjEQst5bKlTGtPmZBzvZKsY7+2rD6KApRA2+3KjgQ3GjueThEIZW/8vs9V0Ou9ylFdeqSNV5VI52qPMZ0Mq2RtC93MhLJuMx8JDAQ2O025SCfoUnUt1usi5NbtIKi0SL89vWQ
X-GND-State: clean
X-GND-Score: -100

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Am 25.04.26 um 20:50 schrieb Philippe Gerum:
>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>> 
>>> Hello
>>>
>>> There is a Kernel WARNING: "notifier callback netevent_handler already registered right after boot". It is repeated 5 times.
>>>
>>> Config:
>>> Debian Trixie with xfce4 Desktop
>>> libevl: r56
>>> linux-evl: v6.12.67-evl2-rebase
>>>
>>> I traced the issue already trough the following code:
>>> net/core/net_namespace.c:355
>>> kernel/evl/net/net.c:35
>>> kernel/evl/net/ipv4/ipv4.c:41
>>> kernel/evl/net/ipv4/arp.c:323
>>>
>>> However, I lack the knowledge to do a proper fix. One way would be to just check in evl_net_init_arp() if it is already
>>> registered and don't do it more than once but that doesn't feel right.
>> It looks like the system is instantiating multiple network
>> namespaces,
>> for each of which we set up an ARP front cache by calling
>> evl_net_init_arp(). Bad idea to hook a system-wide handler there as
>> well. Could you confirm this fix [1] works for you?
>> Thanks for reporting this.
>> [1]
>> https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/569beef061321c2c00d775b13ad0aec1a1d2a416
>> 
>
> Thanks, that was fast. The WARNING is gone now.
>
> But now after just updating to the kernel including your fix, I have a different behavior on
> incoming packages. It seams that the default when no filter is set has changed from EVL_RX_SKIP to EVL_RX_ACCEPT.
>
> linux-evl: v6.12.67-evl2-rebase
> -After evl net -ei enp7s0, I can ping another host.
> -oob-net-icmp does only receive packages when I use an eBPF filter with EVL_RX_ACCEPT
> -After that, ping doesn't work any more
>
> linux-evl: v6.12.y-cip-evl-rebase
> -After evl net -ei enp7s0, I can NOT ping another host.
> -oob-net-icmp does receive packages
> -If I use an eBPF filter returning EVL_RX_SKIP, I can ping again
>
> I am not using VLAN's.
>
> Was that changed on purpose?

Yes, this is implemented by this commit [1]. The rationale here is that
if you turn on the oob port directly on a base device, then the evl net
stack may assume that the device is entirely dedicated to oob traffic,
as opposed to enabling such port on some upper device based on the
former (e.g. a VLAN interface). As a result, all ingress traffic
received by such base device is diverted (RX_ACCEPT) to the evl net
stack.

[1] https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/3026e69cee2a1de047818fa06ad8c44623461a0d

-- 
Philippe.
